# @adiq dotfiles

💻 Personal macOS setup.

Based on wonderful work of [@square](https://github.com/square) and [@rutgerfarry](https://github.com/rutgerfarry).

## Work In Progress

This needs to be personalized and updated. Treat any further information below this line as outdated, and whole setup as experimental.

## What's in it?

### All my command-line packages

- ctags
- elm
- ffmpeg
- git
- imagemagick
- mas
- node.js
- pandoc
- prolog
- swiftlint
- [tmux](http://tmux.github.io/)
- watchman
- xctool
- yarn
- youtube-dl
- zsh
- [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh), plus configs
- syntax highlighting with the [Solarized color scheme](http://ethanschoonover.com/solarized)

### All my desktop apps (installed with Mac App Store if possible, homebrew-cask if not)

- 1Password
- Affinity Designer
- Airmail
- Alfred2
- Bear
- Better Snap Tool
- Caffeine
- Day One
- Docker
- Fantastical 2
- Garageband
- Google Chrome
- Haskell Platform
- iMovie
- [iTerm 2](http://www.iterm2.com/)
- Java
- [MacVim](https://github.com/macvim-dev/macvim) (independent or for use in a terminal)
- Microsoft Remote Desktop
- Pages, Keynote, Numbers
- Pixelmator
- [Postman](https://www.getpostman.com)
- Sip
- Sketch
- Skype
- Slack
- [Spotify](https://www.spotify.com/us/)
- Steam
- [The Unarchiver](http://unarchiver.c3.cx/unarchiver)
- Tower
- Transmission
- Vagrant
- Virtualbox
- [Visual Studio Code](https://code.visualstudio.com)
- [VLC](http://www.videolan.org/vlc/index.html)
- Xcode

Want to know more? [Fly Vim, First Class](https://corner.squareup.com/2013/08/fly-vim-first-class.html)

### vim

- `,d` brings up [NERDTree](https://github.com/scrooloose/nerdtree), a sidebar buffer for navigating and manipulating files
- `,t` brings up [ctrlp.vim](https://github.com/ctrlpvim/ctrlp.vim), a project file filter for easily opening specific files
- `,b` restricts ctrlp.vim to open buffers
- `,a` starts project search with [ag.vim](https://github.com/rking/ag.vim) using [the silver searcher](https://github.com/ggreer/the_silver_searcher) (like ack, but faster)
- `ds`/`cs` delete/change surrounding characters (e.g. `"Hey!"` + `ds"` = `Hey!`, `"Hey!"` + `cs"'` = `'Hey!'`) with [vim-surround](https://github.com/tpope/vim-surround)
- `gcc` toggles current line comment
- `gc` toggles visual selection comment lines
- `vii`/`vai` visually select *in* or *around* the cursor's indent
- `Vp`/`vp` replaces visual selection with default register *without* yanking selected text (works with any visual selection)
- `,[space]` strips trailing whitespace
- `<C-]>` jump to definition using ctags
- `,l` begins aligning lines on a string, usually used as `,l=` to align assignments
- `<C-hjkl>` move between windows, shorthand for `<C-w> hjkl`

### tmux

- native macOS copy / paste
- mouse scroll initiates tmux scroll
- `prefix v` makes a vertical split
- `prefix s` makes a horizontal split

If you have three or more panes:
- `prefix +` opens up the main-horizontal-layout
- `prefix =` opens up the main-vertical-layout

You can adjust the size of the smaller panes in `tmux.conf` by lowering or increasing the `other-pane-height` and `other-pane-width` options.

## Install
```sh
rake
```

## Update
```sh
rake
```

This will update all installed plugins using Vundle's `:PluginInstall!`
command. Any errors encountered during this process may be resolved by clearing
out the problematic directories in ~/.vim/bundle. `:help PluginInstall`
provides more detailed information about Vundle.

## Customize
Fork and customize the config files (`vimrc`, `vimrc.bundles`, `zshrc`) to your ❤️'s content

## Uninstall
```sh
rake uninstall
```

Note that this won't remove everything, but your vim configuration should be reset to whatever it was before installing. Some uninstallation steps will be manual.

## Acknowledgements

Thanks to the vimsters at Square who put this together. Thanks to Tim Pope for
his awesome vim plugins.
