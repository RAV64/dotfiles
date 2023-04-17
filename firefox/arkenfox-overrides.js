user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

/* override recipe: enable session restore ***/
user_pref("browser.startup.page", 3); // 0102
user_pref("privacy.clearOnShutdown.history", false); // 2811

user_pref("privacy.window.maxInnerWidth", 2000);
user_pref("privacy.window.maxInnerHeight", 1500);
user_pref("privacy.resistFingerprinting.letterboxing", false); // [HIDDEN PREF]

user_pref("browser.search.suggest.enabled", false);
user_pref("browser.urlbar.suggest.searches", false);
user_pref("browser.search.update", false);
user_pref("browser.urlbar.update2.engineAliasRefresh", true);
user_pref("browser.urlbar.update2.oneOffsRefresh", false);

user_pref("keyword.enabled", true);

user_pref("browser.warnOnQuit", false);

// Disable pocket
user_pref("browser.pocket.enabled", false);
user_pref("extensions.pocket.enabled", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);

// Disable view
user_pref("browser.tabs.firefox-view", false);

user_pref("devtools.chrome.enabled", true);
user_pref("devtools.debugger.remote-enabled", true);
