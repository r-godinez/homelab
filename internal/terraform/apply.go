package terraform

import (
	"fmt"

	"github.com/r-godinez/homelab/internal/utils"
)

func Apply(environment string) error {

	tfPath := fmt.Sprintf(
		"terraform/environments/%s",
		environment,
	)

	fmt.Println("\n[INFO]Initializing Terraform...\n")

	err := utils.RunCommand(
		"terraform",
		"-chdir="+tfPath,
		"init",
	)

	if err != nil {
		return err
	}

	fmt.Println("\n[INFO] Applying Terraform...\n")

	return utils.RunCommand(
		"terraform",
		"-chdir="+tfPath,
		"apply",
		"-auto-approve",
	)
}
