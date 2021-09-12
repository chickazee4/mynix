this is mostly for me so i can easily duplicate my system but i have it public in case anybody wants to base their config off of this - this will set up a basic desktop system with most of what a typical user should need and it also appears to produce a working KDE environment, which i know sometimes doesn't happen on nix.

installation:
1. partition target disk as appropriate & mount everything necessary on /mnt
2. `git clone https://github.com/chickazee4/mynix.git`
3. `cp -pr mynix/* /mnt"
4. `nixos-generate-config --root /mnt`
5. select a GRUB theme from /extra/grub; instructions on this are found in `/extra/grub/instrux`
6. peruse and modify `/mnt/nixos/configuration.nix` as necessary - at minimum:
    * all references to "lyndsay" should be replaced with your own name
    * change networking.hostName to an acceptable value
    * change services.xserver.videoDrivers to the appropriate value
    * change the settings in programs.git to be your appropriate git credentials, or simply remove the latter three entries if you do not have git credentials
7. `nixos-install`
8. `reboot`
9. `passwd [your username]`
10. optionally, you may `cp /extra/icons /usr/[yourname]/.local/share/icons/reversal` - this derivative of the reversal icons has icons for all of the software included in the nix configuration, for which a lot of icons were missing in the original icon set.
