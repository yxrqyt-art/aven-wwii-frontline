# Security notes

## Server-authoritative values

Clients cannot submit:
- kills/deaths;
- tickets;
- match score;
- capture progress;
- objective owner;
- match winner.

## Remote requests

Only class selection, faction selection and state requests are exposed. Requests are rate-limited and values are checked against server configuration.

## Team balance

Faction changes are rejected when they would exceed the configured population difference.

## Secrets

The repository contains no token, API key, password or environment credential.

## Production hardening

Before deployment, add structured audit logging, persistence only where needed, administrative permission checks and abuse telemetry appropriate to the final server.
