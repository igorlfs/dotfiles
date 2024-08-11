# ADMIN

> For all the stuff that requires root access and I'd otherwise forget to setup when reinstalling

## Arch

### AUR

- Problem: `makepkg` now builds debug packages by default. This sucks, cause I'm usually not interested in debug packages.
- Sources: <https://bbs.archlinux.org/viewtopic.php?pid=2150180#p2150180>
- Solution: disable debug packages by editing the `OPTIONS` variable inside `/etc/makepkg.conf`. Where it reads `debug` it should be `!debug`.
