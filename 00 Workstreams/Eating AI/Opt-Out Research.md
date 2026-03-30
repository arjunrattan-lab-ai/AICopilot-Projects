# Opt-Out Research — Why Customers Opt Out of AI Behavior Launches

## Source

Primary data: [Lane Swerving AI Opt-Out Form (2025) (Responses)](https://docs.google.com/spreadsheets/d/12HFKlBN8d_EqnCNH2Ptk3bzvxIxI2DtF4rHXHsBGIDU) — this is the most complete opt-out dataset available. It was created for the Lane Swerving launch (Oct 2025) and reused for subsequent launches. Additional context from the Eating AI launch Slack thread and Safety H1 2026 planning docs.

---

## Known Opt-Out Customers (from Lane Swerving Form)

| Customer | Industry | Reason | Still Disabled? |
|---|---|---|---|
| **State of Texas DOT** | Public Sector | Does not want any AI models. Cameras are for video recall only. | Yes |
| **Lumen** | Networking/Fiber Optics | "Don't ever want anything turned on automatically without knowing about it in advance." | Yes |
| **Rosendin Electric** | Construction | Account is cancelling, does not want any new features. | Yes |
| **Fusionsite Services** | Field Services | Prefer to control when it goes live to prep internal teams. | Yes |
| **Axis Energy** | Oil & Gas | Want to vet new features internally before deploying to fleet. | Yes |
| **CoolSys** | Field Services | Just starting to get managers to coach. Don't want to flood them with too many events. | Yes |
| **KONE** | Field Services | Just starting coaching. Need company-wide comms first before adding more event types. | Yes |
| **United Vision Logistics** | Trucking, Oil & Gas | No reason stated. | No — re-enabled |
| **Crystal Clean, LLC** | Field Services | No reason stated. | No — re-enabled |
| **New Line Transport** | Trucking, Construction | No reason stated. | Yes |
| **Articom Group LLC** | Field Services | No reason stated. | Yes |
| **Cintas** | Trucking, Field Services | "Matt Presendofer has requested that Cintas opt-out of all new AI Camera models until he can properly communicate the release to the field locations." | No — BETA testing |

---

## Opt-Out Reason Categories

Analyzing the stated reasons from the form, opt-outs cluster into **5 distinct categories**:

### 1. Zero AI appetite — cameras for video recall only
- **State of Texas DOT**: "This fleet does not want to use any of our AI models. They have cameras for solely video recall."
- These customers bought hardware for a different use case entirely. Auto-enabling AI features for them creates noise with zero value.
- **Implication:** Should be on a permanent exclusion list, not a per-launch opt-out form.

### 2. Change management control — "don't turn on without telling us"
- **Lumen**: "Don't ever want anything turned on automatically without knowing about it in advance."
- **Fusionsite Services**: "They prefer to control when it goes live so they can prep their internal teams."
- **Axis Energy**: "Want to vet new features internally before deploying to fleet."
- **Cintas**: "Opt-out of all new AI Camera models until [safety lead] can properly communicate the release to the field locations."
- These are large, process-driven organizations. They don't object to the feature — they object to the rollout method. An advance notice + opt-in window would satisfy them.
- **Implication:** Product should support a "notify and schedule" flow, not surprise enablement.

### 3. Coaching readiness — "we're not ready for more events"
- **CoolSys**: "Just starting to get managers to coach and don't want to flood them with too many events."
- **KONE**: "Just starting to get managers to coach, don't want to add additional events until they get the hang of what they want coaches to coach first. Need company-wide comms first."
- These customers are still building their coaching muscle. More event types dilutes their focus.
- **Implication:** Watch rate and coaching adoption should factor into rollout targeting. If a fleet has < X% watch rate on existing events, auto-enabling new event types adds volume with no coaching action.

### 4. Account health — cancelling or churning
- **Rosendin Electric**: "Account is cancelling and they do not want any new features turned on."
- Enabling new features on a churning account creates CS friction for zero retention value.
- **Implication:** Churn-flagged accounts should be excluded from auto-enablement.

### 5. No stated reason — passive compliance
- **United Vision Logistics**, **Crystal Clean**, **New Line Transport**, **Articom Group**
- Several of these were re-enabled within weeks, suggesting the CSM preemptively opted them out as a precaution.
- **Implication:** Some opt-outs are CSM-driven (defensive), not customer-driven. The form doesn't distinguish.

---

## Industry Patterns

| Industry | Count | Pattern |
|---|---|---|
| Field Services | 5 | Highest opt-out concentration. Coaching workflows are newer, change management is stricter. |
| Construction | 1 | Cancelling account. |
| Oil & Gas | 2 | Want internal vetting before deployment. |
| Public Sector | 1 | No AI appetite at all. |
| Trucking | 2 | Mixed — some re-enabled quickly. |
| Networking/Fiber | 1 | Strict "no auto-enable" policy. |

**Field Services fleets are the most opt-out-prone segment.** This tracks with Nihar's Slack comment: "The right answer is probably something in between — don't turn on for lower markets that have extremely low watch rates while defaulting on for MM+."

---

## Opt-Out Form Observations

1. **The form is reactive and manual.** CSMs/AMs submit a Google Form. There's no system-level opt-out setting. The H2 2025 planning doc has a line item: "Add Customer Setting to Opt-in, Opt-Out of new AI Behavior Launches" — this hasn't shipped.

2. **Compliance drift.** The form tracks "Still Disabled?" at multiple checkpoints (10/16, 11/3, 2/6). Two customers (United Vision Logistics, Crystal Clean) were re-enabled despite opting out. It's unclear if this was intentional or a config error.

3. **The list carries forward.** Devin: "The opt out list already includes the same company — this is just to increase it." The same customers opting out of Smoking also opted out of Lane Swerving. The list is cumulative, not per-launch.

4. **No opt-out volume data.** The form doesn't capture how many total customers were on the opt-out list vs. total customer base. We don't know if 13 responses represents 0.1% or 5% of eligible fleets.

---

## Recommendations

1. **Build a system-level opt-out setting.** Replace the Google Form with a Safety Admin → "New Feature Rollout Preferences" toggle. Options: Auto-enable, Notify first (default for ENT), Never auto-enable. This was already identified in H2 2025 planning but deprioritized.

2. **Create a permanent exclusion tier.** Customers like State of Texas DOT who don't want any AI features should be tagged once, not re-surveyed every launch.

3. **Factor coaching maturity into rollout targeting.** If a fleet's watch rate on existing events is below a threshold (e.g., < 20%), auto-enabling new event types adds volume without coaching adoption. Consider: default ON only for fleets with demonstrated coaching activity.

4. **Separate CSM opt-outs from customer opt-outs.** The form should capture whether the request came from the customer or was a CSM preventive action. This affects how aggressively to re-enable post-launch.

5. **Pre-launch notification window.** For ENT/strategic accounts: send a "coming in 2 weeks" notification with a 1-click opt-out link. This satisfies the "change management" cluster without requiring manual form submissions.
