# macOS Launchpad Restoration Tool

> ⚠️ **Deprecation Notice**  
> This project is no longer functional or supported as of **macOS Tahoe 26.1**.  
> Changes introduced in macOS Tahoe 26.1 make it impossible to restore or modify classic Launchpad functionality using this tool.  
> No further updates will be provided.

**Alternative:**  
For similar functionality or an alternative to Launchpad restoration, see [LaunchNow](https://github.com/ggkevinnnn/LaunchNow) by @ggkevinnnn.

A powerful command-line tool for managing Launchpad behavior in macOS by modifying system preferences to restore classic Launchpad functionality.

## 🚀 Features

- **Restore Classic Launchpad**: Activate the old Launchpad behavior from previous macOS versions
- **Revert to Default**: Return to the standard macOS Launchpad behavior
- **System Compatibility Check**: Automatically verifies macOS version compatibility
- **Safe Operation**: Built-in warnings and confirmations to prevent accidental system modifications
- **Administrator Privileges**: Secure handling of system-level changes

## 📋 Requirements

- **macOS Version**: macOS 26 Tahoe
- **Administrator Access**: Required for modifying system files
- **Terminal Access**: Command-line interface

## 🔧 Installation

1. Clone this repository or download the script:
   ```bash
   git clone https://github.com/your-username/macosLaunchpad.git
   cd macosLaunchpad
   ```

2. Make the script executable:
   ```bash
   chmod +x script.sh
   ```

## 🖥️ Usage

Run the script with administrator privileges:

```bash
sudo ./script.sh
```

### Menu Options

The script provides an interactive menu with the following options:

1. **Activate Old Launchpad** - Restores classic Launchpad behavior
2. **Deactivate Old Launchpad** - Returns to default macOS Launchpad
3. **Exit Program** - Exits without making changes

## ⚠️ Important Warnings

> **USE AT YOUR OWN RISK!**

- This script modifies macOS system files and requires administrator privileges
- Improper use may cause system instability or unexpected behavior
- **Always create a system backup before use**
- **A Mac restart is required** after any operation for changes to take effect
- The author is not responsible for any damage caused by this tool

## 🔍 How It Works

The script modifies the SpotlightUI.plist file located at:
```
/Library/Preferences/FeatureFlags/Domain/SpotlightUI.plist
```

### Activation Process
- Creates the required directory structure
- Writes configuration to disable SpotlightPlus feature
- Sets `Enabled` to `false` in the plist file

### Deactivation Process
- Removes the custom configuration file
- Restores default macOS Launchpad behavior

## 📁 File Structure

```
macosLaunchpad/
├── script.sh          # Main script file
└── README.md          # This documentation
```

## 🛡️ Safety Features

- **System Compatibility Check**: Verifies macOS version before proceeding
- **User Confirmation**: Requires explicit user consent for risky operations
- **Administrator Verification**: Securely handles sudo privileges
- **Clear Warnings**: Displays comprehensive risk information
- **Graceful Error Handling**: Provides informative error messages

## 🎨 Script Features

- **Colorized Output**: Beautiful terminal interface with color-coded messages
- **Progress Indicators**: Clear visual feedback for all operations
- **Professional Formatting**: Well-organized banner and section headers
- **Error Recovery**: Robust error handling and user guidance

## 🔄 Version Information

- **Version**: 1.0 (2025)
- **Author**: Semnykcze
- **Compatibility**: macOS 15-26

## 🐛 Troubleshooting

### Common Issues

1. **Permission Denied**: Ensure you're running with `sudo`
2. **Unsupported macOS Version**: Check that you're running macOS 15-26
3. **Changes Not Applied**: Remember to restart your Mac after running the script

### Getting Help

If you encounter issues:
1. Check the system compatibility
2. Ensure you have administrator privileges
3. Verify the script has execute permissions
4. Restart your Mac after making changes

## 📝 License

This project is provided as-is without warranty. Use at your own risk.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

## 📞 Support

For support and questions, please open an issue on the GitHub repository.

---

**Remember**: Always backup your system before making modifications, and restart your Mac after using this tool for changes to take effect.
