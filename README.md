# dotfiles

Keeps the setups of personal macOS/Linux machines in sync. Fully idempotent.

- [Homebrew](https://brew.sh)
- [GNU Stow](https://www.gnu.org/software/stow/) 
- [AppImage Manager](https://github.com/ivan-hc/AM)
- [AppMan DB](https://portable-linux-apps.github.io/apps.html)

## Usage

```bash
# bootstrap
curl -fsSL https://raw.githubusercontent.com/TWinston-66/dotfiles/main/bootstrap.sh | bash
```

```bash
# updating
./dotfiles.sh
am -u 
brew update && brew upgrade
``` 