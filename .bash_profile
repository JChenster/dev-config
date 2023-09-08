source ~/.bashrc

# uncomment this if using local mac
#export ISLOCAL="true"

# brew is cool
eval "$(/opt/homebrew/bin/brew shellenv)"

# i'm using java 11 for cpsc 540
export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"
export JAVA_HOME="/opt/homebrew/opt/openjdk@11"
