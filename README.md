zynthian-recipe
===============

This is a respository for some scripts for building software package for
Zynthian. The scripts are organized in the folowing types:

- install_*
  Installattion of a system or a software package
- run_*
  Running a software package
- update_*
  Update a software package

The scripts are organized as shell scripts but mostly I use them line-by-line
(with cut'n'paste). The do not catch errors so calling them directly would give
strange results when something goes wrong inside the script.

Some scripts need patches or additionaly scripts for installation. Those are
lying around in directories or files among the other stuff. I will create a
better structure when I am ready with testing and onyl doing bug fixing.

