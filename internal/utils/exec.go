package utils

import (
	"fmt"
	"os"
	"os/exec"
)

func RunCommand(name string, args ...string) error {

	fmt.Printf(
		"\n[INFO] Running command: %s %v\n\n",
		name,
		args,
	)

	cmd := exec.Command(name, args...)

	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	cmd.Stdin = os.Stdin

	return cmd.Run()
}
