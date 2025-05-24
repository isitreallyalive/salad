{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
      ];

      userSettings = {
        # nix lsp
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
      };
    };
  };

  programs.git = {
    userName = "newt";
    userEmail = "hi@newty.dev";
  };

  home.packages = with pkgs; [
    nixd
  ];
}