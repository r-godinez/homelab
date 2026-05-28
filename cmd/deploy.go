/*
Copyright © 2026 NAME HERE <EMAIL ADDRESS>
*/
package cmd

import (
	"fmt"

	"github.com/r-godinez/homelab/internal/ansible"
	"github.com/r-godinez/homelab/internal/terraform"
	"github.com/spf13/cobra"
)

// deployCmd represents the deploy command
var deployCmd = &cobra.Command{
	Use:   "deploy",
	Short: "Deploy infrastructure",

	RunE: func(cmd *cobra.Command, args []string) error {
		if len(args) < 1 {
			return fmt.Errorf("environment required")
		}

		environment := args[0]

		fmt.Printf(
			"\n[INFO] Deploying environment: %s\n",
			environment,
		)

		// Terraform
		err := terraform.Apply(environment)
		if err != nil {
			return err
		}

		// Ansible
		err = ansible.RunPlaybook(environment)
		if err != nil {
			return err
		}

		fmt.Println("\n[SUCCESS] Deployment complete")
		return nil
	},
}

func init() {
	rootCmd.AddCommand(deployCmd)
}

// Long: `A longer description that spans multiple lines and likely contains examples
// and usage of using your command. For example:

// Cobra is a CLI library for Go that empowers applications.
// This application is a tool to generate the needed files
// to quickly create a Cobra application.`,
// 	Run: func(cmd *cobra.Command, args []string) {
// 		fmt.Println("deploy called")
// 	},
// }

// func init() {
// 	rootCmd.AddCommand(deployCmd)

// 	// Here you will define your flags and configuration settings.

// 	// Cobra supports Persistent Flags which will work for this command
// 	// and all subcommands, e.g.:
// 	// deployCmd.PersistentFlags().String("foo", "", "A help for foo")

// 	// Cobra supports local flags which will only run when this command
// 	// is called directly, e.g.:
// 	// deployCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
// }
