# SPDX-License-Identifier: Apache-2.0
# Appliance image integration test (public version)

{ pkgs, ... }:

{
  name = "appliance-image";

  nodes = {
    builder = { ... }: {};
    
    vm = pkgs.nixosTest {
      name = "k3s-appliance-vm";
      config = {
        # Basic K3s configuration for testing
        services.k3s = {
          enable = true;
          role = "server";
        };
      };
    };
  };

  testScript = ''
    # Build appliance image
    builder.succeed("nix build .#image-k3s-node")
    
    # Verify image exists
    builder.succeed("test -f result/disk-image.img")
    
    # Start VM
    vm.start()
    vm.wait_for_unit("multi-user.target")
    
    # Verify K3s service
    vm.succeed("systemctl is-active k3s")
  '';
}
