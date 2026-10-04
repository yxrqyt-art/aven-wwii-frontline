# Testing plan

This repository does not claim an in-engine test that has not been performed.

## Static review checklist

- package folders separated by runtime side;
- event names centralized;
- client cannot authoritatively mutate match state;
- class/faction inputs validated;
- remote requests rate-limited;
- configuration isolated from service logic;
- no secrets committed.

## In-engine verification checklist

1. Package loads without Lua/runtime errors.
2. Two clients receive balanced factions.
3. F1–F4 update class selection.
4. F5/F6 respect faction balance.
5. Character respawns with configured health/loadout.
6. Entering A changes capture progress.
7. Equal enemy presence contests capture.
8. Capturing A activates B; B activates C.
9. Death reduces the correct faction ticket count.
10. Ticket depletion ends the round.
11. Final objective capture ends the round.
12. HUD receives authoritative state once per second.
13. Disconnecting inside an objective does not leave stale occupancy.
14. Repeated remote spam is rate-limited.

## Known prototype limitation

Custom WWII weapon meshes are not bundled. The weapon definitions deliberately use a built-in placeholder skeletal mesh so the gameplay layer remains independent from proprietary/custom assets.
