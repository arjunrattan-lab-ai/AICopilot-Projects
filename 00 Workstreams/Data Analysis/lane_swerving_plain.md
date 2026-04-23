# Understanding Car Lane Movements

## What Is the Position Signal?

The car's software tracks one simple number that shows where the vehicle is sitting in its lane. The number goes from 0 to 1:
- 0 means the car is touching the right lane line
- 0.5 means the car is perfectly centered
- 1 means the car is touching the left lane line

Everything else the software does is just watching how this number changes over time.

## Swerve: A Quick Move Left and Right

A swerve happens when the driver quickly moves the steering wheel one direction, then immediately corrects back. On the position signal, you see a spike — the number shoots toward one edge and comes right back. The software looks for three key moments: when the car starts moving, when it reaches the farthest point, and when it returns. If the movement is big enough and happens fast enough, the software flags it as a swerve.

## Drift: A Slow Slide to One Side

A drift is different. The car gradually slides toward one edge of the lane without coming back. On the signal, it looks like a slow climb in one direction — no spike, just steady motion. Once the car reaches the edge, it stays there.

## Lane Change: Jumping to a New Lane

A lane change looks nothing like a swerve. Instead of moving smoothly within the lane, the position signal suddenly jumps — like jumping from 0.3 straight to 0.7. This happens because the software switches from tracking the old lane's lines to the new lane's lines. The jump is roughly the full width of one lane.

## How the Software Detects a Swerve

The software uses a state machine — it's like a referee watching for specific patterns. It waits for three moments when the car's sideways motion stops and reverses direction. Once it finds all three, it checks: Is the movement big enough? Is it fast enough? If yes, it's a swerve.

## The V1 Bug

V1 was the original version. It looked for three moments where motion stopped, but it didn't check if those moments actually formed a real spike. It could be fooled by a gradual, one-way slide. If the car was drifting slowly and the direction changed slightly, V1 might mistakenly call it a swerve. It also tried to ignore lane changes, but this didn't always work.

## The V2 Fix

V2 fixed the problem by being much stricter about what counts as a real swerve. It now requires:
- A true peak — the middle moment must actually be the farthest point, not just any direction change
- The start and end points must be significantly lower than the peak
- A minimum distance required before and after the peak

For lane changes, V2 now automatically adjusts the position signal to stay smooth even when the vehicle switches lanes, and it has a hard rule: any position above 0.65 is marked as a lane change, not a swerve. This completely blocks false swerve detections from drifts, because a real swerve always forms a hill or valley, while a drift is just a slow slope.

## The Fix for VG5

VG5 needs the same strict peak-checking rule that V2 uses, so it stops accepting one-way slopes as swerves.
