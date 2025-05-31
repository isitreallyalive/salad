{
  pkgs,
  osConfig,
  self,
  self',
  ...
}:

{
  config = self.lib.mkIfProfile osConfig "graphical" {
    programs.vscode = {
      enable = true;

      profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          jnoortheen.nix-ide
          skellock.just

          catppuccin.catppuccin-vsc-icons
        ];

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
