# Org Design Lenses

*Saved from chat — 2026-04-05*

Three lenses on org design, each answers a different question. **User selected Lens 1 (customer problem).**

## Lens 1: Organize around the customer problem ← SELECTED

**Question:** What does the customer experience?

| Team | Customer promise | Success metric |
|------|-----------------|---------------|
| **Detect More** | "You can detect things you couldn't before" | New event types shipped to GA |
| **Detect Right** | "When we say it happened, it did" | Precision at scale, false positive rate |
| **Detect Everywhere** | "It works on your hardware, in your market, every time" | Parity %, uptime, markets live |

Pros: Simple to explain to anyone. Aligns with how Sales and CS talk.
Cons: "Detect Right" is overloaded — combines model tuning and event validation.

## Lens 2: Organize around the skill set

**Question:** What kind of person succeeds in this role?

| Team | Skill profile | What's in it |
|------|-------------|-------------|
| **Product + ML** | Discovery, customer research, model spec, launch | Feature Dev |
| **Precision Engineering** | Data analysis, threshold tuning, A/B testing, annotation | Model Quality + Event Integrity |
| **Systems + Platform** | Infra, pipeline, reliability, cross-platform | Platform & Reach |

Pros: You hire one type of person per team. Career paths are clear.
Cons: 3 teams is thin for 5 PMs.

## Lens 3: Organize around the dependency chain

**Question:** Who blocks whom?

```
Feature Dev → ships a model → Model Quality tunes it → Event Integrity validates it → Platform delivers it
```

| Team | Input | Output | Owns |
|------|-------|--------|------|
| **Build** | Customer problem | Trained model in production | Feature Dev |
| **Tune** | Production model | Model at target P/R | Model Quality |
| **Validate** | Tuned model output | Customer-ready events | Event Integrity |
| **Deliver** | Validated events | Events on all hardware, all markets, reliably | Platform & Reach |

Pros: Clean handoffs. Each team has one upstream dependency and one downstream customer.
Cons: Creates bottlenecks at handoffs. Requires strong cross-team coordination.

## Which lens to use when

| If your problem is... | Use this lens |
|----------------------|--------------|
| **"Customers don't understand our value"** | Lens 1 (customer problem) — force outward-facing alignment |
| **"I can't hire the right people / PMs are mismatched to work"** | Lens 2 (skill set) — match people to roles they can grow in |
| **"Things fall through cracks between teams"** | Lens 3 (dependency chain) — make handoffs explicit |
