{
  osConfig,
  self,
  lib,
  pkgs,
  ...
}:

let
  users = with osConfig.salad.users; [ main ] ++ others;
in
{
  programs.librewolf = self.lib.profile.mkIf osConfig "graphical" {
    enable = true;
    profiles = builtins.listToAttrs (
      lib.imap0 (id: user: {
        inherit (user) name;
        value = {
          inherit id;
          extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
            # redirect AMP links to HTML
            amp2html
            # automatically suspends AudioContexts to save resources
            audiocontext-suspender
            # close overlays on any website
            behind-the-overlay-revival
            # twitch emotes
            betterttv
            # password manager
            bitwarden
            # automatic captcha solving
            # todo: client app
            buster-captcha-solver
            # reduce fingerprinting from webgl canvases
            canvasblocker
            # clear cache with F9
            clearcache
            # adds links to documents if they are available
            click-and-read
            # automatically consent to GDPR
            consent-o-matic
            # crowdsourced titles to be unsensionalized
            dearrow
            # cdn emulation
            decentraleyes
            # better dark mode for google docs
            docsafterdark
            # allow copy and paste everywhere
            don-t-fuck-with-paste
            # grammar checker
            grammarly
            # prefer indie wikis
            indie-wiki-buddy
            # get rid of cookie banners
            istilldontcareaboutcookies
            # modrinth > curseforge
            modrinthify
            # pdfs in the browser!
            no-pdf-download
            # print pages to pdfs
            print-to-pdf-document
            # blue hair and pronounce
            pronoundb
            # easily collapse comment trees on reddit
            reddit-comment-collapser
            # flash
            ruffle_rs
            # easy image search
            search-by-image
            # highlights anti-LGBT sources
            shinigami-eyes
            # help fight censorship!
            snowflake
            # skip sponsor segments in YouTube videos
            sponsorblock
            # steamdb links on steam
            steam-database
            # custom css
            stylus
            # tab counter
            tab-counter-plus
            # custom scripts
            tampermonkey
            # tos summaries
            terms-of-service-didnt-read
            # translation
            to-deepl
            # access wayback machine
            wayback-machine
          ];
          settings = {
            # enable webgl
            "webgl.disabled" = false;
          };
        };
      }) users
    );
  };
}
