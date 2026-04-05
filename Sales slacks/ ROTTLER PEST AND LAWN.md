Michael Delaney  [2:10 PM]
@here Apologize for making noise but we are NOT off to a good start here.
Right now out of 26 safety events that have reached the dashboard, I would say 4 of them are valid.  We have 16 Harsh Events. All of them are beneath the Light duty event thresholds.  This is a known AIDC+ bug and has a scheduled fix for April 9.  5 out of the 6 stop sign events appear to be false positives.36 repliesBen Stevens  [2:15 PM]
This is a known bug?
[2:15 PM]@nihar.gupta what's the deal here?
[2:15 PM]Shouldn't the annotations team still filter? (edited) 
Michael Delaney  [2:42 PM]
@Ben Stevens every trial I have with AIDC+ is justifying the harsh events thresholds to Heavy Duty. I have 3 support cases open for this and there are more with other trials.  I have been told we have a permanent fix scheduled for April 9 and engineering is supposed to apply back end configs as a stop gap.         Currently these non-qualifying events are hitting the dash in all 3 of my trials.
Nihar Gupta  [3:01 PM]
+ @anandh.chellamuthu @nishant.swaroop for viz.  Did you all (account team) confirm trial settings? (edited) 
[3:01 PM]+ @avinash.devulapalli what is the issue with LD vs HD settings, this is a known thing?
[3:05 PM]What’s your basis for saying 5 out of 6 Stop sign events are FPs?  Did you look at the min speed?
[3:05 PM]And compare to their setting?
Michael Sclar  [3:13 PM]
Here is TSSD @nihar.gupta cc @Ben Stevens

A,B,C’s discrepancy between frontend and backend I noticed some issues with harsh events on VG5/AIDC+  I am seeing harsh events that should not be reaching the dashboard based on the "duty" classification of the vehicles.  The vehicles in question are all light duty yet seem to be following the harsh event thresholds for heavy duty.
TSSD-29257 10382214 | Invalid Hard Braking Events  | NEIGHBORHOOD HEALTHCAREStatus: Pending FixType: BugAssignee: Umair JavedPriority: MajorAdded by a bot[3:17 PM]regarding stop sign @nihar.gupta - we are seeing Speed Fusion issues at Brightview, Berrett Home Services, and a few others. The vehicle visually comes to a stop but the speed takes time to catch up therefore creating the false positive
some really good events coming through. see a falst positive stop sign violation here. vehicle clearly stops but speed shows 5mph. we need to figure out whats happening here. we need to be sampling vehicle speed at higher rate or we are getting bad speed data. @Sumit @nihar.gupta @john.c @michael.benisch https://app.gomotive.com/en-US/#/safety/events/1501919430;start_time=2026-03-28T18:02:56Z
From a private conversation | Mar 29thHi @Farah Sultan I'm seeing a few Stop Sign Violations that should not have made it to the Dashboard. Can you create a case to ask Support to have these removed from the Dashboard? Thank you!

Stop Sign Violation - Mar 28, 12:12 PM CDT - comes to complete stop
Stop Sign Violation - Mar 27, 4:58 AM CDT - comes to complete stop
Stop Sign Violation - Mar 25, 3:54 PM CDT - comes to complete stop
Stop Sign Violation - Mar 25, 3:53 PM CDT - comes to complete stop
Stop Sign Violation - Mar 25, 3:51 PM CDT - comes to complete stop
Stop Sign Violation - Mar 26, 11:44 AM CDT - comes to complete stop
Stop Sign Violation - Mar 25, 6:16 PM CDT - comes to complete stop
Stop Sign Violation - Mar 25, 4:44 PM… 
From a private conversation | Mar 30thNihar Gupta  [3:57 PM]
is there a TSSD on this SSV speed issue you are seeing @Michael Sclar?  Can you share with me?
Michael Sclar  [4:30 PM]
Here is one TSSD - I have asked the team for others TSSDs and will share them as they come in.
TSSD-29149 TRIAL - False Positive – Stop Sign Violation Event - ContinentalStatus: ResolvedType: ConsultationAssignee: Andrew QuinnPriority: noneAdded by a botMichael Sclar  [5:12 PM]
Here is another, Nihar. TSSD - Urbanex
TSSD-28003 10264246 | VG5 | Stop Sign Violation - Event GPS vs Vehicle Speed…Status: ResolvedType: ConsultationAssignee: Sophia BowmenPriority: CriticalAdded by a botNihar Gupta  [7:26 PM]
+ @michael.benisch @Gautam Kunapuli on stop sign violation speed issue
[7:27 PM]and @Arjun
Daniel Del Valle  [6:18 AM]
I believe SSV for light duty vehicles has been a know issue on LD. Was that fixed on the DC 53/54?

@Gautam Kunapuli any way we can have a fix on the ABC settings discrepancy before April 9th?

@nihar.gupta back to Ben's comment, who is the correct person to have annotations screen these?
CaseAvinash Devulapalli  [6:21 AM]
+ @avinash.devulapalli what is the issue with LD vs HD settings, this is a known thing?@nihar.gupta - I learnt about this Harsh ABC issue TSSD in collision standup and that Engg is actively working to address it.

RCA - Tldr (as per engg): As the system is not seeing any harsh abc configs for these vg5/aidc+ devices, it is falling back to use default thresholds (which is similar to Heavy duty thresholds) for these vehicles. Hence the Harsh ABCs events are seemingly being generated based on heavy duty thresholds while they should have been generated based on Light duty/Med duty thresholds as per vehicle's duty class settings.

