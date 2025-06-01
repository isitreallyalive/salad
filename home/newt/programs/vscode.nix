{
  pkgs,
  osConfig,
  self,
  self',
  ...
}:

let
  inherit (pkgs) vscode-extensions;
  general = with vscode-extensions; [
    skellock.just
    
    aaron-bond.better-comments
    catppuccin.catppuccin-vsc-icons
  ];
in
{
  config = self.lib.mkIfProfile osConfig "graphical" {
    programs.vscode = {
      enable = true;

      profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          jnoortheen.nix-ide
        ] ++ general;

        userSettings = {
          "explorer.confirmDragAndDrop" = false;

          # nix lsp
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nixd";
          "nix.serverSettings".nixd.formatting.command = [
            "treefmt"
            "--stdin"
            "{file}"
          ];
        };
      };
    };

    salad.packages = {
      inherit (pkgs) nixd;
      inherit (self') formatter;
    };

    catppuccin.vscode.enable = true;
  };
}
