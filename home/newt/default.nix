{ self', pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        skellock.just
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

  programs.git = {
    userName = "newt";
    userEmail = "hi@newty.dev";
  };

  home.packages =
    with pkgs;
    [
      nixd
    ]
    ++ [ self'.formatter ];
}
