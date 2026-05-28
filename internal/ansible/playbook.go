package ansible

import (
	"fmt"

	"github.com/r-godinez/homelab/internal/utils"
)

func RunPlaybook(environment string) error {

	inventory := fmt.Sprintf(
		"ansible/inventory/%s.ini",
		environment,
	)

	playbook := fmt.Sprintf(
		"ansible/playbooks/k3s.yaml",
		environment,
	)

	fmt.Printf("\n[INFO] Running Ansible...\n")

	return utils.RunCommand(
		"ansible-playbook",
		"-i",
		inventory,
		playbook,
	)
}
