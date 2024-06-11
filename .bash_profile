function add_path() { [ -d "$1" ] && export PATH="$1:$PATH" ; }
add_path "/opt/homebrew/opt/openjdk/bin"
add_path "$JAVA_HOME"
add_path "$HOME/dev/bin"
add_path "$HOME/Notes/bin"
add_path "$HOME/.local/bin"
add_path "/opt/homebrew/opt/gnu-sed/libexec/gnubin"
add_path "/opt/homebrew/opt/curl/bin"
