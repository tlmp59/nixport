{
  inputs,
  lib,
  ...
} @ args:
with inputs; let
  genHosts = system: let
    sysHosts = lib.custom.scanPath {
      path = ./${system};
      full = false;
      filter = "dir";
    };
    sysAttrs =
      if lib.hasSuffix "darwin" system
      then {
        type = "darwin";
        mod = "darwinModules";
        init = nix-darwin.lib.darwinSystem;
      }
      else {
        type = "linux";
        mod = "nixosModules";
        init = lib.nixosSystem;
      };
    specialArgs = {inherit inputs lib;};
  in
    with sysAttrs;
      lib.genAttrs sysHosts (
        hostname:
          init {
            inherit system specialArgs;
            modules = [
              # --Include system configurations--
              ../module/base
              ../module/${type}
              ./${system}/${hostname}

              # --Input home-manager & nix-secret as flake module--
              home-manager.${mod}.home-manager
              nix-secret.${mod}.secrets

              # --System predefined attributes--
              {
                home-manager.users."${nix-secret.globalVars.username}".imports = [
                  nix-secret.homeModules.secrets
                  ../home/base
                  ../home/${type}
                  ./${system}/${hostname}/home.nix
                ];

                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;

                networking.hostName = hostname;
              }
            ];
          }
      );
in {
  nixosConfigurations = lib.mergeAttrsList (
    map genHosts
    (builtins.filter (dir: lib.hasSuffix "linux" dir) args.systems)
  );

  darwinConfigurations = lib.mergeAttrsList (
    map genHosts
    (builtins.filter (dir: lib.hasSuffix "darwin" dir) args.systems)
  );
}
