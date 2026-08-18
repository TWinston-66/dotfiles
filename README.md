# dotfiles

Keeps the setups of multiple personal macOS/Linux machines in sync. Fully idempotent.

- [Homebrew](https://brew.sh)
- [GNU Stow](https://www.gnu.org/software/stow/) 
- [AppImage Manager](https://github.com/ivan-hc/AM)

## Usage

```bash
curl -fsSL https://raw.githubusercontent.com/TWinston-66/dotfiles/main/bootstrap.sh | bash
```

```bash
# to update, pull repo, then...
./dotfiles.sh && am -u
``` 

---

- [AppMan DB](https://portable-linux-apps.github.io/apps.html)