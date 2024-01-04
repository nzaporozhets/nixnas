{ config, pkgs, ... }:

{ boot.supportedFilesystems = [ "zfs" ];
  networking.hostId = "98ddfc07";
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
boot.loader.efi.efiSysMountPoint = "/boot/efi";
boot.loader.efi.canTouchEfiVariables = false;
boot.loader.generationsDir.copyKernels = true;
boot.loader.grub.efiInstallAsRemovable = true;
boot.loader.grub.enable = true;
boot.loader.grub.copyKernels = true;
boot.loader.grub.efiSupport = true;
boot.loader.grub.zfsSupport = true;
boot.loader.grub.extraPrepareConfig = ''
  mkdir -p /boot/efis
  for i in  /boot/efis/*; do mount $i ; done

  mkdir -p /boot/efi
  mount /boot/efi
'';
boot.loader.grub.extraInstallCommands = ''
ESP_MIRROR=$(mktemp -d)
cp -r /boot/efi/EFI $ESP_MIRROR
for i in /boot/efis/*; do
 cp -r $ESP_MIRROR/EFI $i
done
rm -rf $ESP_MIRROR
'';
boot.loader.grub.devices = [
      "/dev/disk/by-id/ata-HP_SSD_S650_240GB_HASA23231402506"
      "/dev/disk/by-id/ata-HP_SSD_S650_240GB_HASA23231402510"
    ];
users.users.root.initialHashedPassword = "$6$rRx12j7hcaGbq66c$C27GTyKkghNPdiFjYzsHqFW9f8dc8lzWYFan116KuFGKg7u1ktBRsAUvdyC4/HmooN/ECtNppQXxmL6jsvEvW.";
}
