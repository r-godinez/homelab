package terraform

import (
	"fmt"

	"github.com/r-godinez/homelab/internal/utils"
)

func Destroy(environment string) error {

	tfPath := fmt.Sprintf(
		"terraform/environments/%s",
		environment,
	)

	fmt.Println("\n[INFO] Destroying infrastructure...")

	return utils.RunCommand(
		"terraform",
		"-chdir="+tfPath,
		"destroy",
		"-auto-approve",
	)
}
