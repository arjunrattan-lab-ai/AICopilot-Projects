We worked on getting the details on eligible vehicles, vehicles that created events and volumes.
Config related analysis, I think @sachin.lomte is already overseeing.
Is there anything else needed apart from these?Achin Gupta  [12:14 AM]
Yes. I guess @sachin.lomte  should be able to do the rest. 
Sachin Lomte  [1:01 AM]
Hey @achin.gupta....Im on leave today 
I have explained everything to Aman ...some of these numbers we got last night itself...please sync with Aman to get these[1:05 AM]I can join the call as well if you want
[1:05 AM]Cc @aman.shekh
Achin Gupta  [1:06 AM]
Got it. Sure, thanks for the heads up Sachin. I can coordinate with Aman and pull you in if we get stuck somewhere. 

@aman.shekh  can you please go through the document and let me know if it's clear what to do here?
Sachin Lomte  [1:17 AM]
@achin.gupta it's not feasible to calculate volume at from 0.85 to 0.95 directly...we have seen volume getting dropped by 40% for 0.90 itself

We decided to calculate 0.85 0.86 0.88 0.90. 0.92 0.94 and so on
Achin Gupta  [1:19 AM]
Let's please calculate for 0.95, 0.96, 0.97 and 0.98. That's what the product team has aligned on. We're aware of the recall drop.
[1:20 AM]For reference, we can calculate for 0.90 as well
[1:20 AM]@sachin.lomte 
Sachin Lomte  [1:22 AM]
Yeah, that will be done anyways....it's just we are avoiding this big gap of 0.85 to 0.95
Aman Shekh  [4:05 AM]
@achin.gupta In your document, step 2 has activeVehicles count, currently we are facing an issue in hubble_config table where config values are null because of which extracting only activeVehicle is not possible. This issue has already been raised here.

you can see in this query as well, config values are null. (edited) 
DATA-3316 Unmark CONFIG Fields as PIIStatus: To DoType: TaskAssignee: UnassignedPriority: noneAdded by a botAchin Gupta  [4:57 AM]
Who's the owner for this ticket? I mean, do you know who can help us unblock on this? @sachin.lomte @aman.shekh 
Aman Shekh  [5:01 AM]
https://gomotive.slack.com/archives/C04LTHE91ST/p1774962482162309

@achin.gupta
Aman Shekh  [5:17 AM]
@achin.gupta alternative for now is, since we have pushed drv_eat_enable = 2 to GA. we will do following to count activeVehicles in step 2:

1: Count number of vehicles in SMB and MM segment
2: Count number of devices for SMB and MM companies opted out eating as mentioned in this Opt out list 


activeVehicle = Subtract 2 from 1

cc: @Shelender Kumar @Shoaib (edited) 
Achin Gupta  [5:20 AM]
Sounds good. Yes, let's move ahead with a suitable assumption for now to unblock ourselves.
Aman Shekh  [12:09 PM]
@achin.gupta updated the doc. If needed, let me know we can sync. Also, Please note all data is considering hubble devices and hubble events only and does not consider AIDC+, if needed we can include that as well.

Thanks @Shelender Kumar @Shoaib for the help and efforts (edited) 
Arjun Rattan  [3:18 PM]
Yes let's all AIDC+
Achin Gupta  [1:12 AM]
Thanks for sharing Aman. I'll look into it and get back to you shortly. 

@Arjun  out of ~25000 events generated during our GA, only 1000 were generated from AIDC+. The increase in volume doesn't seem to
be due to AIDC+ devices at the moment.Arjun Rattan  [1:48 AM]
perhaps include from a volume prediction/estimation perspective?
Achin Gupta  [2:01 AM]
Sure. Will get projections for AIDC+ in the analysis as well
Achin Gupta  [5:21 AM]
Thank you so much for the quick turnaround around this @aman.shekh. This is super helpful.
Achin Gupta  [5:29 AM]
The attached table shows projections at different confidence thresholds. Total volume is projection with all fleets enabled and "Core Volume" is projection with SMB disabled. We don't have segmentation saying "Commercial" in our db (@aman.shekh please correct me if I'm wrong).

My recommendation is we should move ahead with 0.95 as updated threshold. This will put us between smoking (>10k) and distraction (>25k) in terms of volume for whole fleet. We can always further increase threshold if the volume gets too high but there is a steep drop in recall as we move from 0.95 to 0.96.

@aman.shekh did we calculate numbers on threshold 0.90, 0.92 as well?

@nihar.gupta @Arjun @Devin Smith please let me know your thoughts.

cc: @sachin.lomte @Faisal @Wajahat Kazmi
image.png [5:30 AM]Detailed calculations available here.
Google DocsNihar Gupta  [6:34 AM]
This volume is wild even at 0.85 and 66% recall.  Are we creating repeat events for the same eating episode?  We should not be
Nihar Gupta  [6:47 AM]
Can we look at volume by segment.  Let’s consider excluding MM as well
[6:48 AM]And increasing recall to something closer to 40 or 50%
Achin Gupta  [7:03 AM]
25k events were created by 17k different vehicles. Out of this, 11k vehicles generated individual eating events. Rest generated at least 2 events.

If we increase AI Throttling to 20 minutes from 10 minutes, it can definitely reduce volume a little. Based on preliminary analysis, it can reduce volume by 20-30% and throttling of hot an hour probably upto 40-50%. We’ll do the analysis to get exact numbers as well.
[7:03 AM]Got it. Will do the analysis based on excluding MM as well.
Nihar Gupta  [7:45 AM]
Thanks.  Yeah just want to understand the range of options 
[7:47 AM]So does this imply that these folks are generally eating for 20 or 30 minutes?  Or are these repeat offenders, but entirely different eating scenarios?