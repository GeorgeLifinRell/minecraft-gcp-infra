# minecraft-gcp-infra

Terraform for deploying a PaperMC-based Minecraft server on Google Cloud's always-free eligible `e2-micro` VM.

## Prerequisites

- Terraform >= 1.5
- A GCP project with billing enabled
- `gcloud` authenticated or `GOOGLE_APPLICATION_CREDENTIALS` configured

## Quick start

1. Create a `terraform.tfvars` file:

```hcl
project_id        = "your-gcp-project-id"
region            = "us-central1"
zone              = "us-central1-a"
instance_name     = "minecraft-free"
minecraft_version = "1.21.1"
xms_mb            = 512
xmx_mb            = 768
```

2. Deploy:

```bash
terraform init
terraform apply
```

3. Get server IP:

```bash
terraform output minecraft_server_ip
```

Connect your Minecraft client to `<output-ip>:25565`.

## Notes

- The VM type is pinned to `e2-micro` for always-free eligibility.
- Always-free `e2-micro` is restricted to `us-central1`, `us-east1`, and `us-west1`; the Terraform `region` variable enforces this.
- The startup script installs Java 21, downloads the latest Paper build for your chosen version, accepts EULA, and runs Minecraft as a systemd service.
- Always-free eligibility depends on region/usage limits and can change by account. Verify current limits in GCP pricing docs.
