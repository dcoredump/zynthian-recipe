--- recipe
---
name: mod-host
--- build
---
configure: no-configure-required
create: make
install: 'sudo make install'
--- sources
---
path: /tmp
program: git
url: https://github.com/moddevices/mod-host.git
--- requires
---
packet: libreadline-dev
recipe: no-recipe-required
