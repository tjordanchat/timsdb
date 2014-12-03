# .bash_profile

# Get the aliases and functions
export ENV=~/.bshrc
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

##
# Your previous /Users/jjordan/.bash_profile file was backed up as /Users/jjordan/.bash_profile.macports-saved_2014-08-07_at_14:13:05
##

# MacPorts Installer addition on 2014-08-07_at_14:13:05: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

