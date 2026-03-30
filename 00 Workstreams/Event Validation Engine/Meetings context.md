https://gomotive.slack.com/archives/C0APE941FHA/p1774892902615499






Search Motive






Home
1

DMs
2

Activity
3

Files
4

Later
5

More
0

Direct messages

Unreads

 
Find a DM

Marc Ische, Nihar Gupta
41 mins
Actually this brings up a good point.  I think you get that needed visibility from the AIDC+ mounted on windshield.  We see this often with heavy duty vehicles.  Driver cant see something the camera can.  We should think about integrating the AIDC+ feed into the AIOC+ as part of a 360 ped detection solution

Nihar Gupta
50 mins
Google Meet: @nihar.gupta has started a Google+ Hangout and would like you to join. Join Hangout.

Avinash Devulapalli, Chandra Rathina, Devin Smith, Gautam Kunapuli, Jeffrey Kalmikoff, Michael Benisch, Nihar Gupta
10:48 AM
One of the big open questions is how this will work with collisions, which historically is optimized for recall.  We will be sending some false positives to customers now in this AI-only mode.  We need to make that clear.  @michael.benisch we need to chart a path to make this mode work, but have time to do this (doesnt need to happen by time of blog post on 4/9

Gautam Kunapuli
10:14 AM
@Arjun, here is the old PRD for Blind Spot Pedestrian Monitoring.

Chandra Rathina
10:10 AM
You: still onboarding on specs , have follow up with Marc right after this

Devin Smith
9:08 AM
ok cool

Achin Gupta, Devin Smith, Nihar Gupta
8:15 AM
The right answer is probably something in between - dont turn on for lower markets that have extremely low watch rates while defaulting on for MM+

Achin Gupta, Devin Smith, Dhiraj Bathija
8:03 AM
Previous call overrunning, joining in 2 mins

Achin Gupta
7:41 AM
You: 2 minutes.

Arjun Rattan (you)
Saturday
You: https://k2labs.atlassian.net/wiki/spaces/RND/pages/6171000850/4003+UK?focusedCommentId=6247940097

Danyyal Ahmed Khalid, Nihar Gupta
Friday
Happy to help! Please feel free to let me know if I can assist in anything else.

Michael Benisch
Friday
You: yep that data should be there, we do need a punchlist etc for Q1 and Q2 , will tag



8






Messages

Add canvas

Files

CanvasListFolder














This is the very beginning of your direct message history with @avinash.devulapalli, @Chandra Rathina, @Devin Smith, @Gautam Kunapuli, @Jeffrey, @michael.benisch, and @nihar.gupta
You’ll be notified for every new message in this conversation. Change this setting
Nihar Gupta
  6:36 AM
Hey good morning - can we quickly align on what it would take to support full human review bypass, per Shoaib’s ask?  @avinash.devulapalli can you re-share the v0 design here?
6:39
we would sacrifice a few things which we will make clear in copy - eg life-threatening collision identification and positive driving.  Are there other blockers to doing this?
6:41
Dont we have an “annotations not required” field or something that bypasses annotators for AI events?
Slackbot
  6:42 AM
@Chandra Rathina and @Devin Smith have been added to the conversation by Nihar Gupta
.
Nihar Gupta
  6:43 AM
Also Avinash, I think you had this in the collisions section in settings, this needs to be apply globally across everything including AI events
Avinash Devulapalli
  7:43 AM
hey @nihar.gupta - Check out version 5 in this v0 prototype with last night's feedback incorporated: https://v0.app/chat/motive-safety-prototype-lJ4k5TqWjs7?ref=GU4RGW (edited) 
7:47
Also Avinash, I think you had this in the collisions section in settings, this needs to be apply globally across everything including AI events
There is a UX conflict here that is why I was proposing 2 places instead of a single global setting:
In version 5 - What I am proposing rn in the v0 above is:
Safety Settings > Collisions card - First responder Enable/Disable lives here. Hence for collisions, the EVE settings resides here to ensure when users select 'AI only', we ensure to show them that First responder is disabled in this card itself.
Safety settings > Unsafe behavior and Event intelligence > Event intelligence - This is where all other events EVE setting resides.
(edited)
Jeffrey Kalmikoff
  7:58 AM
was added to the conversation by Avinash Devulapalli
.
Avinash Devulapalli
  8:02 AM
To make this a single Global setting - Check out version 6 - Sort of simplifies it as a global setting but UX wise might not be highly intuitive
8:03
You can toggle b/w versions on the top right. See ss
Screenshot 2026-03-27 at 8.32.50 PM.png
 
Screenshot 2026-03-27 at 8.32.50 PM.png
Arjun Rattan
New hire:wave:  8:37 AM
was added to the conversation by Nihar Gupta
.
Devin Smith
  9:07 AM
what would be the parameters of this?
Hey good morning - can we quickly align on what it would take to support full human review bypass, per Shoaib’s ask?  @avinash.devulapalli can you re-share the v0 design here?
Just thinking about newer behaviors & the need to have HIL in early stages
Nihar Gupta
  9:10 AM
Here is the Shoaib ask for context -
we discussed today but just want to confirm we are aligned. we should have a setting that allows org to select if they want: 1) EVE only with no human in the loop, 2) EVE and human in the loop, 3) no EVE only human in the loop. default being 2. and almost no one will change this.
Nihar Gupta
  9:11 AM
replied to a thread:
what would be the parameters of this?…
Aligned that new behaviors may be problematic, but I think we caveat this in copy instead of excluding them from beta behaviors
Devin Smith
  9:11 AM
are there any behaivor specific nuances?
9:11
OK
Avinash Devulapalli
  12:28 AM
