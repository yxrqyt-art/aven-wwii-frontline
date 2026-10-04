# Aven — WWII Frontline

A complete **nanos world technical showcase** designed around a WWII Military RP / frontline gameplay loop.

The project focuses on systems and code quality rather than custom map assets. It demonstrates a modular server-authoritative architecture with factions, soldier classes, sequential objectives, tickets, respawns, configurable weapons, scoring, networking and a client HUD.

> **Project status:** recruitment/portfolio prototype. Core API usage has been reviewed against nanos world a1.156 documentation. A real multiplayer runtime pass is still required before this can honestly be called production-ready.

## Portfolio objective

This repository demonstrates how **Aven** would structure the gameplay foundation of a serious Military RP: clear ownership of state, modular services, validated networking and configuration-driven systems. It is intentionally designed so a real project's maps and licensed WWII assets can be integrated without rewriting the match core.

## Features

- Allies vs Axis factions
- Automatic team balancing
- Manual faction requests with balance protection
- Rifleman, Medic, Support and Recon classes
- Sequential A → B → C frontline objectives
- Server-side capture zones
- Contested objective handling
- Team tickets
- Respawn waves
- Configurable WWII-inspired loadouts
- Server-authoritative score and match state
- Match timer and victory conditions
- Personal kills/deaths statistics
- Replicated HUD state
- Client battlefield HUD
- Faction-scoped squads with capacity limits
- Medic allied-heal workflow
- Support resupply workflow / asset integration point
- Key bindings
- Request validation and rate limiting
- Centralized configuration and logging
- Documentation for architecture, security, testing and extension

## Project structure

```text
Aven-WWII-Frontline/
├── Package.toml
├── README.md
├── LICENSE
├── Shared/
│   ├── Index.lua
│   ├── Constants.lua
│   └── Util.lua
├── Server/
│   ├── Index.lua
│   ├── Config.lua
│   ├── Logger.lua
│   ├── RateLimiter.lua
│   ├── FactionService.lua
│   ├── ClassService.lua
│   ├── WeaponService.lua
│   ├── PlayerService.lua
│   ├── ObjectiveService.lua
│   ├── MatchService.lua
│   └── NetworkService.lua
├── Client/
│   ├── Index.lua
│   ├── State.lua
│   ├── Network.lua
│   ├── InputController.lua
│   └── HUD.lua
└── docs/
    ├── ARCHITECTURE.md
    ├── SECURITY.md
    ├── TESTING.md
    ├── ROADMAP.md
    └── SHOWCASE.md
```

## Gameplay loop

1. A joining player is assigned to the least populated faction.
2. The player selects a soldier class.
3. The current frontline objective becomes capturable.
4. Server-side overlap tracking counts Allies and Axis soldiers inside the zone.
5. Numerical superiority advances capture progress; equal presence contests it.
6. Capturing an objective awards score/tickets and unlocks the next objective.
7. Death removes a team ticket and queues the player for a respawn.
8. The match ends on final objective capture, score target, ticket depletion or timer resolution.

## Default controls

| Action | Key |
|---|---|
| Scoreboard | Tab |
| Rifleman | F1 |
| Medic | F2 |
| Support | F3 |
| Recon | F4 |
| Request Allies | F5 |
| Request Axis | F6 |

## Installation

Place this directory under the nanos world server `Packages/` folder and enable `aven-wwii-frontline` in the server package list.

The demonstration coordinates in `Server/Config.lua` are placeholders intended to be adapted to the target map.

## Security model

The client never decides kills, score, tickets, objective progress or ownership. Client-originated requests are restricted to allowed actions such as class/faction requests, then validated and rate-limited server-side.

## Engineering choices

- configuration separated from logic;
- services have narrow responsibilities;
- authoritative state lives on the server;
- network event names are centralized;
- gameplay state sent to clients is explicitly serialized;
- no secrets or environment-specific credentials;
- extension points are documented.

## Author

**Aven** — gameplay / systems development.


## Code review status

The current revision specifically aligns its networking with nanos world's documented remote-event reliability parameter and delays gameplay spawning until the player's `Ready` lifecycle event. Canvas rendering is performed inside the Canvas `Update` event.

See [`docs/REVIEW.md`](docs/REVIEW.md) for the verification gates that remain before a production claim.

## Why this repository exists

This is not intended to imitate a finished commercial Military RP. It is a compact technical foundation that demonstrates how I structure gameplay code, protect authoritative state, isolate configuration, and prepare systems for future expansion.

— **Aven**


## Technical documentation

- [`docs/CASE-STUDY.md`](docs/CASE-STUDY.md) — design decisions and implementation response
- [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) — boundaries and service responsibilities
- [`docs/SECURITY.md`](docs/SECURITY.md) — trust model and remote-event rules
- [`docs/FEATURE-MATRIX.md`](docs/FEATURE-MATRIX.md) — implemented vs planned systems
- [`docs/TESTING.md`](docs/TESTING.md) — runtime verification matrix
- [`docs/REVIEW.md`](docs/REVIEW.md) — API/static review scope
- [`docs/INTERVIEW.md`](docs/INTERVIEW.md) — points for a technical discussion
