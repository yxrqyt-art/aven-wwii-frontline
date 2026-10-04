# Contributing

Keep gameplay authority on the server. New client-originated requests must be allow-listed, validated and rate-limited.

## Pull request checklist

- One responsibility per change.
- No secrets or machine-specific paths.
- Configuration belongs in `Server/Config.lua`.
- Remote payloads are validated server-side.
- Documentation is updated when behavior changes.
- Do not claim runtime testing unless it was actually performed.
