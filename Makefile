# please change 'hostname' to your hostname
deploy:
	nix build .#darwinConfigurations.Ruchis-MacBook-Air.system \
	   --extra-experimental-features 'nix-command flakes'

	./result/sw/bin/darwin-rebuild switch --flake .#Ruchis-MacBook-Air