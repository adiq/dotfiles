require 'io/console'

ENV['HOMEBREW_CASK_OPTS'] = "--appdir=/Applications"

username = ''
password = ''

def install_github_bundle(user, package)
  unless File.exist? File.expand_path("~/.vim/bundle/#{package}")
    sh "git clone https://github.com/#{user}/#{package} ~/.vim/bundle/#{package}"
  end
end

def step(description)
  description = "-- #{description} "
  description = description.ljust(80, '-')
  puts
  puts "\e[32m#{description}\e[0m"
end

def app_path(name)
  path = "/Applications/#{name}.app"
  ["~#{path}", path].each do |full_path|
    return full_path if File.directory?(full_path)
  end

  return nil
end

def app?(name)
  return !app_path(name).nil?
end

def get_backup_path(path)
  number = 1
  backup_path = "#{path}.bak"
  loop do
    if number > 1
      backup_path = "#{backup_path}#{number}"
    end
    if File.exists?(backup_path) || File.symlink?(backup_path)
      number += 1
      next
    end
    break
  end
  backup_path
end

def link_file(original_filename, symlink_filename)
  original_path = File.expand_path(original_filename)
  symlink_path = File.expand_path(symlink_filename)
  if File.exists?(symlink_path) || File.symlink?(symlink_path)
    if File.symlink?(symlink_path)
      symlink_points_to_path = File.readlink(symlink_path)
      return if symlink_points_to_path == original_path
      # Symlinks can't just be moved like regular files. Recreate old one, and
      # remove it.
      ln_s symlink_points_to_path, get_backup_path(symlink_path), :verbose => true
      rm symlink_path
    else
      # Never move user's files without creating backups first
      mv symlink_path, get_backup_path(symlink_path), :verbose => true
    end
  end
  ln_s original_path, symlink_path, :verbose => true
end

def unlink_file(original_filename, symlink_filename)
  original_path = File.expand_path(original_filename)
  symlink_path = File.expand_path(symlink_filename)
  if File.symlink?(symlink_path)
    symlink_points_to_path = File.readlink(symlink_path)
    if symlink_points_to_path == original_path
      # the symlink is installed, so we should uninstall it
      rm_f symlink_path, :verbose => true
      backups = Dir["#{symlink_path}*.bak"]
      case backups.size
      when 0
        # nothing to do
      when 1
        mv backups.first, symlink_path, :verbose => true
      else
        $stderr.puts "found #{backups.size} backups for #{symlink_path}, please restore the one you want."
      end
    else
      $stderr.puts "#{symlink_path} does not point to #{original_path}, skipping."
    end
  else
    $stderr.puts "#{symlink_path} is not a symlink, skipping."
  end
end

namespace :install do
  desc 'Get username and password for Mac App Store'
  task :get_credentials do
    step 'Enter username and password for Mac App Store'
    puts 'Username: '
    username = STDIN.gets.chomp
    puts 'Password: '
    password = STDIN.noecho(&:gets)
  end

  desc 'Update or Install Brew'
  task :brew do
    step 'homebrew'
    unless system('which brew > /dev/null || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"')
      raise "Homebrew must be installed before continuing."
    end
  end

  desc 'Install command line applications with Homebrew'
  task :brew_bundle do
    step 'homebrew-bundle'
    system('brew tap Homebrew/bundle && brew bundle --file=./Brew-bundle')
  end

  desc 'Install MacOS applications with Homebrew Cask'
  task :brew_cask_bundle do
    step 'homebrew-cask-bundle'
    system('brew bundle --file=./Cask-bundle')
  end

  desc 'Install MacOS applications from App Store with mas-cli'
  task :mas_bundle, [:username, :password] do
    step 'mas-bundle'
    unless username.empty? and password.empty?
      system("mas signin #{username} \"#{password}\"")
      system('brew bundle --file=./Mas-bundle')
    end
  end

  desc 'Install MacVim'
  task :macvim do
    step 'MacVim'
    unless app? 'MacVim'
      sh "brew cask install --binarydir=#{`brew --prefix`.chomp}/bin macvim"
    end

    bin_dir = File.expand_path('~/bin')
    bin_vim = File.join(bin_dir, 'vim')
    unless ENV['PATH'].split(':').include?(bin_dir)
      puts 'Please add ~/bin to your PATH, e.g. run this command:'
      puts
      puts %{  echo 'export PATH="~/bin:$PATH"' >> ~/.bashrc}
      puts
      puts 'The exact command and file will vary by your shell and configuration.'
      puts 'You may need to restart your shell.'
    end

    FileUtils.mkdir_p(bin_dir)
    unless File.executable?(bin_vim)
      File.open(bin_vim, 'w', 0744) do |io|
        io << <<-SHELL
#!/bin/bash
exec /Applications/MacVim.app/Contents/MacOS/Vim "$@"
        SHELL
      end
    end
  end

  desc 'Install Vundle'
  task :vundle do
    step 'vundle'
    install_github_bundle 'VundleVim','Vundle.vim'
    sh '~/bin/vim -c "PluginInstall!" -c "q" -c "q"'
  end
end

def filemap(map)
  map.inject({}) do |result, (key, value)|
    result[File.expand_path(key)] = File.expand_path(value)
    result
  end.freeze
end

LINKED_FILES = filemap(
  'vim'           => '~/.vim',
  'tmux.conf'     => '~/.tmux.conf',
  'vimrc'         => '~/.vimrc',
  'vimrc.bundles' => '~/.vimrc.bundles',
  'zshrc'         => '~/.zshrc'
)

desc 'Install these config files.'
task :install do
  # Install homebrew and applications in Brewfile
  Rake::Task['install:get_credentials'].invoke
  Rake::Task['install:brew'].invoke
  Rake::Task['install:brew_bundle'].invoke
  Rake::Task['install:brew_cask_bundle'].invoke
  Rake::Task['install:mas_bundle'].invoke
  Rake::Task['install:macvim'].invoke

  step 'symlink'

  LINKED_FILES.each do |orig, link|
    link_file orig, link
  end

  # Install Vundle and bundles
  Rake::Task['install:vundle'].invoke

  step 'iterm2 colorschemes'
  colorschemes = `defaults read com.googlecode.iterm2 'Custom Color Presets'`
  dark  = colorschemes !~ /Solarized Dark/
  light = colorschemes !~ /Solarized Light/
  sh('open', '-a', '/Applications/iTerm.app', File.expand_path('iterm2-colors-solarized/Solarized Dark.itermcolors')) if dark
  sh('open', '-a', '/Applications/iTerm.app', File.expand_path('iterm2-colors-solarized/Solarized Light.itermcolors')) if light

  step 'iterm2 profiles'
  puts
  puts "  Your turn!"
  puts
  puts "  Go and manually set up Solarized Light and Dark profiles in iTerm2."
  puts "  (You can do this in 'Preferences' -> 'Profiles' by adding a new profile,"
  puts "  then clicking the 'Colors' tab, 'Load Presets...' and choosing a Solarized option.)"
  puts "  Also be sure to set Terminal Type to 'xterm-256color' in the 'Terminal' tab."
  puts
  puts "  Enjoy!"
  puts

end

desc 'Uninstall these config files.'
task :uninstall do
  step 'un-symlink'

  # un-symlink files that still point to the installed locations
  LINKED_FILES.each do |orig, link|
    unlink_file orig, link
  end

  step 'homebrew'
  puts
  puts 'Manually uninstall homebrew if you wish: https://gist.github.com/mxcl/1173223.'

end

task :default => :install
