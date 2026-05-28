/*
Copyright © 2026 NAME HERE <EMAIL ADDRESS>
*/
package cmd

import (
	"fmt"

	"github.com/r-godinez/homelab/internal/terraform"
	"github.com/spf13/cobra"
)

// destroyCmd represents the destroy command
var destroyCmd = &cobra.Command{
	Use:   "destroy",
	Short: "Destroy infrastructure",

	RunE: func(cmd *cobra.Command, args []string) error {

		if len(args) < 1 {
			return fmt.Errorf(
				"environment required",
			)
		}

		environment := args[0]

		fmt.Printf(
			"\n[INFO] Destroying environment: %s\n",
			environment,
		)

		return terraform.Destroy(environment)
	},
}

func init() {
	rootCmd.AddCommand(destroyCmd)
}
