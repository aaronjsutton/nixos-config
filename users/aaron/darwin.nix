{pkgs, ...}: {
  nixpkgs.overlays = import ../../lib/overlays.nix;

  homebrew = {
    enable = false;
  };

  environment.pathsToLink = ["/share/zsh"];
  programs.zsh.enable = true;

  networking.computerName = "Aaron’s MacBook Pro";
  networking.hostName = "mac";

  users.users.aaron = {
    home = "/Users/aaron";
    shell = pkgs.zsh;
  };
}
