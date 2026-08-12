# SPDX-License-Identifier: Apache-2.0
# SPDX-FileCopyrightText: 2026 openDesk Edu Contributors
#
# Basic integration test for opendesk-nix
# Tests MariaDB service startup and connectivity

{ pkgs, ... }:

{
  name = "opendesk-mariadb-integration";

  nodes = {
    server = { config, ... }: {
      services.mysql = {
        enable = true;
        package = pkgs.mariadb;
        initialDatabases = [
          { name = "opendesk"; }
        ];
      };
      networking.firewall.allowedTCPPorts = [ 3306 ];
    };

    client = { ... }: {
      environment.systemPackages = [ pkgs.mariadb ];
    };
  };

  testScript = ''
    start_all()
    server.wait_for_unit("mysql.service")
    server.wait_for_open_port(3306)
    client.systemctl("start network-online.target")
    client.wait_for_unit("network-online.target")
    client.succeed(
      "mysql -h server -P 3306 -u root -e 'SHOW DATABASES;' | grep opendesk"
    )
  '';
}
