# Installing Sidekick+

Installing Sidekick+ is super simple and should only take a few minutes! To start, [download the latest release](https://github.com/hautvfami/sidekick_plus/releases/latest) or build from source (like any other Flutter application).

# Windows

There are two ways to install Sidekick+ on Windows:

- **MSIX** (recommended) — run the file named `sidekick-windows-x.x.x.msix` if you wish to install Sidekick+ on your PC. See [Installing with MSIX](#installing-with-msix) for instructions.
- **Portable** — download `windows-x.x.x.zip`, extract it and just run `sidekick.exe` to use Sidekick+ without installing anything.

## Installing with MSIX

Download the `sidekick-windows-x.x.x.msix` file.

Unfortunately, it isn't as easy as opening the file and installing it, as the package is signed with a test certificate.

To install Sidekick+, first right-click the file and click on `Properties`.

Then, navigate to `Digital Signatures`. You will see a signature called `Msix Testing` or `Sidekick`, you will need to add this to the Windows key-store. To do this, double-click on the signature and click on `View Certificate`. Next, click on `Install Certificate` and then on `Local Machine`. Finally, select the key-store called `Trusted Root Certification Authorities` under `Browse`.

After completing those steps you should now be able to install Sidekick+ using the MSIX package.

### Using the portable version

If you don't wish to install a certificate, you can also simply save `sidekick.exe` and all of the other files wherever you want, then create a desktop shortcut. Please note that the auto-update feature will not work with the portable version!

# MacOS

In order to install Sidekick+ on MacOS we recommend downloading the file named `sidekick-macos-x.x.x.dmg`, if you wish to install Sidekick+ on your Mac, please check [Installing with DMG](#installing-with-dmg-recommended). Alternatively, you can just run the `Sidekick` app directly to use Sidekick+ without having to install anything, by downloading `macos-x.x.x.zip`.

## Installing with DMG (Recommended)

To install Sidekick+ on your Mac, simply open `Sidekick.dmg` and drag the Sidekick app to the `Applications` folder next to it. If you are updating the app, you'll need to click `Replace`.

After doing this you should be able to see `Sidekick` in your Launchpad. However, if you try to open it you might get a message saying that `"Sidekick" can't be opened because Apple cannot check it for malicious software.` In order to fix this, open `System Preferences` and click on `Security & Privacy`, where you'll see a message saying `"Sidekick" was blocked from use because it is not from an identified developer`. To complete the installation, click `Open Anyway` and then `Open` in the popup.

Done! You should now be able to use Sidekick+ normally!

## Using the portable version

To use the portable version of Sidekick+ on your Mac, simply locate `Sidekick` and drag it wherever you want to store the app.

After doing this you should be able to open `Sidekick`. However, if you try to open it you might get a message saying that `"Sidekick" can't be opened because Apple cannot check it for malicious software.` In order to fix this, open `System Preferences` and click on `Security & Privacy`, where you'll see a message saying `"Sidekick" was blocked from use because it is not from an identified developer`. To complete the installation, click `Open Anyway` and then `Open` in the popup.

# Linux

Download the `sidekick-linux-x.x.x.AppImage` file.

Make it executable and run it:

```bash
chmod +x sidekick-linux-x.x.x.AppImage
./sidekick-linux-x.x.x.AppImage
```

Alternatively, download `linux-x.x.x.zip`, extract it and run the `sidekick` binary inside.
