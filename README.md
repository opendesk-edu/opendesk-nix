# openDesk Nix

> Production-ready Nix-based infrastructure for openDesk Edu

[![Nix](https://img.shields.io/badge/NixOS-unstable-blue.svg?logo=NixOS)](https://nixos.org)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-1.28-blue.svg?logo=kubernetes)](https://kubernetes.io)
[![Compliance](https://img.shields.io/badge/ZKI--Compliance-64%25-green.svg)](docs/security/compliance.md)

## 📚 Documentation

- [Getting Started](docs/getting-started/quickstart.md)
- [Architecture Overview](docs/getting-started/architecture.md)
- [Deployment Guide](docs/deployment/kubernetes.md)
- [Security & Compliance](docs/security/compliance.md)
- [API Documentation](docs/api/services.md)

## 🏗️ Project Structure

```
├── docs/              # Documentation (all guides and specs)
├── platform/          # Core platform code
│   ├── nix/           # Nix build definitions
│   ├── kubernetes/    # K8s configurations
│   └── docker/        # Docker build definitions
├── examples/          # Production-ready examples
├── scripts/           # Automation scripts
├── monitoring/        # Observability (Prometheus/Grafana)
├── specs/             # Technical specifications
└── tests/             # Test suite
```

## 🚀 Quick Start

```bash
# Build a service image
nix build .#docker-image-sogo5

# Deploy to Kubernetes
nix run .#deploy-kubernetes -- --environment hrz

# Run compliance checks
nix run .#check-compliance
```

## 📖 Examples

- [Basic (MariaDB)](examples/basic/) - Single service deployment
- [Advanced (Groupware)](examples/advanced/) - Full groupware stack
- [Compliance (ZKI)](examples/compliance/) - ZKI-compliant setup

## 🔒 Security

See [SECURITY_POLICY.md](docs/security/security-policy.md) for security guidelines.

## 📄 License

See [LICENSE](LICENSE) for details.

---

## ⚠️ Repo-line note (2026-08-15)

Two divergent `opendesk-nix` repositories exist; **this one is the research/staging line**:

| Repo | Role | HEAD |
|---|---|---|
| `opendesk-edu/opendesk-nix` (**this**) | **Research / staging** — Phase 2–5 NixOS appliance images, systemd-sysupdate A/B OTA, Attic binary cache, remote builders (`DEPLOYMENT-READY.md`). Not deployed. | `main` (this branch) |
| `tobias-weiss-ai-xr/opendesk-nix` | **Production / cluster ops** — SCS K3s platform (intercom-service/OIDC, sealed secrets, sops, CI). The `umr` mirror on opencode.de tracks this line. | `main` (active) |

**Merge decision:** kept separate (a merge would conflict on `flake.nix` / `README.md` / `.sops.yaml`; experimental content is not wanted in the production repo). Port research findings selectively; do not merge wholesale.

