# SPDX-License-Identifier: Apache-2.0
# SPDX-FileCopyrightText: 2026 openDesk Edu Contributors
#
# treefmt configuration for opendesk-nix
# Run with: nix fmt
# Check with: nix flake check

{ pkgs, ... }:

{
  settings = {
    tree-root-file = "flake.nix";
    on-unmatched = "info";

    formatter = {
      nixfmt = {
        command = pkgs.lib.getExe pkgs.nixfmt-classic;
        includes = [ "*.nix" ];
      };

      statix = {
        command = pkgs.lib.getExe pkgs.statix;
        options = [ "fix" ];
        no-positional-arg-support = true;
        includes = [ "*.nix" ];
      };

      deadnix = {
        command = pkgs.lib.getExe pkgs.deadnix;
        options = [ "--edit" ];
        includes = [ "*.nix" ];
      };

      prettier = {
        command = pkgs.lib.getExe pkgs.prettier;
        options = [ "--write" ];
        includes = [ "*.yaml" "*.yml" "*.json" "*.md" ];
      };

      shfmt = {
        command = pkgs.lib.getExe pkgs.shfmt;
        includes = [ "*.sh" "*.bash" ];
      };

      shellcheck = {
        command = pkgs.lib.getExe pkgs.shellcheck;
        includes = [ "*.sh" "*.bash" ];
        excludes = [ ".envrc" ];
      };
    };
  };
}
