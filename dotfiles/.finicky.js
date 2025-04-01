// Use https://finicky-kickstart.now.sh to generate basic configuration
// Learn more about configuration options: https://github.com/johnste/finicky/wiki/Configuration

module.exports = {
    options: {
        hideIcon: true,
        checkForUpdate: false,
        logRequests: false,
    },
    defaultBrowser: {
        name: "Google Chrome",
        profile: "Default"
    },
    handlers: [
        {
            // Open any link clicked in Mattermost in Google Chrome work profile
            match: ({ opener }) =>
                opener.bundleId === "Mattermost.Desktop",
            browser: {
                name: "Google Chrome",
                profile: "Profile 1"
            }
        },
        {
            // Open any link clicked in Notion in Google Chrome work profile
            match: ({ opener }) =>
                opener.bundleId === "notion.id",
            browser: {
                name: "Google Chrome",
                profile: "Profile 1"
            }
        },
        {
            // Open meridia.* urls in Google Chrome work profile
            match: [
                "meridia*", // match meridia urls
            ],
            browser: {
                name: "Google Chrome",
                profile: "Profile 1"
            }
        }
    ]

}