# Aven — WWII Frontline

A complete **nanos world technical showcase** designed around a WWII Military RP / frontline gameplay loop.

The project focuses on gameplay systems, code quality and maintainability rather than custom map assets. It demonstrates a modular, server-authoritative architecture with factions, soldier classes, sequential objectives, tickets, respawns, configurable loadouts, scoring, networking and a client HUD.

> **Project status:** technical portfolio prototype built around the nanos world API and designed for further integration, balancing and multiplayer validation within a production project.

## Portfolio objective

This repository demonstrates how **Aven** would structure the gameplay foundation of a serious Military RP project: clear ownership of game state, modular services, validated networking and configuration-driven systems.

The architecture is intentionally designed so that a production project's maps, licensed WWII assets, weapons and additional gameplay systems can be integrated without rewriting the core match logic.

## Features

### Factions

- Allies vs Axis
- Automatic team balancing
- Manual faction selection
- Balance protection
- Server-authoritative faction state

### Soldier classes

Four configurable combat roles are included:

- **Rifleman** — standard frontline infantry
- **Medic** — allied healing and medical support
- **Support** — ammunition and logistics support
- **Recon** — lightweight reconnaissance role

Class selection and gameplay actions are validated server-side.

### Frontline objectives

The match is built around sequential objectives:

**A → B → C**

Features include:

- Server-side capture zones
- Sequential objective progression
- Contested objectives
- Faction presence tracking
- Capture progress
- Ticket rewards
- Score updates
- Objective state replication

### Ticket system

Each faction has a configurable ticket pool.

Tickets are affected by:

- Player deaths
- Objective captures
- Match progression

Ticket state is controlled by the server and replicated to clients.

### Respawn system

The project includes:

- Server-controlled respawns
- Configurable respawn delay
- Faction spawn locations
- Character recreation
- Automatic loadout assignment

### Squads

Faction-scoped squads provide a foundation for organized Military RP gameplay.

Available squads:

- Alpha
- Bravo
- Charlie
- Dog

Squad membership includes:

- Server-side validation
- Configurable capacity limits
- Faction restrictions
- Replicated squad information

The architecture can later support squad leaders, rally points, orders and command systems.

### Medic system

The Medic role includes a server-authoritative allied healing workflow.

Validation includes:

- Correct class
- Valid target
- Same faction
- Maximum interaction distance
- Target availability
- Ability cooldown

Health values are modified only by the server.

### Support system

The Support role includes the foundation for an ammunition resupply system.

Validation includes:

- Correct class
- Allied target
- Interaction distance
- Target availability
- Cooldown protection

The final ammunition implementation is intentionally separated from the core gameplay because it depends on the weapon and asset system used by the production project.

### Match system

The match layer manages:

- Match state
- Team tickets
- Team score
- Match timer
- Victory conditions
- Player deaths
- Objective progression

This keeps match rules independent from networking, player lifecycle and individual gameplay systems.

### Player statistics

Match-local player statistics include:

- Kills
- Deaths
- Faction
- Class
- Squad

The structure can later be connected to a persistent statistics system.

### HUD

The client HUD displays replicated battlefield information such as:

- Faction
- Class
- Squad
- Tickets
- Score
- Active objective
- Capture progress
- Match information

The client displays authoritative state received from the server rather than calculating important gameplay values locally.

## Networking & security

Competitive and RP-critical state is controlled by the server.

Remote requests are treated as requests rather than trusted commands.

The networking layer includes:

- Server-side input validation
- Remote event allow-listing
- Per-player action rate limiting
- Class validation
- Faction validation
- Squad validation
- Distance validation
- Cooldown validation
- Authoritative health changes
- Authoritative objective state
- Authoritative ticket and score state

Reliable networking is used for explicit gameplay actions and notices, while frequently refreshed state can use unreliable delivery when newer state supersedes older snapshots.

## Architecture

The project separates responsibilities into dedicated modules.

```text
aven-wwii-frontline/
├── Client/
│   ├── HUD.lua
│   ├── Index.lua
│   ├── InputController.lua
│   ├── Network.lua
│   └── State.lua
│
├── Server/
│   ├── ClassService.lua
│   ├── Config.lua
│   ├── FactionService.lua
│   ├── Index.lua
│   ├── Logger.lua
│   ├── MatchService.lua
│   ├── NetworkService.lua
│   ├── ObjectiveService.lua
│   ├── PlayerService.lua
│   ├── RateLimiter.lua
│   ├── RoleAbilityService.lua
│   ├── SquadService.lua
│   └── WeaponService.lua
│
├── Shared/
│   ├── Constants.lua
│   ├── Index.lua
│   └── Util.lua
│
├── docs/
│   ├── ARCHITECTURE.md
│   ├── CASE-STUDY.md
│   ├── FEATURE-MATRIX.md
│   ├── INTERVIEW.md
│   ├── REVIEW.md
│   ├── ROADMAP.md
│   ├── SECURITY.md
│   ├── SHOWCASE.md
│   ├── STATIC-AUDIT.md
│   └── TESTING.md
│
├── CONTRIBUTING.md
├── LICENSE
├── Package.toml
└── README.md
## Design principles

The implementation follows several core principles:

### Server authority

Important gameplay state is owned and modified by the server.

### Separation of responsibilities

Networking, factions, classes, objectives, players, squads, weapons and match rules are separated into dedicated services.

### Configuration-driven gameplay

Balance values, spawn locations, objectives and gameplay parameters are centralized so they can be adjusted without rewriting the core systems.

### Defensive networking

Client input is validated before it can affect authoritative game state.

### Extensibility

The architecture is designed to support additional Military RP systems without requiring a complete rewrite.

## Production integration

The repository intentionally does not bundle proprietary map or WWII asset packs.

A production project can integrate its own:

- WWII weapon models
- Character models
- Uniforms
- Maps
- Vehicles
- Sounds
- Animations
- UI assets

These elements can be connected to the existing gameplay services through configuration and dedicated adapters.

## Planned extensions

The architecture is prepared for additional systems such as:

- Squad leaders
- Rally points
- Downed state
- Medic revive system
- Role limits
- Command hierarchy
- Radio channels
- Command radio
- Tactical deployment screen
- Tactical map
- Vehicle crews
- Logistics
- Deployable supplies
- Persistent statistics
- Administration tools
- Moderation logs
- Persistent player progression

## Documentation

Additional technical documentation is available in the `docs/` directory.

- `ARCHITECTURE.md` — architecture and service responsibilities
- `CASE-STUDY.md` — implementation and design decisions
- `FEATURE-MATRIX.md` — implemented and planned systems
- `SECURITY.md` — networking and trust model
- `TESTING.md` — multiplayer validation checklist
- `ROADMAP.md` — possible future development
- `REVIEW.md` — technical review scope
- `SHOWCASE.md` — portfolio presentation
- `INTERVIEW.md` — technical discussion points
- `STATIC-AUDIT.md` — static repository review

## Author

**Aven**

Discord Bot Developer · Web Developer · Gameplay Systems Developer

This repository is presented as a technical portfolio project demonstrating modular gameplay architecture and server-authoritative systems for nanos world.
