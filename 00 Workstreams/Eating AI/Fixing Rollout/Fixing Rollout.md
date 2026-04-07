AI Eating Detection GA — Event Volume Spike: Root Cause & Resolution Plan

Executive Summary
The GA rollout (April 1st, 2026) for AI Eating generated a significantly higher-than-expected volume of events—28,000 daily events compared to the projected 3,000. This spike critically impacted our Annotation pipeline and we rolled back the feature to prevent customer experience issues. In the interim, we have implemented several customer impact mitigation measures, including hiding the feature from the Fleet Manager dashboard and suppressing the events on the main dashboard. Our key hypothesis is that the number of events per vehicle per day exceeded projections due to different driver behavior at a larger scale compared to drivers involved in Beta testing.

The team is currently performing a root cause analysis to determine the precise path forward. Our likely solution will involve using the confidence threshold to manage the event volume, which will require a trade-off with recall. We plan to relaunch the feature next week (April 8th to SMB, April 13th to MM, and April 15th to ENT/All) after establishing the final confidence threshold values, while closely monitoring system stability and event volume. Link to Rollout and monitoring plan.

Additionally, a retrospective meeting will be held next week to deeply analyze the issue and improve preparedness for future launches, ensuring better prevention of such volume spikes.
What Happened
During the GA (April 1st, 2026) rollout of AI Eating Detection, we observed significantly higher event volumes than projected:

Metric
Projected
Actual (GA)
Events per day
~3,000
~28,000 (for SMB + MM)
Events per vehicle per trip
0.016
0.265
Volume multiplier 
(for Events per vehicle per trip)
1x
~16x


Why does it matter?
Even with activation limited to SMB + MM only, we saw ~28,000 events/day — nearly 9x the full-fleet projection.  This unexpected spike can cause the following challenges:

SLA risk across all safety events — The annotation pipeline is shared across event types. A sudden spike in eating events can crowd out other critical safety events (e.g., seatbelt violations, distracted driving), putting SLAs at risk platform-wide — not just for eating.
Derails annotation team efficiency goals — We are actively working toward making the annotation team leaner by reducing reliance on manual annotation. An unexpected volume surge forces reactive scaling, pulling the team in the opposite direction and setting back automation efforts.
Unexpected cost overrun — Annotation at this scale significantly increases operational costs, both in human annotator bandwidth and compute, which was not budgeted for in the GA plan.




Why Did it Happen / Root Causes
Hypothesis 1: Number of events per vehicle per day exceeded projections due to different driver behavior at larger scale compared to drivers involved in Beta testing
We suspect the number of events generated per vehicle is much higher than expected based on Beta projections (0.265 vs. 0.016 events per vehicle per trip — a ~16x increase). Our hypothesis is that drivers involved in beta testing got directions from their Fleet Managers that Eating behavior was being tracked and therefore the number of events they generated were much lower than what we’re seeing in GA.
Hypothesis 2: Number of vehicles in GA is significantly higher than what we factored in during Beta projections
We suspect that the number of vehicles we considered during GA projections (~200,000) is lower than the current number of vehicles enrolled. However, it is unlikely that the number of vehicles alone would have impacted the volume by a factor of 15x. As per our initial estimates, the impact due to vehicle increase is by a factor of 2 - 4x. 
Hypothesis 3: Edge backoff was reduced to 0 leading to creation of higher number of multiple events from the same vehicle
The team knowingly set the backoff at the edge to 0 minutes. We removed this backoff as we already have AI throttling in place to prevent multiple events. However, removing back off from the edge relinquishes control to a certain extent, increasing the volume by 10-30%.
Hypothesis 4: The volume of events generated could be high because of AIDC+ as the confidence threshold set for AIDC+ is 0.3
We have checked the number of events generated from AIDC+ on April 1st (the date of our GA rollout to MM). It generated only ~1000 events out of ~25000 events generated. So the volume increase was not because of AIDC+ confidence threshold.

