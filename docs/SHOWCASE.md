# Showcase guide

## What to show a recruiter/client

Start with `README.md`, then show:
1. `Server/Index.lua` for composition and lifecycle.
2. `ObjectiveService.lua` for the frontline capture system.
3. `MatchService.lua` for authoritative match rules.
4. `NetworkService.lua` and `SECURITY.md` for validation/security.
5. `Config.lua` to demonstrate how the prototype adapts to another map/game design.

## Suggested explanation

This prototype is a technical foundation for a Military RP/frontline server. The goal is to demonstrate how gameplay systems are separated and secured rather than to ship a finished map. The architecture is designed so custom WWII assets, additional classes, squads, radio systems, vehicles and persistence can be added without rewriting the match core.
