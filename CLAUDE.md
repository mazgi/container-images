# Project Guidelines

## compose.yaml

- Services must be sorted alphabetically within each group.
- Active services (without `profiles: disabled`) come first, followed by a `# ====` separator, then disabled services.
- Keys within each service definition must be sorted alphabetically (e.g., `build`, `command`, `environment`, `init`, `ports`, `profiles`, `user`, `volumes`, `working_dir`).
