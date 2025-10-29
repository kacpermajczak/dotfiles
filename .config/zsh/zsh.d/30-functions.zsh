# Custom Functions

# SSH Fuzzy Finder
# Quickly select and connect to SSH hosts from ~/.ssh/config
s() {
  local server
  server=$(grep -E '^Host ' ~/.ssh/config | awk '{print $2}' | fzf)
  if [[ -n $server ]]; then
    ssh $server
  fi
}
