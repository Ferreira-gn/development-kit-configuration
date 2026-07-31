{
  description = "Development Kit Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs"; 
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      hostname = "nixos";
      username = "ferreira-gn";

      # pacotes do home-manager
      pkgs = import nixpkgs {
        inherit system;

        config = {
          allowUnfree = true;
        };
      };

      # caminho do diretório home do sistema 
      homeDirectory = "/home/${username}";

      # caminho do dotfiles
      repositoryPath = "${homeDirectory}/dev/development-kit-configuration";

    in
    {
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt;

      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs hostname username repositoryPath;
        };

        modules = [
          ./hosts/${hostname}/configuration.nix
        ];
      };



      homeConfigurations."${username}@${hostname}" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          extraSpecialArgs = {
            inherit inputs hostname username repositoryPath;
          };

          modules = [
            ./home/${username}/home.nix
          ];
      };

    };
} 