@Jeffrey - I would need your pov on the above prototype's version 5 and 6. Looks like SM is expecting a figma design of the EVE setting to be incorporated in the EVE blogpost. (edited) 
12:28
@nihar.gupta - by when are we supposed to turn-in the figma design? Do you know? (edited) 
Nihar Gupta
  7:02 AM
Let’s target Tuesday.  I cant provide feedback in v0, can we move this figma?
Nihar Gupta
  7:16 AM
This is a good start, thanks Avinash.  I think my preference is a single setting as in version 6, not bifurcating the decision in 2 places.  Let’s call it “event validation settings”.  Event review is still too human review-oriented.  Also I think the copy can be streamlined / simplified (edited) 
Jeffrey Kalmikoff
  11:04 AM
i can knock this out really quickly in Figma based on version 6 of the v0 prototype. I'll drop a link in here when it's ready. Before Tuesday is no problem, but let's be sure we're keeping the feedback loops tight as I have a number of other projects concurrently in play :sweat_smile: (edited) 
Jeffrey Kalmikoff
  12:55 PM
Figma work done. Screenshots are of the recommended version in situ and the spread of all view + edit states across all 3 versions.
If we're handing this off on Tuesday, then we need to get content design eyes on this ASAP. I'll use the AI content design tool in the meantime for first passes.
3 files
 

Download all
Screenshot 2026-03-28 at 12.51.09 PM.png
Screenshot 2026-03-28 at 12.51.27 PM.png
Screenshot 2026-03-28 at 12.53.35 PM.png
Event Validation Settings
https://api-cdn.figma.com/resize/thumbnails/6594ec9a-c748-4180-a516-4a2fb38fbf2a?expiration=1774828800&signature=72a41bca14f84ad244ffb9bee325e92246f2ff429e2fcaf419c5679003169b64&height=112&bucket=figma-alpha

Added by Figma
Devin Smith
  9:56 AM
This is a great start. As we move from human to AI-augmented reviews, I have a few specific concerns regarding transparency and clarity:
The "Legacy" Perception: Long-time users may already assume we review every event. We need to consider how this UI frames the transition without undermining their past trust in the system.
Beta vs. Human-in-the-Loop: For Beta behaviors, we’ll likely need human oversight for the foreseeable future. How does the UI distinguish between "AI-Validated" and "Human-Verified"? We may need a way to track and display these nuances clearly.
Image vs. Video Accuracy: Are image-based events included in this EVE? If so, we need to be transparent about the accuracy differences between image and video validation to manage expectations or explain that tradeoff or transition.
If we ignore what happens after caps by introducing these new frameworks, it will force people to really think about what we are doing, which will naturally lead them to question other downstream impacts or changes - which could be good & bad in some cases.
Onboarding & Field Readiness: I’m thinking ahead to our power users and Sales Engineers. The UI needs to make these complex conditions easy to explain.
High-level documentation and a strong comms plan will be vital here, maybe mapping out what this means for different User/Customer types and how we think about what the potential pro/con feedback might be and how to get ahead of it
9:57
Also does this prompt the need for us to be transparent directly in the event itself (this event was review by a human) or by AI, or by no one?
Arjun Rattan
New hire:wave:  9:59 AM
I'm building together that view, high level and will share tomorrow for feedback so we can grok it
Devin Smith
  10:02 AM
Just using our caps strategy & current logic as an example - this is and has often been a challenge to manage & explain, i think this is similar layer of complexity that does also have a relationship here.  So while EVE will improve a certain part of the pipeline/reduce costs etc, do we need to look at other variables in tandem to this or think about it a bit further (edited) 
Nihar Gupta
  6:37 PM
GTM / customer perception is definitely a consideration, but there is a plan to manage this. We have the blog post + extensive enablement planned over next week or 2 on this change.  True customer impact should be minimal if we do this right.
How we manage beta behaviors with lower precision is something we need to figure out.  And ofc collisions - we will be sending FP collision events
Image vs videos is a consideration for EVE, but isn’t directly impacted by this change.  Images weren’t getting reviewed before, they still aren’t getting reviewed unless / until we integrate into EVE (edited) 
Jeffrey Kalmikoff
  7:03 AM
replied to a thread:
Figma work done. Screenshots are of the recommended version in situ and the spread of all view + edit states across all 3 versions.…
Update on the design, @Nikhil Yadav did a revision concept based off of my initial pass. Thanks @avinash.devulapalli for getting this in front of him. His version is more simple and I agree with all of his points:
The selection should be radios instead of a dropdown
Radios eliminate the need for warning states
This control should probably live inside of Unsafe Behavior Detection
He recorded a 2 min Loom to go over his iterations which can be found here. Worth checking out. (edited) 
Loom | Nikhil Yadav
⏱️ 2 min
Simplifying Event Review Settings Design
Simplifying Event Review Settings Design
In this Loom, I shared my thoughts on simplifying the event review preference settings design that Avinash and you worked on. I proposed using radio...
Added by Loom
Avinash Devulapalli
  9:24 AM
@nihar.gupta - I'm realising we have to update our help center articles accordingly where ever we have mentioned that all our safety events are always Human reviewed. And likely a new HC article for this in itself. (edited) 
Nihar Gupta
  10:47 AM
Yes we will
10:48
One of the big open questions is how this will work with collisions, which historically is optimized for recall.  We will be sending some false positives to customers now in this AI-only mode.  We need to make that clear.  @michael.benisch we need to chart a path to make this mode work, but have time to do this (doesnt need to happen by time of blog post on 4/9












Message Avinash Devulapalli, Chandra Rathina, Devin Smith, Gautam Kunapuli, Jeffrey Kalmikoff, Michael Benisch, Nihar Gupta







Shift + Return to add a new line



