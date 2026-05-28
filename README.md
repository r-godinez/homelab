# HOMELAB

## Intialize

```bash
go mod init github.com/r-godinez/homelab
```

## Install Cobra

```bash
go get github.com/spf13/cobra@latest
go install github.com/spf13/cobra-cli@latest
~/go/bin
cobra-cli version
echo 'export PATH=$PATH:$(go env GOPATH)/bin' >> ~/.zshrc
source ~/.zshrc
cobra-cli init
# This creates root command, command strucutre, CLI boilerplate
cobra-cli add deploy
cobra-cli add destroy
cobra-cli add validate
cobra-cli add k3s

```
