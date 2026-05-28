package terraform

import (
	"fmt"

	"github.com/r-godinez/homelab/internal/utils"
)

func Validate(environment string) error {

	tfPath := fmt.Sprintf(
		"terraform/environments/%s",
		environment,
	)

	err := utils.RunCommand(
		"terraform",
		"-chdir="+tfPath,
		"fmt",
	)

	if err != nil {
		return err
	}

	return utils.RunCommand(
		"terraform",
		"-chdir="+tfPath,
		"validate",
	)
}
