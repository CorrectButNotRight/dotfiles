
config.set(
    "content.host_blocking.lists",
    [
        #"https://easylist.to/easylist/easylist.txt",
        #"https://easylist.to/easylist/easyprivacy.txt",
        #"https://easylist.to/easylist/fanboy-annoyance.txt",
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt",
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances.txt",
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt",
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt",
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/resource-abuse.txt",
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt",
        #"https://www.malwaredomainlist.com/hostslist/hosts.txt",
        #"https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=1&mimetype=plaintext",
    ]
)

#config.bind('<z><l>', 'spawn --userscript qute-keepass -p ~/Desktop/Passwords.kdbx --keyfile-path ~/Desktop/Passwords.key --no-password')
