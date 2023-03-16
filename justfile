#!/usr/bin/env -S just --justfile
# https://github.com/casey/just

bt := '0'

export RUST_BACKTRACE := bt

log := "warn"

export JUST_LOG := log

### run playbook
configure HOST *TAGS:
  ansible-playbook -b playbooks/configure.yaml --limit {{HOST}} {{TAGS}}



## repo stuff
# optionally use --force to force reinstall all requirements
reqs *FORCE:
	ansible-galaxy install -r requirements.yaml {{FORCE}}

# just vault (encrypt/decrypt/edit)
vault ACTION:
    EDITOR='code --wait' ansible-vault {{ACTION}} vars/vault.yaml