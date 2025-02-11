# tadyen_config
this is a very quick and dirty, poorly thought out spec for a config system

## 0 Goal
to automate syncing custom configs / overrides for a given package on a system.
this DOES NOT have anything to do with build systems, but the inspiration is from Arch PKGBUILD

## 1 Overview
- these are `TOML` files and follow the toml spec
- for specifivity of this function, they shall be strictly named `tadyen.toml`
- only 1 or none of it can exist per dir
- 1 file only applies to 1 application

## 2 Description

tbd properly ig.
- TBD: Support for root/sudo level config

### 2.1 Described values
assume snake_case for key value naming. CAPS is just for emphasis for now..
Stuff described:
    - Longname: full name of application eg. "neovim". This will probably be unused.
    - Name: shorthand name of application used for its config eg. "nvim"
    - Entries: Array of objects that follows the spec below
        - FROM dir: FROM is always in the parent directory. 
        - TO dir: TO is where the live config should live
        - SYNC TYPE
            - Options: 
                - MASTER (read-only, sync TO system)
                - SLAVE (write-only, sync FROM system)
                - DUPLEX (2-ways allows new files to be created with deletion, Default)
                - DUPLEX_SAFE (like duplex, but no deleting of files)

### 2.2 addtl properties/assumptions
- Copy/Syncing of directories is recursive.
- Config structure agnostic. There is no check nor description for how the configs are moved about.
- Assumes compliance with linux/posix [Filesystem Heirarchy Standard](https://refspecs.linuxfoundation.org/FHS_3.0/fhs/index.html)


## 3 Example

``` toml
# tadyen.toml
# This is a comment.

[tadyen_config]
name = "nvim"
longname = "neovim"

[[tadyen_config.entry]]
from = "./.config"
to = "$HOME/.config"
match = "nvim"      # can use globbing, defaults to '*' to glob all contents in <from>
sync = "duplex"

[[tadyen_config.entry]]
from = "./.config"
to = "/root/.config"
sync = "master"     # can still be overwritten due to entry above

```
