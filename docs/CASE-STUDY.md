# Technical case study — WWII Frontline

## Brief

Build a reusable technical foundation for a nanos world Military RP / WWII project without coupling the game rules to a specific map or proprietary asset pack.

## Design response

### Server authority
The server owns factions, class validity, squads, health interactions, capture state, tickets, score, spawn state and victory conditions.

### Frontline
Objectives are sequential. Server-side triggers track faction presence; numerical advantage advances progress and equal presence contests it.

### Roles
- Rifleman: baseline combat role.
- Medic: validated short-range allied healing.
- Support: validated short-range resupply workflow with an explicit weapon-system adapter point.
- Recon: lower-health precision role prepared for future spotting/intelligence systems.

### Squads
Faction-scoped Alpha/Bravo/Charlie/Dog squads have configurable capacity. Membership is validated server-side.

### Networking
Remote actions are allow-listed and rate-limited. Frequent authoritative snapshots use unreliable delivery because newer state supersedes older state; explicit actions/notices use reliable delivery.

### Extensibility
Weapon assets, map coordinates and balance values live in configuration. The final project's proprietary WWII assets can be plugged in without rewriting match rules.

## What I would build next for a production Military RP

- squad leader orders and rally points;
- downed/revive state;
- radio channels and command net;
- role quotas;
- vehicle crews;
- deployable logistics;
- persistence and moderation/audit trail;
- WebUI deployment screen and tactical map;
- automated integration/smoke tests where the engine workflow permits.
