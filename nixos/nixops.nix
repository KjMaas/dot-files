
{
  network = {
    description = "welcome home";
    enableRollback = true;

    storage.legacy = {
      databasefile = "~/.nixops/deployments.nixops";
    };
  };

  blade = { config, pkgs, ... }: {
    imports = [./hardware-configuration.nix ./configuration.nix];
    deployment = {
      targetHost = "localhost";

      keys = {
        wireless = {
          user = "klaasjan";
          group = "wheel";
          permissions = "0640";
          # destDir = /secrets;
          keyFile = ./keys/wireless.env;
        };
      };
    };
  };
}
