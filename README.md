# [@adiq](https://github.com/adiq) dotfiles

💻 Personal macOS setup.

Based on wonderful work of [@square](https://github.com/square) and [@rutgerfarry](https://github.com/rutgerfarry).

## What's in it?

You can see list of all packages and apps installed in:
- `Brew-bundle` for things installed with Homebrew
- `Cask-bundle` for things installed with Cask
- `Mas-bundle` for things installed from Mac App Store with MAS


Most of the things included is free-of-charge, but ones listed below may require paid license:
- [Paw](https://paw.pt) (free trial, €49.99 or thru SetApp subscription)
- [Fantastical 3](https://flexibits.com/fantastical) (free trial, subscription / previously $49.99)


> Tip: Feel free to modify app bundles to your linking before running to prevent installing apps you do not want (eg. paid ones)


Also, there are my custom aliases in file `zsh_aliases`. For your own local scripts: use provided `~/.zshrc-local` 😉

## Install

You will probably need XCode installed alongside with Command Line Tools (command: `xcode-select --install`).


```sh
rake
```

## Update
```sh
rake
```

## Customize

If you want to keep similar macOS environment setup yourself, feel free to fork and customize to your ❤️'s content

## Uninstall
```sh
rake uninstall
```

> Note: that this won't remove everything, but your linked files should be reset to whatever it was before installing. Some uninstallation steps will be manual.