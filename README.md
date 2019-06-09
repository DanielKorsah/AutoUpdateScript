# AutoUpdateScript
Checks the repo once per minute. Atomatically pulls from the repo if there are changes. Copies the files to the desired location.

# Why?
I Use this to update my personal website without having to remote to my Raspberry pi or copy files over. A simple convenience tool. I found it hard to find something like this to suite my needs so sharing this might help someone else. It can be easily edited to suit your needs better.

# Usage


**Technical**
- Requires you to use ssh instead of https to access your repo. Follow github's instruction on how to do this: 
[here for generating a ssh key](https://help.github.com/en/articles/adding-a-new-ssh-key-to-your-github-account) and 
[herefor changing your github URL to use it](https://help.github.com/en/articles/changing-a-remotes-url#switching-remote-urls-from-https-to-ssh)
- Change [REPO LOCATION] on line 11 to the path to where your local repo is
- Change [WEBSITE LOCATION] on line 12 to the path to where you keep your website files if that's what you want to use it for.
- If not using for that purpose simply delete lines 36 - 42 and don't use the [WEBSITE LOCATION] at all.


**End User**
- Leave running on the machine you want to keep updated
- Pimply make your changes, stage and commit as normal on whatever machnie you want
- Push your changes and in less than a minute they will be pulled to the machine/device running this script.
