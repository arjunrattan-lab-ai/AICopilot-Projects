Nihar Gupta  [6:36 AM]
Hey good morning - can we quickly align on what it would take to support full human review bypass, per Shoaib’s ask?  @avinash.devulapalli can you re-share the v0 design here?
[6:39 AM]we would sacrifice a few things which we will make clear in copy - eg life-threatening collision identification and positive driving.  Are there other blockers to doing this?
[6:41 AM]Dont we have an “annotations not required” field or something that bypasses annotators for AI events?
Slackbot  [6:42 AM]
@Chandra Rathina and @Devin Smith have been added to the conversation by . Nihar Gupta  [6:43 AM]
Also Avinash, I think you had this in the collisions section in settings, this needs to be apply globally across everything including AI events
Avinash Devulapalli  [7:43 AM]
hey @nihar.gupta - Check out version 5 in this v0 prototype with last night's feedback incorporated: https://v0.app/chat/motive-safety-prototype-lJ4k5TqWjs7?ref=GU4RGW (edited) 
[7:47 AM]Also Avinash, I think you had this in the collisions section in settings, this needs to be apply globally across everything including AI eventsThere is a UX conflict here that is why I was proposing 2 places instead of a single global setting:

In version 5 - What I am proposing rn in the v0 above is:

Safety Settings > Collisions card - First responder Enable/Disable lives here. Hence for collisions, the EVE settings resides here to ensure when users select 'AI only', we ensure to show them that First responder is disabled in this card itself.
Safety settings > Unsafe behavior and Event intelligence > Event intelligence - This is where all other events EVE setting resides. 
(edited)
Jeffrey Kalmikoff  [7:58 AM]
was added to the conversation by .Avinash Devulapalli  [8:02 AM]
To make this a single Global setting - Check out version 6 - Sort of simplifies it as a global setting but UX wise might not be highly intuitive
[8:03 AM]You can toggle b/w versions on the top right. See ss
Screenshot 2026-03-27 at 8.32.50 PM.png Arjun Rattan  [8:37 AM]
was added to the conversation by .Devin Smith  [9:07 AM]
what would be the parameters of this?

Hey good morning - can we quickly align on what it would take to support full human review bypass, per Shoaib’s ask?  @avinash.devulapalli can you re-share the v0 design here?

Just thinking about newer behaviors & the need to have HIL in early stages
Nihar Gupta  [9:10 AM]
Here is the Shoaib ask for context -
we discussed today but just want to confirm we are aligned. we should have a setting that allows org to select if they want: 1) EVE only with no human in the loop, 2) EVE and human in the loop, 3) no EVE only human in the loop. default being 2. and almost no one will change this.Nihar Gupta  [9:11 AM]
replied to a thread:Aligned that new behaviors may be problematic, but I think we caveat this in copy instead of excluding them from beta behaviors
Devin Smith  [9:11 AM]
are there any behaivor specific nuances?
[9:11 AM]OK