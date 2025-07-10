{
  pkgs,
  self',
  ...
}:

let
  inherit (pkgs.nix-vscode-extensions) vscode-marketplace;

  mkProfile = extensions: settings: {
    extensions =
      extensions
      ++ (with vscode-marketplace; [
        # funcional
        github.copilot
        github.copilot-chat
        mkhl.direnv
        wakatime.vscode-wakatime
        jnoortheen.nix-ide

        # aesthetic
        aaron-bond.better-comments
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
      ]);

    userSettings = {
      # general
      "explorer.confirmDragAndDrop" = false;
      "git.confirmSync" = false;

      # appearance
      "editor.fontFamily" = "'Cascadia Code NF', 'monospace', monospace";
      "editor.fontLigatures" = true;
      "terminal.integrated.fontFamily" = "'Cascadia Code NF', 'monospace', monospace";

      # catppuccin
      "workbench.colorTheme" = "Catppuccin Mocha";
      "catppuccin.accentColor" = "mauve";

      # nix lsp
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixd";
      "nix.serverSettings".nixd.formatting.command = [
        "treefmt"
        "--stdin"
        "{file}"
      ];

      # nushell
      "terminal.integrated.profiles.linux".nushell.path = "nu";
      "terminal.integrated.defaultProfile.linux" = "nushell";
    } // settings;
  };

in
{
  programs.vscode = {
    enable = true;

    profiles = {
      default = (mkProfile [ ] { }) // {
        enableUpdateCheck = true;
      };

      rust = mkProfile (with vscode-marketplace; [
        rust-lang.rust-analyzer
        skellock.just
        tamasfe.even-better-toml
        norgor.capnp
      ]) { };
    };
  };

  salad.packages = {
    inherit (pkgs) nixd;
    inherit (self') formatter;
  };
}
