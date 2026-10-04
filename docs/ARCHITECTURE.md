# Architecture

## Trust boundary

The package uses a server-authoritative model. Objective occupancy, capture progress, tickets, scoring, character spawning and loadouts are server-owned.

The client is responsible for:
- rendering state;
- receiving notices;
- submitting restricted class/faction requests.

## Services

### FactionService
Owns faction membership and balancing rules.

### ClassService
Validates class identifiers and stores the selected role.

### WeaponService
Builds weapons from configuration and gives them to spawned characters.

### PlayerService
Owns player lifecycle, character spawning and personal statistics.

### ObjectiveService
Creates server-side capture triggers, tracks occupants and advances the frontline.

### MatchService
Owns tickets, score, timer and victory conditions.

### NetworkService
Defines the client/server boundary and validates/rate-limits user requests.

## Data flow

```text
Input -> Remote request -> NetworkService -> validation -> domain service
                                                   |
Server tick -> ObjectiveService -> MatchService -> state snapshot -> client HUD
```

This separation keeps UI concerns out of gameplay rules and prevents the client from authoritatively modifying match state.
