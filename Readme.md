# Slix

A flake with the aim to replace Nix's use of Bash, in favor of the modern and compatible Oil Shell. Here you'll find integrations and utilities providing better support for using Nix and Oil together.Mainly it provides a more up to date version of oil than what's usually available in `nixpkgs-unstable`.

## Grease

This is a general purpose library used to thicken up the oil shell.

## Faux Bash

> not yet implemented

OSH will error out when given most flags meant for Bash. This script is a wrapper that will strip offending flags and pass the remaining over to OSH. It is compiled using `shc`, to allow running as an interpreter.
