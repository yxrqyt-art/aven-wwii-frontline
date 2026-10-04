# Discussion notes

This repository is intended to make a technical conversation easy.

## Decisions worth discussing

**Why server-authoritative?**  
Competitive/RP state must not depend on client-provided score, capture or health values.

**Why separate services?**  
Faction balancing, objectives, match rules, player lifecycle and networking evolve independently on a real server.

**Why configuration-driven loadouts?**  
The target project can replace placeholder assets and tune balancing without rewriting core systems.

**Why not claim production-ready?**  
Professional delivery distinguishes static/API review from multiplayer runtime validation. This repository is a portfolio prototype until it completes the documented runtime test matrix.
