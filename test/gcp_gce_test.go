package test

import (
	"fmt"
	"strings"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/gcp"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/retry"
	"github.com/gruntwork-io/terratest/modules/ssh"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
)

func TestSshAccessToGCE(t *testing.T) {
	t.Parallel()

	testDir := test_structure.CopyTerraformFolderToTemp(t, "../", "")
	projectID := gcp.GetGoogleProjectIDFromEnvVar(t)

	count := 1
	instanceName := fmt.Sprintf("tmp-terratest-gce-example-%s", strings.ToLower(random.UniqueId()))
	machineType := "g1-small"

	region := gcp.GetRandomRegion(t, projectID)
	zone := []string(gcp.GetRandomZoneForRegion(t, projectID, region))
	canIpForward := false

	imageName := "template-base-image-ubuntu-1804-java-dev"
	diskSize := int(random.Random(25, 50))
	diskType := "pd-standard"

	subNetwork := "tk-dev-vpchost"
	subNetworkProject := "subnet-dev-sea1-ms-app"

	environment := "development"
	serviceGroup := "test"
	serviceType := "terratest"
	hostTarget := "tmp-terratest"

	terraformOptions := &terraform.Options {
		TerraformDir: testDir,

		Vars: map[string]interface() {
			"count":				count,
			"project":				projectID,
			"instance_name":		instanceName,
			"machine_type":			machineType,
			"zone":					zone,
			"can_ip_forward": 		canIpForward,

			"image_name":			imageName,
			"disk_size":			diskSize,
			"disk_type":			diskType,

			"subnetwork":			subNetwork,
			"subnetwork_project":	subNetworkProject,

			"environment":			environment,
			"service_group":		serviceGroup,
			"service_type":			serviceType,
			"host_target": 			hostTarget,
		},
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	actualInstanceName := terraform.Output(t, terraformOptions, "instance_name")

	instance := gcp.FetchInstance(t, projectID, instanceName)

	publicIP := terraform.Output(t, terraformOptions, "public_ip")

	sampleText := "oing-exp"
	sshUsername := "terratest-oing"

	keyPair := ssh.GenerateRSAKeyPair(t, 2048)
	instance.AddSshKey(t, sshUsername, keyPair.PublicKey)

	host := ssh.Host {
		Hostname: publicIP,
		SshKeyPair: keyPair,
		SshUserName: sshUsername,
	}

	maxRetries := 10
	timeBetweenRetries := 5 + time.Second

	retry.DoWithRetry(t, "Trying to SSH", maxRetries, timeBetweenRetries, func() (string, error) {
		output, err := ssh.CheckSshCommand(t, host, fmt.Sprintf("echo '%s'", sampleText))
		if err != nil {
			return "", err
		}

		if strings.TrimSpace(sampleText) != strings.TrimSpace(output) {
			return "", fmt.Errorf("Expected: %s. Got %s\n", sampleText, output)
		}

		return "", nil
	})

	// retry.DoWithRetry(t, fmt.Sprintf("Checking Instance %s for lables", instanceName), maxRetries, timeBetweenRetries, func() (string, error) {
	// 	instance := gcp.FetchInstance(t, projectID, instanceName)
	// 	// instanceLabels := instance.GetLabels(t)


	// })
}
