# Aven — WWII Frontline

WWII Frontline is a multiplayer gameplay framework built for **nanos world**, with a focus on Military RP and objective-based combat.

The project provides the gameplay foundation for a two-faction frontline mode while keeping maps, models and project-specific assets independent from the core systems.

## Overview

The framework currently handles:

- Allies and Axis factions
- Automatic team balancing
- Soldier classes
- Sequential objectives
- Capture zones
- Team tickets and scoring
- Respawns
- Squads
- Role-specific abilities
- Player statistics
- Client HUD
- Server-side networking validation

The server remains authoritative over gameplay state. Clients send requests and receive replicated state, but do not directly control critical systems such as objectives, tickets, factions or player health.

---

## Gameplay

### Factions

Players fight for either the **Allies** or the **Axis**.

Faction management handles automatic balancing as well as manual team requests. Balance checks are performed server-side before a player can change faction.

### Classes

Four roles are currently available:

| Class | Role |
| --- | --- |
| Rifleman | Standard frontline infantry |
| Medic | Allied healing and medical support |
| Support | Ammunition and logistics support |
| Recon | Lightweight reconnaissance |

Class selection is validated by the server and loadouts are configurable independently from the class logic.

### Objectives

The frontline follows a sequential objective system:

```text
A  ->  B  ->  C
```

Only the active objective can progress.

Capture zones track faction presence and handle contested states, capture progress, score updates and ticket rewards.

### Tickets

Each faction starts with a configurable number of tickets.

Tickets can be affected by:

- player deaths;
- objective captures;
- match progression.

The match ends when a victory condition is reached.

### Squads

Players can be assigned to faction-specific squads:

```text
Alpha
Bravo
Charlie
Dog
```

Squad membership is validated server-side and each squad can have its own capacity limit.

The system is intentionally kept separate from faction management so squad leaders, rally points and command features can be added later without changing the faction service.

### Role abilities

Medic and Support interactions have their own server-side validation.

Checks include:

- player class;
- faction;
- target;
- interaction distance;
- cooldown;
- target state.

The client cannot directly apply health or gameplay changes.

---

## Architecture

The project is separated by responsibility rather than keeping the entire game mode in a single script.

```text
Client/
    HUD.lua
    Index.lua
    InputController.lua
    Network.lua
    State.lua

Server/
    ClassService.lua
    Config.lua
    FactionService.lua
    Index.lua
    Logger.lua
    MatchService.lua
    NetworkService.lua
    ObjectiveService.lua
    PlayerService.lua
    RateLimiter.lua
    RoleAbilityService.lua
    SquadService.lua
    WeaponService.lua

Shared/
    Constants.lua
    Index.lua
    Util.lua

docs/
    ARCHITECTURE.md
    CASE-STUDY.md
    FEATURE-MATRIX.md
    INTERVIEW.md
    REVIEW.md
    ROADMAP.md
    SECURITY.md
    SHOWCASE.md
    STATIC-AUDIT.md
    TESTING.md
```

### Server

The server owns the authoritative gameplay state.

Services are kept independent where possible. For example, `ObjectiveService` manages capture logic while `MatchService` manages the overall round state.

### Client

The client is responsible for input and presentation.

It receives replicated match information from the server and uses that state to update the HUD.

### Shared

Shared modules contain constants and utilities required by both environments.

---

## Networking

Remote events are handled through a dedicated networking layer.

Requests coming from clients are validated before reaching authoritative gameplay systems.

The current implementation includes:

- remote event allow-listing;
- per-player rate limiting;
- faction validation;
- class validation;
- squad validation;
- distance checks;
- cooldown checks;
- server-owned health changes;
- server-owned objective state;
- server-owned tickets and scoring.

Reliable events are used for explicit actions and important notifications. State that is refreshed frequently can use unreliable delivery when an older packet is no longer useful.

More details are available in [`docs/SECURITY.md`](docs/SECURITY.md).

---

## Configuration

Gameplay values are centralized in the server configuration.

This includes values such as:

- faction spawns;
- objective positions;
- capture settings;
- starting tickets;
- respawn delay;
- match duration;
- class settings;
- loadouts;
- squad limits.

This keeps balancing changes separate from the implementation of the individual services.

---

## Assets

The repository focuses on gameplay code and does not include a custom WWII map or proprietary asset pack.

Final projects can provide their own:

- maps;
- weapons;
- uniforms;
- characters;
- vehicles;
- animations;
- sounds;
- interface assets.

The gameplay layer is designed so these can be integrated without replacing the match architecture.

---

## Documentation

Technical notes are kept in the [`docs`](docs/) directory.

| Document | Purpose |
| --- | --- |
| [`ARCHITECTURE.md`](docs/ARCHITECTURE.md) | Project architecture and service responsibilities |
| [`SECURITY.md`](docs/SECURITY.md) | Networking and server-authority model |
| [`FEATURE-MATRIX.md`](docs/FEATURE-MATRIX.md) | Current and planned functionality |
| [`CASE-STUDY.md`](docs/CASE-STUDY.md) | Implementation decisions |
| [`TESTING.md`](docs/TESTING.md) | Multiplayer validation checklist |
| [`ROADMAP.md`](docs/ROADMAP.md) | Possible future development |

Additional review and showcase notes are also available in the same directory.

---

## Status

WWII Frontline is currently a technical portfolio prototype.

The core architecture and gameplay systems are implemented as a foundation for further integration with a complete nanos world project. Final balancing, project-specific assets and multiplayer validation depend on the environment in which the framework is integrated.

---

## Author

**Aven**

Gameplay systems, Discord applications and web development.
