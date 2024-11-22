{pkgs, lib, config_path, ...}:
let
  nurpkgs = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") { inherit pkgs; };
in
{
  enable = true;
  profiles = {
    default = {
      id = 0;
    };
    personal = {
      id = 1;
      extensions = with nurpkgs.repos.rycee.firefox-addons; [
        ublock-origin
        sidebery
        gruvbox-dark-theme
        ghosttext
      ];
      bookmarks = [
        {
          name = "duckduckgo";
          tags = ["duck"];
          keyword = "duck";
          url = "https://duckduckgo.com";
        }
        {
          name = "google";
          tags = ["goo"];
          keyword = "goo";
          url = "https://google.com";
        }
        {
          name = "mail";
          tags = ["mail"];
          keyword = "mail";
          url = "https://mail.google.com/mail/u/0/#inbox";
        }
        {
          name = "youtube";
          tags = ["yt"];
          keyword = "yt";
          url = "https://youtube.com";
        }
        {
          name = "netflix";
          tags = ["netf"];
          keyword = "netf";
          url = "https://netflix.com";
        }
        {
          name = "crunchyroll";
          tags = ["crunchy"];
          keyword = "crunchy";
          url = "https://crunchyroll.com";
        }
        {
          name = "linkedin";
          tags = ["link"];
          keyword = "link";
          url = "https://linkedin.com";
        }
        {
          name = "whatsapp";
          tags = ["wha"];
          keyword = "wha";
          url = "https://web.whatsapp.com/";
        }
      ];

      userChrome = builtins.readFile "${config_path}/firefox/userChrome.css";
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "apz.allow_zooming" = true;
        "layout.css.prefers-color-scheme.content-override" = 0;
        "browser.search.defaultenginename" = "https://duckduckgo.com";
        "browser.search.region" = "GB";
        "browser.aboutConfig.showWarning" = false;
        "browser.tabs.warnOnClose" = false;
        "browser.fullscreen.autohide" = false;
        "browser.startup.homepage" = "https://duckduckgo.com";
        "browser.tabs.loadInBackground" = false;
        "browser.urlbar.update2" = false;
        "browser.urlbar.shortcuts.bookmarks" = false;
        "browser.urlbar.shortcuts.tabs" = false;
        "browser.urlbar.shortcuts.history" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
        "browser.newtabpage.pinned" = "";
      };
    };
    unal = {
      id = 2;
      extensions = with nurpkgs.repos.rycee.firefox-addons; [
        ublock-origin
        sidebery
        gruvbox-dark-theme
      ];
      bookmarks = [
        {
          name = "duckduckgo";
          tags = ["duck"];
          keyword = "duck";
          url = "https://duckduckgo.com";
        }
        {
          name = "google";
          tags = ["goo"];
          keyword = "goo";
          url = "https://google.com";
        }
        {
          name = "mail";
          tags = ["mail"];
          keyword = "mail";
          url = "https://mail.google.com/mail/u/0/#inbox";
        }
        {
          name = "drive";
          tags = ["drive"];
          keyword = "drive";
          url = "https://drive.google.com/drive/my-drive";
        }
        {
          name = "github";
          tags = ["gh"];
          keyword = "gh";
          url = "https://github.com/";
        }
        {
          name = "chatgpt";
          tags = ["cgpt"];
          keyword = "cgpt";
          url = "https://chat.openai.com/";
        }
      ];
      userChrome = builtins.readFile "${config_path}/firefox/userChrome.css";
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "apz.allow_zooming" = true;
        "layout.css.prefers-color-scheme.content-override" = 0;
        "browser.search.defaultenginename" = "https://duckduckgo.com";
        "browser.search.region" = "GB";
        "browser.aboutConfig.showWarning" = false;
        "browser.tabs.warnOnClose" = false;
        "browser.fullscreen.autohide" = false;
        "browser.startup.homepage" = "https://duckduckgo.com";
        "browser.tabs.loadInBackground" = false;
        "browser.urlbar.update2" = false;
        "browser.urlbar.shortcuts.bookmarks" = false;
        "browser.urlbar.shortcuts.tabs" = false;
        "browser.urlbar.shortcuts.history" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
        "browser.newtabpage.pinned" = "";
        "browser.urlbar.suggest.pocket" = false;
        "extensions.pocket.enabled" = false;
      };
    };
    epam = {
      id = 3;
      extensions = with nurpkgs.repos.rycee.firefox-addons; [
        ublock-origin
        sidebery
        gruvbox-dark-theme
      ];
      bookmarks = [
        {
          name = "duckduckgo";
          tags = ["duck"];
          keyword = "duck";
          url = "https://duckduckgo.com";
        }
        {
          name = "google";
          tags = ["goo"];
          keyword = "goo";
          url = "https://google.com";
        }
        {
          name = "mail";
          tags = ["mail"];
          keyword = "mail";
          url = "https://outlook.office.com/mail/";
        }
        {
          name = "github";
          tags = ["gh"];
          keyword = "gh";
          url = "https://github.com/";
        }
        {
          name = "teams";
          tags = ["teams"];
          keyword = "teams";
          url = "https://teams.microsoft.com/";
        }
      ];
      userChrome = builtins.readFile "${config_path}/firefox/userChrome.css";
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "apz.allow_zooming" = true;
        "layout.css.prefers-color-scheme.content-override" = 0;
        "browser.search.defaultenginename" = "https://duckduckgo.com";
        "browser.search.region" = "GB";
        "browser.aboutConfig.showWarning" = false;
        "browser.tabs.warnOnClose" = false;
        "browser.fullscreen.autohide" = false;
        "browser.startup.homepage" = "https://duckduckgo.com";
        "browser.tabs.loadInBackground" = false;
        "browser.urlbar.update2" = false;
        "browser.urlbar.shortcuts.bookmarks" = false;
        "browser.urlbar.shortcuts.tabs" = false;
        "browser.urlbar.shortcuts.history" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
        "browser.newtabpage.pinned" = "";
        "browser.urlbar.suggest.pocket" = false;
        "extensions.pocket.enabled" = false;
      };
    };
	test = {
      id = 4;
      extensions = with nurpkgs.repos.rycee.firefox-addons; [
        ublock-origin
        sidebery
        gruvbox-dark-theme
      ];
      bookmarks = [
        {
          name = "duckduckgo";
          tags = ["duck"];
          keyword = "duck";
          url = "https://duckduckgo.com";
        }
        {
          name = "google";
          tags = ["goo"];
          keyword = "goo";
          url = "https://google.com";
        }
        {
          name = "mail";
          tags = ["mail"];
          keyword = "mail";
          url = "https://outlook.office.com/mail/";
        }
        {
          name = "github";
          tags = ["gh"];
          keyword = "gh";
          url = "https://github.com/";
        }
        {
          name = "teams";
          tags = ["teams"];
          keyword = "teams";
          url = "https://teams.microsoft.com/";
        }
      ];
      userChrome = builtins.readFile "${config_path}/firefox/userChrome.css";
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "apz.allow_zooming" = true;
        "layout.css.prefers-color-scheme.content-override" = 0;
        "browser.search.defaultenginename" = "https://duckduckgo.com";
        "browser.search.region" = "GB";
        "browser.aboutConfig.showWarning" = false;
        "browser.tabs.warnOnClose" = false;
        "browser.fullscreen.autohide" = false;
        "browser.startup.homepage" = "https://duckduckgo.com";
        "browser.tabs.loadInBackground" = false;
        "browser.urlbar.update2" = false;
        "browser.urlbar.shortcuts.bookmarks" = false;
        "browser.urlbar.shortcuts.tabs" = false;
        "browser.urlbar.shortcuts.history" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
        "browser.newtabpage.pinned" = "";
        "browser.urlbar.suggest.pocket" = false;
        "extensions.pocket.enabled" = false;
      };
    };
  };
}
