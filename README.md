# 🚀 Termux URL Opener

> A powerful and intelligent URL downloader for Termux that supports Instagram, TikTok, YouTube, Twitter, and many more platforms!

[![Bash](https://img.shields.io/badge/bash-5.1+-brightgreen?style=flat-square&logo=gnu-bash)](https://www.gnu.org/software/bash/)
[![License](https://img.shields.io/badge/license-MIT-blue?style=flat-square)](LICENSE)
[![Termux](https://img.shields.io/badge/Termux-Compatible-orange?style=flat-square)](https://termux.com/)

---

## ✨ Features

- 🎯 **Multi-Platform Support**: Instagram, TikTok, YouTube, Twitter, and more
- 🍪 **Smart Cookie Handling**: Uses saved Instagram cookies for private/restricted content
- 🔗 **Dual Download Methods**: Cobalt API for public links + yt-dlp fallback for everything else
- 📝 **Detailed Logging**: Every download attempt is logged with timestamps
- ⚡ **Fast & Reliable**: Optimized for Termux environment
- 📱 **Mobile-First**: Designed specifically for Termux on Android
- 🛡️ **Error Handling**: Graceful fallback mechanisms for failed downloads

---

## 📋 Requirements

### Termux Environment
- **Termux** app installed on your Android device
- **Bash** 5.0 or higher
- **curl** - For API requests
- **jq** - For JSON parsing
- **yt-dlp** - For video/audio downloads
- **ffmpeg** (optional) - For media processing

### Quick Setup
```bash
pkg update
pkg install -y curl jq yt-dlp ffmpeg
```

---

## 🚀 Installation

### Quick Install
```bash
# Clone the repository
git clone https://github.com/Wilooper/Termux_dl.git
cd Termux_dl

# Make the installer executable
chmod +x start.sh

# Run the installer
./start.sh
```

### Manual Installation
```bash
# Copy the script to your bin directory
cp termux_dl.sh $PREFIX/bin/termux-url-opener

# Make it executable
chmod +x $PREFIX/bin/termux-url-opener
```

---

## 💡 Usage

### Basic Usage
```bash
termux-url-opener <URL>
```

### Examples

**Instagram Post:**
```bash
termux-url-opener https://www.instagram.com/p/ABC123/
```

**TikTok Video:**
```bash
termux-url-opener https://www.tiktok.com/@username/video/123456
```

**YouTube Video:**
```bash
termux-url-opener https://www.youtube.com/watch?v=dQw4w9WgXcQ
```

**Twitter/X Post:**
```bash
termux-url-opener https://twitter.com/user/status/123456
```

**Generic URL:**
```bash
termux-url-opener https://example.com/video.mp4
```

---

## 🔧 Configuration

### Download Directory
Edit the `DEST` variable in the script (default: `/sdcard/Download/Termux`)

```bash
# Line 4 in termux_dl.sh
DEST="/sdcard/Download/Termux"
```

### Instagram Cookie Setup (for Private Content)

1. **Export cookies from your browser:**
   - Use a browser extension like "Cookie Editor" or "Get Plain Text Cookies"
   - Export cookies for `instagram.com`

2. **Save to Termux:**
   ```bash
   # Create the cookie file
   nano ~/.instagram-cookies.txt
   
   # Paste your cookies (Netscape format)
   # Then save (Ctrl+X → Y → Enter)
   ```

3. **The script will automatically use these cookies!**

---

## 📊 How It Works

### Download Flow

```
         INPUT URL
            ↓
    ┌───────────────────┐
    │ Check Platform    │
    └────────┬──────────┘
             ↓
    ┌─────────────────────────────────────┐
    │ Instagram? → Use Saved Cookies      │
    │ (Phase 1: Cookie Priority)          │
    └──────────────────────────────────────┘
             ↓ (if not Instagram)
    ┌─────────────────────────────────────┐
    │ Try Cobalt API (Phase 2)            │
    │ Works for: TikTok, Twitter, etc.    │
    └─────────────┬───────────────────────┘
                  ↓
        ┌─────────────────────┐
        │ API Success?        │
        └────┬────────────┬───┘
             │ YES        │ NO
             ↓           ↓
        [Download]  [Use yt-dlp Fallback]
             ↓           ↓
        ┌──────────────────────┐
        │ Save to DEST folder  │
        └──────────────────────┘
             ↓
        ┌──────────────────────┐
        │ Log & Complete       │
        └──────────────────────┘
```

### Features Breakdown

#### Phase 1: Instagram (Cookie Priority)
- Detects Instagram URLs
- Uses saved cookies for authentication
- Supports private/restricted content
- Falls back to public yt-dlp if cookies unavailable

#### Phase 2: Cobalt API (Public Links)
- Handles TikTok, Twitter, YouTube, and more
- Optimized for public/accessible content
- Fast and reliable

#### Phase 3: yt-dlp Fallback
- Universal video downloader
- Works with most platforms
- Automatic metadata embedding
- Preserves original timestamps

---

## 📜 Log File

All operations are logged to `~/download_manager.log`

**View recent downloads:**
```bash
tail -20 ~/download_manager.log
```

**Clear logs:**
```bash
> ~/download_manager.log
```

---

## 🐛 Troubleshooting

### "Command not found"
Make sure the installation completed successfully:
```bash
ls -la $PREFIX/bin/termux-url-opener
```

### Instagram downloads failing
Check if cookie file exists:
```bash
ls -la ~/.instagram-cookies.txt
```

### API timeouts
The Cobalt API might be temporarily down. Try:
```bash
# Check API status
curl -s https://api.cobalt.tools/ | head -20
```

### yt-dlp outdated
Update yt-dlp:
```bash
pip install --upgrade yt-dlp
```

### Permission denied
Make sure the script is executable:
```bash
chmod +x $PREFIX/bin/termux-url-opener
```

---

## 📦 Downloads

Downloads are saved to: **`/sdcard/Download/Termux/`** by default

You can access them through:
- Termux file manager
- Android file explorer
- Any media player app

---

## 🔐 Security & Privacy

- ✅ Cookies stored locally (not transmitted anywhere)
- ✅ All operations logged for transparency
- ✅ Uses HTTPS for API calls
- ✅ No external analytics or tracking
- ✅ Open source - inspect the code!

---

## 🤝 Contributing

Found a bug? Want to add a feature? Let's improve this together!

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## ⭐ Show Your Support

If this tool helped you, please give it a star! ⭐

```bash
# Share your feedback
echo "This tool is awesome! 🎉" >> my_feedback.txt
```

---

## 🙏 Acknowledgments

- Built with ❤️ for the Termux community
- Special thanks to [yt-dlp](https://github.com/yt-dlp/yt-dlp) for the amazing downloader
- Powered by [Cobalt API](https://cobalt.tools/) for multi-platform support

---

## 📞 Support

- **Issues?** [Open an GitHub Issue](https://github.com/Wilooper/Termux_dl/issues)
- **Questions?** Check existing issues or start a discussion
- **Want to contribute?** See Contributing section above

---

**Made with 💚 by [Wilooper](https://github.com/Wilooper)**

*Last Updated: 2026-02-03*