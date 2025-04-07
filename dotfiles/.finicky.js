// Use https://finicky-kickstart.now.sh to generate basic configuration
// Learn more about configuration options: https://github.com/johnste/finicky/wiki/Configuration

const workApps = ["Mattermost.Desktop", "notion.id", "com.loom.desktop"];

module.exports = {
  options: {
    hideIcon: true,
    checkForUpdate: false,
    logRequests: false,
  },
  defaultBrowser: {
    name: "Google Chrome",
    profile: "Default",
  },
  handlers: [
    {
      // Open any link clicked in any work app in Google Chrome work profile
      match: ({ opener }) => workApps.includes(opener.bundleId),
      browser: {
        name: "Google Chrome",
        profile: "Profile 1",
      },
    },
    {
      // Open meridia.* urls in Google Chrome work profile
      match: [
        "*meridia*", // match meridia urls
      ],
      browser: {
        name: "Google Chrome",
        profile: "Profile 1",
      },
    },
  ],
};