Impact surface area: This issue is happening only for Harsh ABCs on VG5/AIDC+. Other safety events are not impacted. VG3/AIDC configs are also not impacted.

Immediate fix: To resolve this issue immediately for trials that reported this issue (mentioned in tssd), Engg is working on a one time script that updates these configs to user set thresholds.

Actual fix: While Engg has committed for a 09-Apr fix on TSSD, they're trying to see if we can push a hot fix by tomorrow so this issue does not bother more trials. Will keep this thread posted if we can fix the Harsh ABC issue by 02-Apr or 09-Apr. (edited) 
Daniel Del Valle  [6:23 AM]
Amazing, thanks @avinash.devulapalli
Avinash Devulapalli  [6:24 AM]
For Stop sign violation speed issue - Pls stand by for Gautam/Michael to comment. (edited) 
Daniel Del Valle  [6:30 AM]
@nihar.gupta is it possible to get rid of the false positives from the dashboard?
Avinash Devulapalli  [6:37 AM]
@Dan Del Valle was this issue raised by the customer or our teams?

If the customer has seen them, then removing the fps now might be too late. So lmk your take. 

I can ask engg to remove the fp harsh abcs if you think removing them from dashboard should not be a problem with this customer. 

Cc @Talha 
Daniel Del Valle  [6:40 AM]
@Mic Delaney caught them. There's been no user engagement so I can't imagine they've seen them.

@Mic Delaney what do you think, second opinion?
Michael Delaney  [6:43 AM]
@avinash.devulapalli we are ok to remove them at this point as @Dan Del Valle suggested.  Even if the POC had seen them I think we could explain our way out of it as we are just getting started with setting things up.
Avinash Devulapalli  [6:57 AM]
@Mic Delaney - Can you please share the latest list of the Harsh event URLs that are FPs so we can invalidate them from backend?
Michael Delaney  [7:14 AM]
@avinash.devulapalli yes give me just a bit.  Also I would like to point something out.  I am seeing VG3's impacted by this issue in my mixed fleet trial for Cook's Pest Control.  Sunday night I dismissed 22 Harsh events over a 4 week period to preserve the integrity of the safety score. 3 of those events were VG3 equipped vehicles.  So I believe where VG3 and VG5 are present it appears to be having an impact at the company threshold level and not just the device level.  Just wanted to make sure I pointed that out.

96 total harsh events
22 dismissed due to HD thresholds
3 of these were VG3
(edited)
Avinash Devulapalli  [7:20 AM]
Hey @Mic Delaney - Can you gimme 1-2 FP event URLs of the VG3 devices? So Engg can root cause.
Michael Delaney  [7:32 AM]
@avinash.devulapalli I was mistaken with this.  My list included events dismissed by client side users.  The 3 with VG3 all look to be in line with Light Duty thresholds but were dismissed by POC. So we can just forget I said that:wink:
Avinash Devulapalli  [7:32 AM]
Noted, thanks for clarifying.
Michael Delaney  [7:44 AM]
@avinash.devulapalli just shared Rottler list
Daniel Del Valle  [3:20 AM]
@michael.benisch @Gautam Kunapuli can you please provide some info on stop sign violation speed issue?
Michael Delaney  [6:18 AM]
@Dan Del Valle Support/annotations did provide an explanation on each SSV event in the case thread.  However, I do not believe these were analyzed properly and have asked them to re-evaluate.  I have not received an update yet on that request. With regards to speed calculation/accuracy we have not received an update on that.
image.png Gautam Kunapuli  [7:33 AM]
We've just completed an analysis. I'll share an update shortly. (edited) 
Michael Delaney  [9:22 AM]
Team,  Update on the harsh events issue:  We are continuing to see these invalid harsh events come in that are justifying to Heavy duty thresholds.  I have pinged support in the case thread to check in on the invalid event removal. As a hot fix we have changed the heavy and med duty thresholds in the dashboard UI to all reflect light duty thresholds.
[9:23 AM]I am updating the list of events to be removed now since we have more
Gautam Kunapuli  [10:09 AM]
After reviewing the speed graphs:

The vehicle speed signal on these trucks has a 1-2sec delay vs GPS speed, and in some cases never cleanly drops below the SSV threshold even when the driver actually does. 
The lower trial thresholds compared to GA (6mph vs. 3mph) means that a small delay or error in vehicle speed can amplify the issue and cause a valid stop to be classified as a rolling stop.


Root cause: This seems to be localized to certain light-duty vehicles with poor/delayed vehicle speed plus aggressive trial thresholds, and does not appear to be not a general issue. We are still investigating why this happens for these vehicles, and a more permanent workaround.

Recommendation / Short Term Fixes: We can consider the following options that can enhance the customer experience, though there are some caveats that we may need to tradeoff.

For the affected devices, switch Road Facing features to speed mode 2, which will use GPS speed instead of vehicle speed. The default speed mode for AI events (mode 4) prioritizes vehicle speed, but since this is unstable, switching to a different speed source will likely help a fair bit. However, please note that GPS speed itself can sometimes have accuracy issues at low speeds. 
SSV thresholds can be moved closer to GA thresholds (say, 5mph). However, please note that this may reduce the number of SSV events generated.
cc: @nihar.gupta @michael.benisch @Moudood @Michael Sclar (edited) 
[10:11 AM]Is this a side-by-side trial? As in, are multiple cameras plugged into one OBD port?