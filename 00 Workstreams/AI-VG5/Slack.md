We conducted offline annotation of cellphone and distraction invalid_event_1 cases from March 9 to 15.


For cellphone events, most were marked as IE1 due to passengers using cellphones. Upon reviewing the driver_monitor_ai_mirror config for the affected vehicles, we found that it was disabled for most of the vehicles, meaning the videos were not being flipped before the model was run.



For distraction IE1 events, there were two main categories of false positives:
Cases with no actual distraction (model failure)
Cases where the annotator marked IE1 due to confusion caused by the blur box

Most IE1 distraction events were attributed to the blur box issue. The actual precision was 87%, but if the blur box issue were resolved, precision would increase to 94%, representing an improvement of about 8%.

CC:@Shafiqa
Screenshot 2026-03-16 at 10.10.30 PM.png Wajeeha Zulfiqar  [11:19 AM]
CC: @sultan @Wajahat Kazmi
Sultan Mehmood  [12:12 PM]
+ @Gautam Kunapuli
Wajahat Kazmi  [12:15 PM]
But for Distraction and CP FPs, passenger was the focus of the model and not the driver, right?
Sultan Mehmood  [1:55 PM]
imo, the priority is always the driver. We would validate events against driver involved in any risk. since it impacts their drive scores. Im not very sure on conversation related to passenger
Wajeeha Zulfiqar  [3:47 AM]
After analysis, we found that most of the vehicles generating these false positives have the driver_monitor_ai_mirror config set to 0. This means the video is not being flipped before running the model, resulting in the passenger being detected instead of the driver. We should enable this configuration for UK GA to prevent these false positives.
Looping in product for this @Devin Smith
CC: @anandh.chellamuthu
Muhammad Ayaz Munir  [6:33 AM]
After conducting the company-wise analysis, we found that companies with driver_monitor_ai_mirror set to 0 are contributing more to false positives compared to those with it set to 1. Therefore, we recommend setting driver_monitor_ai_mirror to 1 (which is likely the default) to address this issue.
The detailed sheet is attached for reference.
CC: @Gautam Kunapuli @Wajeeha Zulfiqar
Google SheetsShafiqa Fiaz  [6:44 AM]
So, @Ayaz from our analysis we didn’t find any fleet with driver_monitor_ai_mirror set to 0 that was performing well. This indicates that majorly the vehicles in the UK are with right-hand drive, right?
Muhammad Ayaz Munir  [7:02 AM]
yes, that aligns with the assumption that most UK vehicles are right-hand drive. Since none of the fleets with driver_monitor_ai_mirror = 0 performed well
Gautam Kunapuli  [7:29 AM]
:exploding_head:
Muhammad Ayaz Munir  [8:34 AM]
CC: @sultan @Wajahat Kazmi
Muhammad Ayaz Munir  [12:21 AM]
Out of 590 total identifiers for DC64 from the UK, we were able to get media for 555 identifiers. Of these, 14 were left-handed, including 12 from ABM Industries, Inc. UK, 1 from Motivation, and 1 from Product Test Company & Sales Engineer.
The remaining identifiers are all right-hand side (RHS) driving. This group includes JHS Golden Group UK Ltd and Delta Solution, whose driver_monitor_ai_mirror configuration is set to zero, which is contributing to a higher number of FPS.
CC: @sultan @Gautam Kunapuli (edited) 
Wajeeha Zulfiqar  [3:00 AM]
@Ayaz, for the 14 left-handed identifiers, is the config set to 0? If so, are the models performing well on these devices?
Muhammad Ayaz Munir  [4:08 AM]
@Wajeeha Zulfiqar Out of the 14, 5 were single-seater (yellow iron, I believe) vehicles. The configuration is set to 1 for 10 of them, while the remaining are set to 0. Also, the only events generated from these 14 are SBV, which were TP mostly.
Wajeeha Zulfiqar  [6:48 AM]
We have identified ~550 UK vehicles.
Out of these, only 14 are left-hand drive (LHD); the rest are right-hand drive (RHD).


For RHD vehicles, when the driver_monitor_ai_mirror config is set to 0 (disabled), performance is poor. When set to 1, performance is good.
Recommendation: Set the config to 1 for all RHD vehicles.




For the 14 LHD vehicles:
8 are one-seater vehicles.
For the LHD two-seater vehicle(s) with mirror config 1, false positives are high.
Recommendation: Set the config to 0 for all LHD vehicles.




This impacts cellphone and distraction precision metrics in the UK, due to which we are getting events re-annotated and this is increasing workload for the annotation team.


Please advise whom I should contact to get these configs updated.
CC: @Shafiqa @sultan @anandh.chellamuthu
Wajeeha Zulfiqar  [6:12 AM]
@Gautam Kunapuli and @sultan,
The annotation team has been working weekly on annotating UK cellphone and distraction events for the past four weeks. Based on the data collected and our investigation so far, here’s what we've observed:


Low precision is mainly due to the driver_monitor_ai_mirror config being set incorrectly.
In distraction cases, the blur box is also causing confusion for annotators, resulting in more events being marked as IE1.


Could you please recommend the next steps to address these issues?
CC: @Summy
Sultan Mehmood  [10:25 AM]
@Wajeeha Zulfiqar we should ideally categorize invalid due to blur box towards invalid 2 and not AI failures. I hope we are doing this already? @Summy cc
Muhammad Summy Shah  [11:25 AM]
Invalid Event 2 is not available for all DPE types. Where it is available, it is used when the behavior is unclear when blur box is present. For events like smoking or cell phone usage, annotators select Invalid Event 1 instead.
Sultan Mehmood  [11:32 AM]
We may remove blur box, in the interim , we can have some offline annotations and manually define invalid and invalid 2 ? that was aligned with Arsh as well @Summy
Gautam Kunapuli  [11:43 AM]
Thanks for flagging this @Wajeeha Zulfiqar.

Low precision is mainly due to the driver_monitor_ai_mirror config being set incorrectly.@anandh.chellamuthu, it appears that our current process to flip the driver-facing video stream for UK customers on the AIDC+ is being applied incorrectly. We need address this with trials/GTM/account teams. What are our next steps here? (edited) 
Gautam Kunapuli  [11:53 AM]
@sultan @Arsh Can you please clarify

What the legal guidance on this is? In particular, I believe Annotators will be allowed to view unblurred driving video, yes?
If so, then when do expect this change to be applied?


Invalid Event 2 is not available for all DPE types. Where it is available, it is used when the behavior is unclear when blur box is present. For events like smoking or cell phone usage, annotators select Invalid Event 1 instead. we can have some offline annotations and manually define invalid and invalid 2 ?I disagree with this definition that when an event that cannot be validated due to blurring , it is marked invalid. This is completely backwards, IMO.

The edge views unblurred footage and has all the information to make a decision
The human views blurred footage and has incomplete information, and especially, missing crucial information that the edge had.
This means that a human CANNOT OVERRIDE THE EDGE based on... something that is totally unclear to me.


We should not be marking these invalid. We should:

Mark all blurred videos that we cannot validate as valid by trusting the edge information and our AI models.
Perform an offline analysis on the blurred videos to see what the gap is.
cc: @Arjun @Devin Smith @Wajahat Kazmi @achin.gupta (edited) 
[11:56 AM]@Arjun @Arsh can you please weigh in?