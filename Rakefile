require 'io/console'

ENV['HOMEBREW_CASK_OPTS'] = "--appdir=/Applications"

username = ''
password = ''

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

def filemap(map)
  map.inject({}) do |result, (key, value)|
    result[File.expand_path(key)] = File.expand_path(value)
    result
  end.freeze
end

namespace :install do
  desc 'Get username and password for Mac App Store'
  task :get_credentials do
    step 'Enter credentials for Mac App Store'
    puts 'You can ommit this step if you are already signed-in'
    puts 'Username: '
    username = STDIN.gets.chomp
    puts 'Password: '
    password = STDIN.noecho(&:gets)
  end

  desc 'Install/Update Brew'
  task :brew do
    step 'Installing Homebrew'
    unless system('which brew > /dev/null || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"')
      raise "Homebrew must be installed before continuing."
    end
  end

  desc 'Install command line applications with Homebrew'
  task :brew_bundle do
    step 'Installing / Updating Homebrew Apps'
    system('brew tap Homebrew/bundle && brew bundle --file=./Brew-bundle')
  end

  desc 'Install MacOS applications with Homebrew Cask'
  task :brew_cask_bundle do
    step 'Installing / Updating Cask Apps'
    system('brew bundle --file=./Cask-bundle')
  end

  desc 'Install MacOS applications from App Store with mas-cli'
  task :mas_bundle, [:username, :password] do
    step 'Installing Mac Store Apps'
    unless username.empty? and password.empty?
      system("mas signin #{username} \"#{password}\"")
      system('brew bundle --file=./Mas-bundle')
    end
  end

end

LINKED_FILES = filemap(
  'zshrc'         => '~/.zshrc',
  'zsh_aliases'   => '~/.zsh_aliases'
)

desc 'Install these config files.'
task :install do
  Rake::Task['install:get_credentials'].invoke
  Rake::Task['install:brew'].invoke
  Rake::Task['install:brew_bundle'].invoke
  Rake::Task['install:brew_cask_bundle'].invoke
  Rake::Task['install:mas_bundle'].invoke

  step 'symlink'

  LINKED_FILES.each do |orig, link|
    link_file orig, link
  end

  step 'localrc'
  localRc = File.expand_path('~/.zshrc-local')
  if File.exist?(localRc)
    puts 'Your local ~/.zshrc-local file already exist 🤙'
  else
    File.open(localRc, "w") { |file| file.puts "# Put any custom scripts here, this file won't be overwritten or deleted"}
    puts 'Created a ~/.zshrc-local file for your custom scripts 🤙'
  end

  step 'Enjoy'
  puts 'Installation completed! Enjoy your awesome setup 😎'

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