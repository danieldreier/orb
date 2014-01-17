# Ordered "manifest" of things to run

order install_rvm before install_ruby
install_rvm() {
  echo "I'm installing rvm!"
}

install_ruby() {
  echo "I'm installing ruby!"
}

order install_rubygems after install_ruby
order install_rubygems after install_rubygems
install_rubygems() {
  echo "I'm installing rubygems!"
}

