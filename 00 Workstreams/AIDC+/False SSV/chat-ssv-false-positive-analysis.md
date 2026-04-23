# AIDC+ SSV False Positive Analysis

*Saved from chat — 2026-04-12*

## Context

High-priority escalation from Gautam Kunapuli in #eng-vg5-ai (2026-03-31) about a spike in AIDC+ Stop Sign Violation (SSV) false positives, particularly impacting trial customers. Drivers are getting flagged for SSV even when they actually came to a complete stop.

**Escalated customers:** BrightView, Continental, Urbanex, Rottler (4 separate events in one day).

## Root Cause

The issue traces to **Speed Mode 4** — a weighted average of OBDII vehicle speed with GPS fallback. Some OBDII vehicles report speed with a **multi-second lag**, so the system still "sees" the vehicle moving when it has already stopped. The smoothing filter on top amplifies the lag.

**Vikrant Sidagam confirmed:** This is a known issue with certain OBDII vehicles reporting speed slowly. The only workaround identified so far is switching affected vehicles to Speed Mode 2 (pure GPS).

## Speed Comparison Chart Breakdown

Four speed signals plotted over time as a vehicle approaches and stops at a stop sign:

| Signal | Behavior at the stop |
|---|---|
| **GPS Speed** (green dashed) | Drops sharply, clearly goes below the 8 kph stop threshold — vehicle actually stopped |
| **Vehicle Raw Speed** (blue dashed) | Drops, but lags behind GPS by several seconds — OBDII reporting delay |
| **Vehicle Smoothed Speed** (blue solid) | Even more lag — barely dips into the threshold zone. Smoothing amplifies the delay |
| **Orange line** (likely another raw/device speed) | Tracks close to GPS — confirms GPS is telling the truth |

During the **Rolling Stop Event Period** (yellow zone), GPS shows the vehicle stopped but OBDII vehicle speed still reads ~15-20 kph. Speed Mode 4 trusts OBDII, so it concludes the driver rolled through the stop sign. **False positive.**

## Open Questions from Thread

- **Gautam:** Are all the escalated examples vehicle-side issues, or could this be a telematics module bug? (Pinged Joe Pulver.)
- **Kamil Mahmood:** Is OBDII speed queried async or blocking? Does the speed data carry its own timestamp (which could allow the system to compensate for lag)?

## Key Question for Prevalence

Of the SSV events flagged as violations in the last 30 days, how many had OBDII speed significantly above GPS speed at the time of the event?

That gives the false positive exposure directly — not "how many vehicles are laggy" but "how many SSV alerts are likely wrong because of lag." If the number is small, targeted fixes. If it's a big chunk of all SSV events, switch the speed source for SSV globally.

## Two Action Items for Eng Thread

**1. Annotation gap (fix now):** These events hit AT but annotators aren't trained to recognize OBDII speed lag as a false positive. Need an updated rubric so the AT team invalidates these instead of pushing them through. Fastest way to stop bad alerts from reaching customers.

**2. Edge detection (fix later):** Of the SSV events pushed to customers in the last 30 days, how many had OBDII speed significantly above GPS speed at the time of the stop? That tells us whether the edge-side speed source needs to change for SSV.
