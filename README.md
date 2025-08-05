# nvim-config

<div align="center">
<img src="https://nvchad.com/logo.svg" alt="NvChad Logo" />
<br>
<em>My personal Neovim setup based on NvChad built for productivity and style</em>
</div>

## ✨ Overview

This is my personal Neovim configuration built on top of [NvChad](https://nvchad.com/), providing a solid foundation with beautiful UI, sensible defaults, and excellent plugin management.

## 📦 Installation

### Prerequisites

- Neovim >= 0.11.3
- Git
- A Nerd Font (optional but recommended)

### Setup

1. **Backup your existing config** (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone this configuration**:
   ```bash
   git clone --depth 1 https://git.thoxy.xyz/thoxy/nvim-config ~/.config/nvim
   ```

3. **Start Neovim**:
   ```bash
   nvim
   ```

The configuration will automatically install plugins on first launch.

### Uninstall
   ```bash
   rm -rf ~/.config/nvim
   rm -rf ~/.local/state/nvim
   rm -rf ~/.local/share/nvim
   ```

## 🤝 Contributing

Feel free to fork this configuration and make it your own! If you have suggestions or improvements, pull requests are welcome.

## 🙏 Acknowledgments

Special thanks to the amazing Neovim community and these fantastic projects that helped shape this configuration:

- **[NvChad](https://nvchad.com/)** ([repo](https://github.com/NvChad/NvChad) | [starter](https://github.com/NvChad/starter)) - For providing the excellent starter template and foundation
- **[kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)** - For helping with configuration options and best practices
- **[LazyVim](https://www.lazyvim.org/)** ([repo](https://github.com/LazyVim/LazyVim)) - For inspiration and configuration insights

## 📄 License

This configuration is released into the public domain under the [Unlicense](LICENSE). You are free to use, modify, and distribute it without any restrictions.

---

<div align="center">
<strong>Built with ❤️ using <a href="https://nvchad.com/">NvChad</a></strong>
</div>