Customer Impact Mitigation
Eating events rolled back — Annotation pipeline unblocked; customer SLA protected.
No new eating events will be delivered to GA customers;
Eating-related UI surfaces hidden — Filter for Eating behavior on Event List page and Eating in Safety Settings will not be visible (experience mirrors pre-launch state).
Eating events hidden from dashboards in the meanwhile while we figure out next steps. This is to ensure a consistent customer experience while eating is off as Eating-related UI surfaces are already hidden. Jira Ticket.
Pending events in Annotation pipeline abandoned — About 8k events that were pending in the Annotation pipeline were abandoned to create space for events of other behaviors and protect our SLAs
Beta customers unaffected — Feature continues as-is for all Beta customers (active for 4+ months); no experience change.
GTM/Sales Actions (ETC) – The Production Operations team has taken down public access to support articles and release notes until the re-launch. The blog published by the product marketing team and the support enablement content will remain publicly available. This decision was made because the re-launch is scheduled for next week, and the relevant teams consider it acceptable to keep this content public for that duration.


Fix Plan
Immediate steps (To be completed by April 6th)
Running analysis across the following configuration combinations to bring volume in line with Beta projections:

Table 1: 
Parameter
Values Being Tested
Confidence Threshold
0.85 → 0.95, 0.96, 0.97, 0.98
Edge Backoff
0 min → 10, 15, 20, 25 min


The right configuration will be selected based on the combination that best matches the projected Beta volume envelope.

Analysis for confidence thresholds: Config + Roll out plan analysis

Table 2: 

Proposed Changes
Impact on Event Count
Precision 
Recall 
Customer impact / Notes
Change 1
Reduce by X%






Change 2
Reduce by Y%



















Next Steps
Complete volume analysis across confidence threshold and backoff configurations → identify optimal settings.
Implement config changes in coordination with the IoT team.
Re-initiate rollout next week with a more staggered approach — increased time gaps between SMB, MM, and ENT launches to allow adequate volume observation at each stage.
Daily updates to be shared in #ai-eating-detection channel until rollout complete, and until a few days after for post launch monitoring/stability.
[Placeholder] [ETC: April 6th, 2026]



Rollout & Monitoring
Segment
Rollout Date
Total Volume (Events/Day)
Events per Vehicle per Day
Status
SMB
TBD
—
—
—
MM
TBD
—
—
—
ENT
TBD
—
—
—

This table will be updated as each segment is activated. Key metrics to watch: total daily event volume and events per vehicle per day.
Roll-back plan
1. Defined Rollback Triggers
Initiate the rollback if any of the following occur during the staggered rollout (SMB, MM, or ENT stages):
Volume Thresholds: Event volume exceeds the new projected volume by more than 20% within a 24-hour window.
SLA Impact: Annotation pipeline backlog increases, causing the SLA for critical safety events (e.g., seatbelt, distracted driving) to drop below 95%.
2. Immediate Operational Actions 
Disable Event Generation
Purge Pending Annotation Pipeline
UI Reversion of Eating from FM dashboard
Eating event suppression on events dashboard
3. Technical Remediation & Refinement
Root Cause Re-Analysis: If the volume spike persists despite the new configurations, investigate other hypotheses.
Config Reset: Change confidence thresholds as per the new found information and new agreed configurations
4. Communication & Support Plan
Internal Notification: Post an immediate alert in the #ai-eating-detection Slack channel detailing the segment affected and the reason for the rollback.
Marketing Alignment: Notify the Production Operations team to ensure support articles and release notes remain hidden. We can keep the marketing blogs public if the relaunch is still within a week.
Support team update: Ensure support enablement teams have updated talking points for customers in the affected segment.


Long term plan 

To prevent similar spikes in event volume for future behavior releases, the team will:
Determine how to improve beta phase estimations. This assessment will include identifying the specific metric that was inaccurate and the contributing factors, allowing the team to pinpoint appropriate resolutions.  Doc for reference: Eating volume projections

Meeting Date
Attendees
Notes
April 6th, 2026
 Archit Dubey Sachin Lomte Aman Shekh Muhammad Faisal Achin Gupta





Develop better projection models based on changes in configurations
We will modify the rollout strategy to proactively manage event volume and avoid being overwhelmed by high volumes from large fleets (MM or ENT customers). The new plan includes a more staggered approach with a two-day gap between the rollout for SMB and the rollouts for MM and ENT segments. This allows for closer observation of volume increases.



