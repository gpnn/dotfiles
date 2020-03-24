# frozen_string_literal: true

require 'colorize'

def install_npm_global
  File.foreach('./lists/npm-global') do |line|
    line = line.strip.chomp
    str_start = ' '
    str_end = '@'
    line = line[line.index(str_start) + 1..-1]
    line = line[0, line.rindex(str_end)]
    puts "Install npm package globally #{line}".colorize(:blue)
    system("npm install -g #{line}")
  end
end

def install_brew_taps
  File.foreach('./lists/brew-taps') do |line|
    line = line.strip.chomp
    puts "Installing brew tap #{line}".colorize(:blue)
    system("brew tap #{line}")
  end
end

def install_brew_mas
  File.foreach('./lists/brew-mas') do |line|
    line = line.strip.chomp
    line = line.split(' ')
    puts "Installing Mac App Store app #{line[0]}".colorize(:blue)
    system("mas install #{line[0]}")
  end
end

def install_brew_casks
  File.foreach('./lists/brew-casks') do |line|
    line = line.strip.chomp
    puts "Installing cask #{line}".colorize(:blue)
    system("brew cask install #{line}")
  end
end

def install_brews
  File.foreach('./lists/brews') do |line|
    line = line.strip.chomp
    puts "Installing brew #{line}".colorize(:blue)
    system("brew install #{line}")
  end
end

def symlink_dotfiles
  Dir.foreach('./dotfiles') do |filename|
    next if %w[. ..].include?(filename)

    original_dotfile = "#{Dir.home}/#{filename}"
    File.delete(original_dotfile) if File.exist?(original_dotfile)
    puts "Symlinking #{filename}".colorize(:blue)
    system("ln -s ./dotfiles/#{filename} #{original_dotfile}")
  end
end

def create_directories
  puts 'Creating workspace directories'.colorize(:blue)
  system('mkdir -p $HOME/workspace/src/github.com/gpnn')
  system('mkdir -p $HOME/workspace/bin')
end

def make_zsh_default
  puts 'Making zsh the default shell'.colorize(:blue)
  system('chsh -s $(which zsh)')
end

def create_ssh_key
  puts 'Log into GitHub then hit any key to continue'.colorize(:yellow)
  system('open -a Brave\ Browser https://github.com/login')
  STDIN.gets.strip.chomp
  puts 'What is the email used for GitHub?'.colorize(:yellow)
  email = STDIN.gets.strip.chomp
  system("ssh-keygen -t rsa -b 4096 -C \"#{email}\"")
  system('pbcopy < ~/.ssh/id_rsa.pub')
  puts 'Your SSH key has been copied to your clipboard'.colorize(:yellow)
  system('open -a Brave\ Browser https://github.com/settings/keys')
end

def main
  install_brew_taps
  install_brews
  install_brew_casks
  install_brew_mas
  create_directories
  make_zsh_default
  symlink_dotfiles
  install_npm_global
  puts 'Would you like to create an SSH key for GitHub?'.colorize(:yellow)
  continue = STDIN.gets.strip.chomp.downcase == 'y'
  create_ssh_key if continue
end

main
