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

    home.packages =
      with pkgs;
      [
        nixd
      ]
      ++ [ self'.formatter ];

    catppuccin.vscode.enable = true;
  };
}
