# Docker Image Tags Reference

This document describes the Docker image tagging strategy for the MariaDB project.

## Tag Naming Convention

All images use the format: `snowdreamtech/mariadb:TAG`

Where `TAG` follows these patterns:

- **Variant-specific tags**: `TAG-variant` (e.g., `nightly-alpine`, `3.23.4-alpine`)
- **Default tags** (Debian only): `TAG` (e.g., `nightly`, `latest`, `13.4.0`)

## Supported Registries

All tags are pushed to three registries:

- **DockerHub**: `snowdreamtech/mariadb:TAG`
- **GitHub Container Registry**: `ghcr.io/snowdreamtech/mariadb:TAG`

## Tag Scenarios

### 1. Branch Builds (dev/main)

#### Push to `dev` branch

```bash
git push origin dev
```

**Generated tags:**

```
snowdreamtech/mariadb:dev-alpine
snowdreamtech/mariadb:dev-debian
snowdreamtech/mariadb:dev              # ← Debian (default)
snowdreamtech/mariadb:dev-rocky
```

#### Push to `main` branch

```bash
git push origin main
```

**Generated tags:**

```
snowdreamtech/mariadb:main-alpine
snowdreamtech/mariadb:latest-alpine
snowdreamtech/mariadb:main-debian
snowdreamtech/mariadb:latest-debian
snowdreamtech/mariadb:main             # ← Debian (default)
snowdreamtech/mariadb:latest           # ← Debian (default)
snowdreamtech/mariadb:main-rocky
snowdreamtech/mariadb:latest-rocky
```

---

### 2. Release Tags (Semantic Versioning)

#### Alpine Release

```bash
git tag alpine-v3.23.4
git push origin alpine-v3.23.4
```

**Generated tags:**

```
snowdreamtech/mariadb:3.23.4-alpine
snowdreamtech/mariadb:latest-alpine
```

#### Debian Release

```bash
git tag debian-v13.4.0
git push origin debian-v13.4.0
```

**Generated tags:**

```
snowdreamtech/mariadb:13.4.0-debian
snowdreamtech/mariadb:latest-debian
snowdreamtech/mariadb:13.4.0           # ← Debian (default)
snowdreamtech/mariadb:latest           # ← Debian (default)
```

#### Rocky Release

```bash
git tag rocky-v10.1.0
git push origin rocky-v10.1.0
```

**Generated tags:**

```
snowdreamtech/mariadb:10.1.0-rocky
snowdreamtech/mariadb:latest-rocky
```

---

### 3. Nightly Builds (Scheduled)

**Trigger:** Automatically every day at 17:00 UTC

**Generated tags:**

```
# Alpine
snowdreamtech/mariadb:nightly-alpine
snowdreamtech/mariadb:20260427-alpine

# Debian (with default tags)
snowdreamtech/mariadb:nightly-debian
snowdreamtech/mariadb:20260427-debian
snowdreamtech/mariadb:nightly          # ← Debian (default)
snowdreamtech/mariadb:20260427         # ← Debian (default)

# Rocky
snowdreamtech/mariadb:nightly-rocky
snowdreamtech/mariadb:20260427-rocky
```

---

## Tag Priority

Tags are generated with the following priority (higher number = higher priority):

| Priority | Type | Example Tags | Trigger |
|----------|------|--------------|---------|
| 1000 | Nightly | `nightly`, `nightly-alpine` | Schedule |
| 900 | Date | `20260427`, `20260427-alpine` | Schedule |
| 800 | Version | `3.23.4-alpine`, `13.4.0` | Tag push |
| 600 | Branch | `dev-alpine`, `main-debian` | Branch push |
| 200 | Latest | `latest`, `latest-alpine` | Main/Tag |

---

## Default Variant (Debian)

Debian is designated as the **default variant** (`is_latest: true`), which means:

✅ **Debian gets BOTH suffixed AND unsuffixed tags:**

```
snowdreamtech/mariadb:nightly-debian   # Variant-specific
snowdreamtech/mariadb:nightly          # Default (no suffix)

snowdreamtech/mariadb:13.4.0-debian    # Variant-specific
snowdreamtech/mariadb:13.4.0           # Default (no suffix)

snowdreamtech/mariadb:latest-debian    # Variant-specific
snowdreamtech/mariadb:latest           # Default (no suffix)
```

❌ **Alpine and Rocky get ONLY suffixed tags:**

```
snowdreamtech/mariadb:nightly-alpine   # Variant-specific only
snowdreamtech/mariadb:nightly-rocky    # Variant-specific only
```

---

## Usage Examples

### Pull the latest Debian image (default)

```bash
docker pull snowdreamtech/mariadb:latest
# or
docker pull snowdreamtech/mariadb:latest-debian
```

### Pull the latest Alpine image

```bash
docker pull snowdreamtech/mariadb:latest-alpine
```

### Pull the latest Rocky image

```bash
docker pull snowdreamtech/mariadb:latest-rocky
```

### Pull a specific version

```bash
# Alpine 3.23.4
docker pull snowdreamtech/mariadb:3.23.4-alpine

# Debian 13.4.0 (two ways)
docker pull snowdreamtech/mariadb:13.4.0-debian
docker pull snowdreamtech/mariadb:13.4.0

# Rocky 10.1.0
docker pull snowdreamtech/mariadb:10.1.0-rocky
```

### Pull nightly builds

```bash
# Alpine nightly
docker pull snowdreamtech/mariadb:nightly-alpine

# Debian nightly (two ways)
docker pull snowdreamtech/mariadb:nightly-debian
docker pull snowdreamtech/mariadb:nightly

# Rocky nightly
docker pull snowdreamtech/mariadb:nightly-rocky
```

---

## Tag Lifecycle

### Development Flow

```
1. Push to dev → mariadb:dev-alpine, mariadb:dev-debian, mariadb:dev, mariadb:dev-rocky
2. Push to main → mariadb:main-alpine, mariadb:latest-alpine, mariadb:main-debian, mariadb:latest-debian, mariadb:main, mariadb:latest, mariadb:main-rocky, mariadb:latest-rocky
3. Create tag → mariadb:VERSION-variant, mariadb:latest-variant (+ unsuffixed for Debian)
```

### Release Flow (with Release Please)

```
1. Merge PR to main → Release Please creates release PR
2. Merge release PR → Release Please creates tags (alpine-vX.Y.Z, debian-vX.Y.Z, rocky-vX.Y.Z)
3. Tag push triggers build → Images published with version tags
```

---

## Matrix Configuration

The workflow uses a matrix strategy with three variants:

```yaml
matrix:
  include:
    - variant: alpine
      version: "3.23.4"
      is_latest: false

    - variant: debian
      version: "13.4.0"
      is_latest: true    # ← Default variant

    - variant: rocky
      version: "10.1.0"
      is_latest: false
```

Only the variant with `is_latest: true` receives unsuffixed tags.

---

## Metadata Action Configuration

The key configuration that enables this tagging strategy:

```yaml
images: |
  name=snowdreamtech/mariadb,enable=true
  name=ghcr.io/snowdreamtech/mariadb,enable=true
flavor: |
  latest=false
  prefix=
  suffix=-${{ matrix.variant }}  # ← Adds variant suffix to all tags
```

For Debian (is_latest), additional rules generate unsuffixed tags:

```yaml
type=raw,enable=${{ matrix.is_latest }},priority=1000,prefix=,suffix=,pattern=nightly
```

This creates both `nightly-debian` (from flavor suffix) and `nightly` (from this rule).
