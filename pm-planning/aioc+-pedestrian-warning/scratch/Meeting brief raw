[00:00] Arjun Rattan: Arjun Rattan joined
[03:24] Gautam Kunapuli: Sam,
[04:04] Gautam Kunapuli: Gautam Kunapuli joined
[04:17] Gautam Kunapuli: What's up? What's up?
[04:18] Arjun Rattan: Good, good. I managed to trace a event all through the system.
[04:23] Gautam Kunapuli: Nice.
[04:26] Arjun Rattan: That was good. I could actually see one by one the jsons that were created.
[04:31] Arjun Rattan: I took one event and that helped me concretize the pipeline we had been chatting about.
[04:37] Arjun Rattan: There was some confusion in my mind about in cab alerts versus this.
[04:42] Arjun Rattan: But now it's pretty clear in cab alert is also going out.
[04:46] Arjun Rattan: Other than if it has got a cool off or a back off period or something that's happening.
[04:51] Arjun Rattan: Other than that, everything else, if it's created, it will always be tagged in the event.
[04:55] Arjun Rattan: So that's good.
[04:57] Arjun Rattan: A lot of setting up our good friend VS code with Claude and then getting all of that working.
[05:04] Gautam Kunapuli: Nice.
[05:05] Arjun Rattan: Yeah. So I feel good about the pipeline per se.
[05:09] Arjun Rattan: So we can talk a little bit more about I guess any like I'll defer to you on.
[05:17] Arjun Rattan: What do you think we should talk about next? Eventually onboarding as well a little bit.
[05:23] Gautam Kunapuli: Michaels, you went through the onboarding as well?
[05:27] Arjun Rattan: Yeah.
[05:28] Gautam Kunapuli: Cool. Awesome.
[05:30] Arjun Rattan: So I guess actually onboarding is how I figured it out.
[05:36] Arjun Rattan: There was a link to an annotations presentation done by the data analysts and that one had a transcript and once I got the transcript I was able to find the.
[05:46] Arjun Rattan: Sorry, I found the confluence page which had a bunch of database queries and everything.
[05:51] Arjun Rattan: So I was able to get it going from that. The onboarding is what set all of this up. Yeah,
[06:00] Gautam Kunapuli: got it.
[06:01] Gautam Kunapuli: Sorry, I'm just trying to send a quick slack if you'll bear with me one sec and then we can jump in.
[06:08] Gautam Kunapuli: In the meantime, I guess one question I have for you is obviously a lot going on so we can continue to talk about the overall roadmap.
[06:21] Gautam Kunapuli: I can go to our planning sheet and our execution roadmap and talk about a few things, but maybe high priority projects, etc.
[06:34] Gautam Kunapuli: Or yeah, if you want to continue to like kind of onboard into whatever we've been up to over the last few months.
[06:40] Gautam Kunapuli: Right. Or half really. If you think that would be helpful. I think you understand the pipeline now.
[06:48] Gautam Kunapuli: It's worth spending a little bit of time talking about the customer dashboard.
[06:53] Gautam Kunapuli: I don't know if you've had a chance to.
[06:57] Gautam Kunapuli: Maybe that would not be the worst place to be, especially around things like configs and what the impact is and how we can tie one to the other.
[07:06] Gautam Kunapuli: Yeah, there's a few areas here we can kind of COVID
[07:11] Arjun Rattan: Talk about configs, if that's okay. And I raised a request with it.
[07:16] Arjun Rattan: They came back, they Sent me to another team for the admin stuff.
[07:19] Arjun Rattan: So, yeah, you can look at the customer dashboard and just keep it very, like, user level.
[07:23] Arjun Rattan: Like, hey, what do we do? And then how does the AI stuff show up here? That would be awesome.
[07:28] Arjun Rattan: I have some sense of it. Like, okay, it's a system. You have parameters. You can decide your.
[07:34] Arjun Rattan: From what I gathered, you could decide the weights you assign to the safety score.
[07:38] Arjun Rattan: So that's one thing that came out. The other is which events you care about.
[07:42] Arjun Rattan: Which events are already on for a fleet manager.
[07:45] Arjun Rattan: And I'm guessing the third one will be an ability to either switch on, toggle on, toggle events.
[07:53] Arjun Rattan: And then the other use case I would have is everything we do at the end has a sensitivity and a specificity.
[08:03] Arjun Rattan: Since we are in the business of no false positives, specificity doesn't really matter.
[08:09] Arjun Rattan: So it might be just sensitivity, I guess, which could potentially lead to increased annotation volumes.
[08:14] Arjun Rattan: Those are the four things that kind of come out when I heard that.
[08:20] Gautam Kunapuli: Yeah, I think you're on the money. Let's talk about configurations. I think that's good.
[08:28] Gautam Kunapuli: Let me jump into. Pick a customer. Let me share my screen. Opening our admin panel.
[08:44] Gautam Kunapuli: Generally, I think this is a good place to.
[08:45] Gautam Kunapuli: Gautam Kunapuli started sharing their screen
[08:47] Gautam Kunapuli: And I'll show you an annotation tool as well, just so you have some rough idea of what's generally going on over there.
[08:55] Gautam Kunapuli: So let's pick a nice customer, an actual customer. Right. Okay. Definitely not touching those guys.
[09:07] Gautam Kunapuli: I don't know. Let's pick Koni elevators, I guess. Right. So let's do companies.
[09:12] Gautam Kunapuli: So if you go to companies. I try to stay away from FedEx. There's like a whole team over there. Yeah.
[09:20] Gautam Kunapuli: So basically, if you go to companies, you'll see things like this. Right.
[09:28] Gautam Kunapuli: So there's a whole lot of stuff around account status. Disqualified.
[09:31] Gautam Kunapuli: There's a whole lot of meanings around what all of these are.
[09:35] Gautam Kunapuli: And then some companies may have multiple accounts as they go through our various stage.
[09:40] Gautam Kunapuli: It gets cleaned up, reported in a bunch of different ways, etc. Actually, let's do the following.
[09:46] Arjun Rattan: Right.
[09:47] Gautam Kunapuli: This kind of give me an opportunity to also spy on one of the. So let's do Centerpoint.
[09:54] Gautam Kunapuli: Actually, Centerpoint are a new prospect based out of Texas.
[10:01] Arjun Rattan: And. So this is a trial. You're showing me a trial.
[10:10] Gautam Kunapuli: Yeah. So let's go to the account itself so we can go to the Center Point Energy.
[10:17] Gautam Kunapuli: So you get a lot of stuff. I know this thing is like massive and it's super overwhelming.
[10:22] Gautam Kunapuli: I've been here for like three and a half years. And it's very overwhelming for me.
[10:28] Gautam Kunapuli: So I wouldn't overly worry about the crazy stuff you can actually get access to.
[10:33] Gautam Kunapuli: But I do want to talk about one important thing, which is if you look at company connections over here, it basically shows you all the people who are at Motive but are also at Centerpoint, the customer who currently have admin privileges to the.
[10:52] Gautam Kunapuli: To the thing. So Mike Williams is the account exec. Lydia Render is our customer support exec.
[11:00] Gautam Kunapuli: So let's just look at Lydia's and then over here. Why is this gone? Have I lost history?
[11:08] Gautam Kunapuli: Support mode is empty here. Okay, let's try.
[11:12] Arjun Rattan: Maybe the trial people never needed support.
[11:18] Gautam Kunapuli: I may have lost access to. Jumping in via support mode, mostly because. Let's do companies. Okay.
[11:29] Gautam Kunapuli: Actually, let's try some. Let's try one more thing before we leave.
[11:32] Gautam Kunapuli: Let's say somebody from Centerpoint. Yeah.
[11:35] Gautam Kunapuli: See, so here, ironically, what I was trying to show you is the support mode, there's a link to go into the customer dashboard, which I don't seem to find right now.
[11:44] Gautam Kunapuli: So let's go back to companies and let's just do Motive Internal. Hopefully I have access to that,
[11:56] Arjun Rattan: But
[11:57] Gautam Kunapuli: they may have stripped support more access to everybody, which is not really the best way to be.
[12:05] Gautam Kunapuli: To be honest.
[12:25] Gautam Kunapuli: So much for a nice demo and then everything never works when you want it to. Right.
[12:32] Gautam Kunapuli: So let's try company connections here.
[12:37] Gautam Kunapuli: Yeah, I think I've lost support mode access across the board, so I cannot get into company accounts, which is kind of grim, really.
[12:47] Arjun Rattan: They probably did a security audit.
[13:00] Gautam Kunapuli: Very good. I was going to show you how customers set their configurations, but I think we'll.
[13:07] Gautam Kunapuli: We'll, you know, on the customer dashboard, which you will also be able to see.
[13:12] Gautam Kunapuli: Are you able to get into our Motive Internal account on your screen?
[13:16] Arjun Rattan: No. Do you mind sending me the link just how you got in? Because I don't think I can.
[13:21] Arjun Rattan: I raised an IT record.
[13:22] Gautam Kunapuli: Yeah, yeah.
[13:24] Arjun Rattan: Oh, you mean. Yeah, yeah. I can see the Motive account.
[13:27] Gautam Kunapuli: Yeah, go ahead and log in any old company.
[13:28] Gautam Kunapuli: Gautam Kunapuli stopped sharing their screen
[13:31] Gautam Kunapuli: I need to reset my password there, so I can't jump in just yet.
[13:34] Arjun Rattan: I am in this thing. I'll show you where I am.
[13:43] Arjun Rattan: Arjun Rattan started sharing your screen
[13:48] Gautam Kunapuli: Awesome. So let me see if I remember where it is exactly. So if you go to Fleet View.
[14:05] Gautam Kunapuli: History, vehicle drivers, assets, etc. All right, if you come all the way to the bottom.
[14:11] Gautam Kunapuli: No, not this list, sorry.
[14:12] Gautam Kunapuli: On the left panel, if you come all the way to the bottom, there's like four icons at the bottom, right?
[14:16] Gautam Kunapuli: So
[14:19] Arjun Rattan: I wonder.
[14:20] Gautam Kunapuli: Yeah. The rightmost one, which is the user account. Yeah. So that's. These are account settings. Yeah.
[14:27] Gautam Kunapuli: Actually, no, can you go to the left bar under Fleet View, where it says Safety, Go to Safety.
[14:36] Gautam Kunapuli: And now here, click on Events. Yeah. So have you been looking at these events broadly? Yeah. Awesome.
[14:51] Gautam Kunapuli: There's a place here.
[14:53] Gautam Kunapuli: Man, it's been ages since I've been on this customer dashboard where you get to set parameters directly from the customer level.
[15:02] Gautam Kunapuli: But we can go back. Let's use Confluence.
[15:26] Gautam Kunapuli: Take my screen back. We'll come back to this in a second.
[15:30] Arjun Rattan: Arjun Rattan stopped sharing your screen
[15:30] Arjun Rattan: Arjun Rattan started sharing your screen
[15:31] Gautam Kunapuli: Cool. So this is the landing page for all of the AI configurations we have today.
[15:41] Gautam Kunapuli: There is a little bit of tech debt that is involved in the sense that some DC and the AIDC config names don't exactly align.
[15:52] Gautam Kunapuli: This was an unfortunate oversight when we were first creating our technical design documents and I missed it and so did everybody else.
[16:03] Gautam Kunapuli: And so I had to.
[16:05] Gautam Kunapuli: There's probably some pin somewhere in some channel, basically of me chewing everybody out for being careless and having two separate things.
[16:12] Gautam Kunapuli: We'll fix it one of these days.
[16:14] Gautam Kunapuli: But broadly, there are a lot of different parameters that you want to worry about.
[16:20] Gautam Kunapuli: So let's pick a very common event like close following and talk about this.
[16:27] Gautam Kunapuli: As I said, there are two separate state machines.
[16:30] Gautam Kunapuli: There is the event state machine and then there is the alert state machine.
[16:37] Gautam Kunapuli: In reality, the triggering of alerts can be set to different thresholds than the triggering of event generation, which basically means that it is completely possible in our system today through configurations to enable that drivers here in cab alerts.
[17:00] Gautam Kunapuli: Whereas it doesn't show up on a fleet manager dashboard or the reverse where it, you know, the driver doesn't hear the in cab alerts, but it does show up on the fleet manager dashboard or both.
[17:14] Gautam Kunapuli: In the past, the alert configurations were set to high precision and I'll explain where in a second.
[17:20] Gautam Kunapuli: Whereas the event configurations were set to high recall.
[17:25] Gautam Kunapuli: The purpose of this was to ensure that the driver experience was not severely degraded because you don't want too many false positives.
[17:35] Gautam Kunapuli: Hence high precision for the driver, whereas for the fleet manager and the event configurations, we had initially said we want high recall because we want to collect with high sensitivity.
[17:46] Gautam Kunapuli: All the candidates and annotators would filter that out.
[17:49] Gautam Kunapuli: We stopped doing this sometime last year as part of our event alert parity project.
[17:54] Gautam Kunapuli: There's two reasons for this and Anand is the person to talk to as. Am I right? I'm the engineering.
[18:02] Gautam Kunapuli: I was the engineering lead on that effort along with Ali, who's out of the office.
[18:05] Gautam Kunapuli: But we can give you more context. The reason for this is twofold.
[18:09] Gautam Kunapuli: One is we don't want to generate a very large number of events and then filter them with annotators because we are running out of annotated capacity.
[18:17] Gautam Kunapuli: And the second is we don't want to deal with and customer expectation is, especially for enterprise customers, that they want to see reports every month.
[18:27] Gautam Kunapuli: They want to see reports that say here are the number of in cab alerts that the drivers heard in their cabs and they want to see the corresponding videos.
[18:36] Gautam Kunapuli: Which means that the only time there is a disparity between what the driver hears in their cabin and what the fleet manager experiences in the dashboard will be if there was a false positive.
[18:50] Arjun Rattan: What about suppression and all that stuff? That won't count.
[18:53] Gautam Kunapuli: That does count. So there are a few reasons why it is suppressed. One of them is false positives.
[18:59] Gautam Kunapuli: Capping is another one. Video caps is. Is another reason why they will not see it.
[19:05] Gautam Kunapuli: And there are a couple of other niche Karner cases that we will get into, but rate limiting is one reason.
[19:12] Gautam Kunapuli: The other is. Yeah, so let's look at those.
[19:16] Arjun Rattan: What about situations where. Yeah, that's what we just said. Right.
[19:21] Arjun Rattan: So the driver can get an alert, but it cannot be documented.
[19:24] Arjun Rattan: But it can't be the other way around that the you can get in. Yeah, because it should not ever be
[19:30] Gautam Kunapuli: the other way around.
[19:31] Gautam Kunapuli: If it's a legitimate event, the driver should have heard an in cab alert for it.
[19:37] Arjun Rattan: Unless you had cool down, back off,
[19:40] Gautam Kunapuli: all that stuff activated, which we have also.
[19:44] Arjun Rattan: So we track that like, okay, hey, there was a legitimate event.
[19:48] Arjun Rattan: This is your 300 events, but guess what? We only gave 250. The other 50 are explained by X, Y and Z.
[19:55] Gautam Kunapuli: We do track that.
[19:56] Gautam Kunapuli: We had an intensive engineering effort in the last half where we fixed various pieces of our backend to put logging into place.
[20:04] Gautam Kunapuli: And then we created.
[20:07] Gautam Kunapuli: You can generate a report now either at the vehicle level or at a company level where you can get a full audit.
[20:13] Gautam Kunapuli: And we also have the uuids of an alert and an event so we can actually match them in the backend
[20:22] Arjun Rattan: often alert and an event. So every alert will have an event, but all events cannot have an alert.
[20:32] Arjun Rattan: That's not okay.
[20:34] Gautam Kunapuli: That's generally the intended behavior.
[20:37] Gautam Kunapuli: That's generally where we are converging towards or have converged towards.
[20:41] Gautam Kunapuli: And the second addendum to that is that every time there is not a match, you should be able to explain why.
[20:50] Gautam Kunapuli: Exactly. Yeah, yeah, like why that's the observability piece. So it's, it's not exactly bijective.
[20:57] Gautam Kunapuli: It's.
[20:57] Gautam Kunapuli: It's one to one when it comes to every event should have an alert, but every alert may not have necessarily an event.
[21:05] Gautam Kunapuli: And the reasons for that are either because there was an AI false positive or we did some kind of rate limiting in the cloud, whatever it is.
[21:14] Gautam Kunapuli: There are, there are.
[21:15] Arjun Rattan: Yeah, I understood.
[21:17] Gautam Kunapuli: We need to explain all of this.
[21:18] Arjun Rattan: Yeah.
[21:18] Arjun Rattan: Whether the discrepancy is coming from alerts to events or events to alerts, we should be able to explain it at the end.
[21:25] Arjun Rattan: Which we can. Okay.
[21:26] Gautam Kunapuli: Which we can power about 99%.
[21:29] Gautam Kunapuli: There's still some things where we are not able to track camera failures for weird reason.
[21:34] Gautam Kunapuli: There's always going to be some small bit of unknown in the bucket.
[21:38] Gautam Kunapuli: So let's look at close following today.
[21:42] Gautam Kunapuli: Close following behavior is controlled by these five parameters.
[21:48] Gautam Kunapuli: So this is the event generation piece.
[21:50] Gautam Kunapuli: So you will see going forward that almost all events have a minimum event duration, they have a minimum speed.
[21:59] Gautam Kunapuli: These are the two kind of trigger conditions that have nothing to do with AI.
[22:05] Gautam Kunapuli: They're just, you know that, that's, that's basically a customer preference.
[22:09] Gautam Kunapuli: So these two are exposed to customers and then time to hit is unique to close following.
[22:15] Gautam Kunapuli: So that basically is something that determines how risky the close following is and is also exposed to customers.
[22:24] Arjun Rattan: Yeah.
[22:24] Gautam Kunapuli: What is not exposed to customers is even tolerance and confidence.
[22:30] Arjun Rattan: Okay.
[22:30] Gautam Kunapuli: So these, these two are not exposed customers.
[22:33] Gautam Kunapuli: We don't currently document what is exposed to customers and what is not exposed to customers in this table, which we should.
[22:39] Gautam Kunapuli: It's a bit of a documentation backlog that I have on our list, but somebody in the team will be able to tell you or you can go look in the customer dashboard.
[22:47] Gautam Kunapuli: That's what I was trying to show you. Right.
[22:49] Arjun Rattan: Yeah.
[22:49] Gautam Kunapuli: There'll be a bound, there'll be an option with a data entry text box and that will correspond to one of these in our, in our pipeline.
[23:00] Arjun Rattan: Yeah. So today when I'm on the Motive fleet one, I should still be able to see all of this. Right.
[23:06] Arjun Rattan: Because I can. Because at the end the. So let me try this.
[23:09] Arjun Rattan: The customer can Motive event duration, speed threshold and time to hit or they are just shown like what do you mean when they are shown, is it modifiable?
[23:19] Arjun Rattan: Is it shown on the actual ux like hey, your minimum event duration is this, your minimum speed is this.
[23:25] Arjun Rattan: You can go configure this if you want, etc.
[23:29] Gautam Kunapuli: And I've been trying to get on the customer dashboard so I can show you exactly where it is.
[23:32] Gautam Kunapuli: So if you want, we can flound around a little bit and we'll find it. But there is a.
[23:37] Gautam Kunapuli: There is a nice breakdown for every AI event.
[23:41] Arjun Rattan: Okay.
[23:42] Gautam Kunapuli: Got stop sign violation. There's one for close following. There's one for smoking.
[23:46] Gautam Kunapuli: And typically there are three or four things that are exposed to customers that allows them to customize the behavior for their fleet.
[23:54] Arjun Rattan: Okay. All right.
[23:55] Gautam Kunapuli: You can also set it at individual vehicle level, but typically fleets don't go that.
[24:00] Gautam Kunapuli: That insane, but you can. Got it.
[24:05] Gautam Kunapuli: So basically, the two things you want to keep in mind beyond event duration, speed and time to hit.
[24:13] Gautam Kunapuli: Time to hit, we compute. Time to hit is actually not a time. It's a distance measure.
[24:19] Gautam Kunapuli: We say time to hit, but time to hit is a time. Time to hit is just a rule of thumb for distance.
[24:27] Gautam Kunapuli: Actually, the way time to hit is measured is basically saying this is the distance of the vehicle in front of you.
[24:34] Gautam Kunapuli: I'll divide it with my speed.
[24:36] Gautam Kunapuli: And that's basically saying that if that vehicle suddenly comes to a stop from like 70 miles an hour to zero, it will take you this much time to hit it.
[24:43] Gautam Kunapuli: That's what time to hit means.
[24:44] Gautam Kunapuli: The reality, of course, is that no vehicle will come to an instantaneous stop unless it runs into a brick wall of some sort.
[24:51] Gautam Kunapuli: Right. And then. Yeah. So it's.
[24:55] Gautam Kunapuli: But what it tells you is it gives you a really good expectation of how close you are to the vehicle in front of you.
[25:03] Arjun Rattan: Yeah. And that's your. That's your worst case. If it hits an instantaneous stop, that
[25:11] Gautam Kunapuli: is your absolute correct. That is. That is the. It's not even realistic.
[25:16] Gautam Kunapuli: But this is an industry standard. And everybody. Everybody does it.
[25:18] Gautam Kunapuli: They all call it a few different things. But yeah.
[25:22] Gautam Kunapuli: The other two things here you can see are event tolerance.
[25:26] Gautam Kunapuli: This is the close following event tolerance in seconds.
[25:28] Gautam Kunapuli: What that means is basically that this state machine will tolerate the following and still generate an event.
[25:38] Gautam Kunapuli: Let's say that I am tailgating you. The system was able to detect the tailgating for five seconds.
[25:48] Gautam Kunapuli: It completely does not see anything at all for five whole seconds.
[25:52] Gautam Kunapuli: And then it sees close following for another five seconds. You see what I'm saying?
[25:56] Gautam Kunapuli: So the event tolerance works in concert with minimum event duration. Basically.
[26:03] Gautam Kunapuli: You see what I'm saying? If I see something like three, five, it's an aggregate. It's an aggregate.
[26:10] Arjun Rattan: It's an aggregate. And what is the window for that aggregate?
[26:14] Gautam Kunapuli: It's fine. The default here is five seconds.
[26:16] Arjun Rattan: So what I meant is. Is the window determined based on just.
[26:20] Arjun Rattan: So if I see something like 3, nothing for say 5 seconds, then I see another 5, for example, then nothing for say 10 seconds and then I see 2.
[26:34] Arjun Rattan: So total, I met 10 events.
[26:37] Gautam Kunapuli: You'll see that.
[26:38] Gautam Kunapuli: You'll see the first window, but you won't see the second one because the 10 is bigger than the 5.
[26:44] Gautam Kunapuli: So it stops.
[26:45] Arjun Rattan: Okay, so it'll reset. Right, so it resets.
[26:48] Arjun Rattan: So minimum event duration is in a period of 10 seconds, I need to
[26:53] Gautam Kunapuli: see at least five seconds. Yeah.
[26:57] Gautam Kunapuli: That's how you interpret the tolerance within a window of minimum event duration.
[27:02] Gautam Kunapuli: If I see at least minimum event duration minus tolerance worth of activity, then I will create.
[27:08] Arjun Rattan: So minimum event is 10, tolerance is 5. So let's say the tolerance was 2. Let's just.
[27:14] Arjun Rattan: So then for 8 seconds in that 10 second window, I should see it.
[27:20] Gautam Kunapuli: Correct.
[27:20] Arjun Rattan: Okay, got it. All right.
[27:22] Gautam Kunapuli: That's what the tolerance implies. And it will also handle like contiguous things.
[27:27] Arjun Rattan: Okay.
[27:27] Gautam Kunapuli: The other is this bounding box confidence. This is the ego vehicle minimum bounding box confidence.
[27:36] Arjun Rattan: So the interesting question would be, to my mind is on average these defaults that we've put in, how many times do these defaults get changed by the fleet managers?
[27:52] Arjun Rattan: Do they or do we have like. Yeah, I would be just curious, like, what's the UX on that?
[27:59] Arjun Rattan: And I'm guessing it might change based on whether you're driving in the city, outside you're on a highway, etc.
[28:07] Gautam Kunapuli: Etc. Yeah. So just to be very clear. Exactly correct. And now let me give you some bad news.
[28:22] Gautam Kunapuli: Understanding who changed configs today is not a solved problem at motivation.
[28:28] Gautam Kunapuli: I see it's not a fully observable system. There are numerous people who can change configurations.
[28:34] Gautam Kunapuli: One is obviously the customer themselves. The other is somebody at Motive.
[28:38] Gautam Kunapuli: The customer does it through their panel.
[28:40] Gautam Kunapuli: The second is somebody at Motive does it through their panel.
[28:44] Gautam Kunapuli: Like now I've lost access to support mode, I think, so I'll have to re request it.
[28:49] Gautam Kunapuli: The third is I can make changes from the admin panel.
[28:53] Gautam Kunapuli: And then the fourth is I can write scripts to push changes across the fleet, which is how the IoT team manages fleet wide.
[29:01] Gautam Kunapuli: Like all across.
[29:02] Gautam Kunapuli: Every time we push a new build, which is monthly, we also push a new set of configurations to adjust the behavior across the board and so forth.
[29:10] Gautam Kunapuli: So we don't have change logs, we have a.
[29:17] Gautam Kunapuli: So if you look at the device, we will be able to see that a configuration changed.
[29:24] Gautam Kunapuli: So we do have a change log, we just don't know who made the change.
[29:27] Arjun Rattan: So yeah. So, okay, so you can track this individual change.
[29:31] Arjun Rattan: You just can't track the unique identifier associated with that change.
[29:36] Gautam Kunapuli: You can't track the unique identifier of the person who made the change.
[29:40] Arjun Rattan: Okay, so you'll get a system level like oh, that makes sense. Right.
[29:43] Arjun Rattan: Motive is centered, but who within Motive. Okay, I got it. It's fine. Just a broad question.
[29:49] Gautam Kunapuli: We'll, we'll get into it. It's.
[29:50] Gautam Kunapuli: It's something that we'll need to fix and it's in some state of like being fixed.
[29:54] Gautam Kunapuli: But it there you will see that there is a non trivial amount of systemic tech debt floating around over here.
[30:02] Gautam Kunapuli: And at some point like trying to find a little bit of time to clean up some of these things is something that I've tried to do for a long time.
[30:12] Gautam Kunapuli: We fixed a few of them, there's still a few open things and I have a list of this kind of crap that I'd be very happy to fix over the next few months.
[30:22] Gautam Kunapuli: Except that we also go at like 2,000 miles an hour.
[30:26] Arjun Rattan: I was just gonna say that, that I would be shocked if, if you are given the time to go fix
[30:33] Gautam Kunapuli: all this stuff, the only way this is going to work is if you and I and a couple of other people form a cabal internally that we want to fix this.
[30:40] Arjun Rattan: Yeah.
[30:41] Gautam Kunapuli: I assign somebody off the books to work on this so that they don't know that this person is working on it.
[30:46] Gautam Kunapuli: And one day magically it gets fixed. It's not as bad as that, but you get the idea, right?
[30:54] Arjun Rattan: I get the idea. Like I see the company culture and how we got to where we are.
[30:59] Arjun Rattan: I can imagine that pivots and priorities and being agile, things will get left behind
[31:08] Gautam Kunapuli: in my opinion.
[31:10] Gautam Kunapuli: There are a couple of flat kind of holistic system level challenges today that I think are seriously holding us back from moving at some point.
[31:24] Gautam Kunapuli: If you want to be agile in addressing the concerns of 500,000 customers and 10 million cameras in the field, then this is the kind of shit that's not going to fly.
[31:35] Gautam Kunapuli: That's the ambition we have to get to in the next two years.
[31:39] Gautam Kunapuli: This is not something we urgently need to solve for this particular instant. Perhaps.
[31:45] Gautam Kunapuli: But if you want to get to that place where every vehicle in North America has a Motive camera in it, that's a lot of vehicles and we can get there.
[31:56] Gautam Kunapuli: That's the ambition. Then we have to solve for some of these kinds of problems. But we'll get into it.
[32:05] Gautam Kunapuli: This is More aspirational rather than.
[32:07] Arjun Rattan: Yep, I got it. Yeah.
[32:09] Gautam Kunapuli: It's not like. It's not like a fire, right? It never is.
[32:12] Gautam Kunapuli: It's just one of those things that is annoying in the moment. These are the alert configurations.
[32:18] Gautam Kunapuli: You can see that they have the same name as the event configurations, except there's an in cab alert.
[32:24] Gautam Kunapuli: So there's a minimum speed, there's a minimum event duration over here, minimum speed.
[32:32] Gautam Kunapuli: And then there's a time to hit and then there's a tolerance, and then this is a deprecated thing, so don't worry about it then.
[32:43] Gautam Kunapuli: We also have not 100% parity between alerts and events the way they're implemented.
[32:50] Gautam Kunapuli: Close following is one of them.
[32:52] Gautam Kunapuli: We put something in called the dsf, the Distance sanity Filter, back in the day.
[32:56] Gautam Kunapuli: There are some additional parameters associated with it Today we've aligned everything so that the behavior is identical.
[33:02] Gautam Kunapuli: But you'll see some historical configs left over here.
[33:07] Gautam Kunapuli: Here's another example of tech debt cleaning up all of these configs because it does have a material impact on our ability to create new features.
[33:15] Gautam Kunapuli: Because our shadow that we get from the IoT process and from AWS is limited.
[33:20] Gautam Kunapuli: And by having unused configurations like this, it uses up the shadow.
[33:25] Gautam Kunapuli: A lot of memory, you get the idea. And it scales our efficiency.
[33:32] Arjun Rattan: But I'm trying to figure out this.
[33:37] Arjun Rattan: I guess the impact of one config file in one parameter scaled across thousands of cameras and events coming from that.
[33:48] Arjun Rattan: I don't know. I'm struggling to figure out how one.
[33:51] Arjun Rattan: Maybe there are a bunch of these, but given we have what, like 14, 16 more AI behaviors.
[33:58] Arjun Rattan: Let's see driver facing, road facing. So road facing is like don't follow someone, don't bank.
[34:04] Arjun Rattan: It's like 12 or 13. Right. And you take those config files and all.
[34:09] Arjun Rattan: I don't think it'll have a large memory footprint, but maybe I'm way off because I would be surprised with just 13 models.
[34:18] Gautam Kunapuli: Well, I mean, 13 models, they have very descriptive names. There's a bunch of them that are unused.
[34:27] Gautam Kunapuli: It does kind of pile on.
[34:29] Gautam Kunapuli: We recently had a problem where we ran out of shadow memory because for drowsiness and fatigue, we actually created somewhere close to 40 configs.
[34:39] Gautam Kunapuli: Not just for the drowsiness main, like for the fatigue index main feature, but also for the micro behaviors.
[34:46] Gautam Kunapuli: So.
[34:46] Arjun Rattan: So that's where it's happening. So this is just a macro. There might be micro models there.
[34:52] Gautam Kunapuli: Is there? Yeah. It's beginning to blow up now.
[34:56] Arjun Rattan: Okay.
[34:56] Gautam Kunapuli: It was Not a problem.
[34:58] Arjun Rattan: And
[35:00] Gautam Kunapuli: yeah,
[35:03] Arjun Rattan: I guess with AIOC plus, do you get new. More ram? Probably not, no.
[35:08] Arjun Rattan: Anyway, this is an interesting architectural problem to solve. We can keep going. Productive thing.
[35:12] Arjun Rattan: Yeah, I'll bitch along with you, but like, it's a process OS allocation architecture, GPU.
[35:20] Arjun Rattan: I don't think we're running massive VLMs on the edge, so it's more about being more efficient.
[35:27] Arjun Rattan: I don't think we'll go change hardware roadmaps based on this. Cool, cool. We can keep going.
[35:32] Arjun Rattan: And what I meant by hardware is if software can't go solve it if things blow up. Yeah.
[35:39] Arjun Rattan: Because we had a discussion, right. Three hours ago, AIOC plus.
[35:41] Arjun Rattan: And now I'm trying to figure out what does AI need to tell them?
[35:44] Arjun Rattan: Do I need more memory, do I need more this, do I need audio capabilities, stuff like that?
[35:51] Arjun Rattan: But okay, this is very useful. Yeah. So I have a sense of it now.
[35:55] Arjun Rattan: Yeah, that and I guess once I get access to the admin panel, I should be able to play around with these.
[36:07] Arjun Rattan: However, I am going to take.
[36:08] Arjun Rattan: I'm going to pause here because I know we are at time and I want to make sure that we use the next two or three meetings a bit more judiciously.
[36:15] Gautam Kunapuli: Gautam Kunapuli stopped sharing their screen
[36:18] Arjun Rattan: And so this has been useful.
[36:20] Arjun Rattan: It's told me the user experience side of what's happening with the AI model.
[36:24] Arjun Rattan: As the AI model goes through the config files, how the users are seeing it, what do they see, what they can change, what they cannot change.
[36:34] Arjun Rattan: At this stage.
[36:36] Arjun Rattan: From a product perspective, I think we can have the next discussion a little bit more pointed on road mapping and yeah, like three or four top priorities.
[36:51] Arjun Rattan: How I'm thinking, because I'm writing out a PRD for pedestrian detection today.
[36:56] Arjun Rattan: For aoc, yes, for aioc. And it's not like it's going to be finished.
[37:02] Arjun Rattan: It'll be good enough to have questions and identify open areas that need to be explored.
[37:08] Gautam Kunapuli: Do you have five more minutes to chat on that?
[37:10] Arjun Rattan: Yeah, yeah, I have time. I want to be conscious of your time.
[37:13] Gautam Kunapuli: No, no, that's cool. I. I'll. I'll. Yeah, let's. Let's talk for a few more minutes. I'll.
[37:17] Gautam Kunapuli: I'll give you a couple of general senses of where the whole process kind of breaks down and the work.
[37:25] Arjun Rattan: So, so let's contextualize it because it will be useful for me as I bring it together and then you give me feedback.
[37:31] Gautam Kunapuli: Sure.
[37:31] Arjun Rattan: Here is my thinking from a very simple perspective.
[37:36] Arjun Rattan: This is a hardware launch where you need a killer app. Or a killer use case.
[37:40] Arjun Rattan: That's how I think about it. This is from my PlayStation days. We think pedestrian is a good one.
[37:45] Arjun Rattan: We've pitched it as, oh, we'll take four analog cameras, we'll put in something on top of it.
[37:50] Arjun Rattan: But if you just pitch it like that, to my head, you're just saying I'm a better version of Pro Vision.
[37:54] Arjun Rattan: This is not really going to move the needle. You need a good use case that people get excited about.
[37:59] Arjun Rattan: People who are either not using you today or who this use case enables. We've picked up Pedestrian.
[38:05] Arjun Rattan: We already did pedestrian warning in our aidc, so we've been working on that already.
[38:10] Arjun Rattan: So there's reusability components there. I have some customer sense or data from a NPI perspective.
[38:18] Arjun Rattan: I am noticing a lot of unknowns on what the architecture will look like or at least I couldn't tease it out.
[38:23] Arjun Rattan: And that's more of a technical thing, what the pipeline would look like.
[38:26] Arjun Rattan: How will you integrate the pipeline? What's the first model? I think the first model will be the lift.
[38:30] Arjun Rattan: Basically you build that pipeline out for first model behaviors, etc.
[38:35] Arjun Rattan: So the PRD from my side will come into three things. One, who wants it? How does this help?
[38:42] Arjun Rattan: What needs to be done from a platform perspective?
[38:46] Arjun Rattan: And all the behaviors we've just seen, that's like v0 basic simple, because they are talking about stuff like NCAP.
[38:54] Arjun Rattan: So I'll stop here. That's where my head is at at this moment.
[38:58] Gautam Kunapuli: Sounds great. So from an AI definition standpoint.
[39:02] Arjun Rattan: Yeah.
[39:04] Gautam Kunapuli: To build good models, we need to source data and the data needs to be able to handle that definition that you come up with.
[39:17] Gautam Kunapuli: So typically when we write PRDs, there are two.
[39:19] Gautam Kunapuli: There are two components to an AI product PRD in my mind. Right.
[39:23] Gautam Kunapuli: And maybe we didn't formalize this enough over the last few years.
[39:26] Gautam Kunapuli: I've done it with Devin, but maybe not with everybody else, which is there is the AI definition.
[39:35] Gautam Kunapuli: Like what should trigger the.
[39:43] Gautam Kunapuli: The behavior event or the alert so that explicitly articulating that can become quite challenging for some of these features.
[39:51] Gautam Kunapuli: I'll give you an example of the pedestrian collision warning PRD that we are trying to build right now.
[39:57] Gautam Kunapuli: For the dashcam, you'll start running into a whole lot of corner cases.
[40:03] Gautam Kunapuli: So this was our experience when we tried to build the previous prd. Right.
[40:08] Gautam Kunapuli: So I'll show you the one that Derek Leslie, who was a product manager here before he left Motive, was working on it.
[40:19] Gautam Kunapuli: Right. So
[40:22] Arjun Rattan: is Achin's running it right from My team, Achin's running it. Pedestrian collision. No.
[40:30] Arjun Rattan: Who's your contact for pedestrian collision warning? I think it's Achin. Gupta.
[40:36] Gautam Kunapuli: It's Achin, but I'm talking about the effort that we built.
[40:41] Gautam Kunapuli: So the PRD that I shared with you was our effort from November 2024.
[40:46] Arjun Rattan: Okay.
[40:46] Gautam Kunapuli: And we built the same.
[40:47] Gautam Kunapuli: When we attempted to build the same thing, but on the current omnicad, yeah, it was called zone detection at that point.
[40:54] Gautam Kunapuli: And we were building it for a company called Republic Services who are also in garbage in the waste management space, very similar to gfl.
[41:03] Gautam Kunapuli: So GFL is not our first foray into quoting some of these waste management companies.
[41:09] Gautam Kunapuli: So there we ran into several problems around accurately defining the actual product functionality and experience.
[41:19] Gautam Kunapuli: And this is where the velocity of the project will slow down is there are so many corner cases sometimes of when it should trigger and when it should not trigger that any early discovery that we can do would be very helpful.
[41:35] Gautam Kunapuli: We won't be able to articulate all the false positive cases obviously, but anything we can do early on is great.
[41:42] Gautam Kunapuli: I'll give you a concrete example. We tried to build something for unsafe parking. Unsafe parking.
[41:49] Gautam Kunapuli: So for all of our AI features, we have very, very concrete definitions.
[41:53] Gautam Kunapuli: So what constitutes a positive example is very clear. Now we start running into corner cases.
[41:59] Gautam Kunapuli: So for unsafe parking, the definition is basically you are parked on the side of a high speed road far more than some minutes.
[42:07] Gautam Kunapuli: The minutes is irrelevant. That's just very easy to track.
[42:11] Gautam Kunapuli: The parked on the side of the road from an AI standpoint, from a computer vision standpoint is the challenge.
[42:17] Gautam Kunapuli: So now you have so many different road types determining whether something is a shoulder or not and so on and so forth.
[42:25] Gautam Kunapuli: And then at the end of the day, we were even picking up unsafe, we were even picking up vehicles sitting at like long stoplights as unsafe parking events.
[42:35] Gautam Kunapuli: So you're going to run into weird shit like this.
[42:39] Gautam Kunapuli: And I want you to be mindful of that is really all I'm trying to say.
[42:45] Arjun Rattan: Yeah, so my translation of that is you want more clarity, as you call AI definition.
[42:52] Arjun Rattan: What I call is I want clarity on the scenarios in which you want the AI to trigger.
[42:58] Arjun Rattan: I want clarity on the scenarios.
[42:59] Arjun Rattan: I mean in an ideal world, what scenarios are there that would get that we would want to apply this to?
[43:09] Arjun Rattan: And then what are. So it's like the known knowns, so discovery.
[43:13] Arjun Rattan: Can you tell me the known knowns, like what does that look like? For example, with pedestrian.
[43:20] Arjun Rattan: This one that we're going to build for AI OC plus where are you going to deploy it?
[43:25] Arjun Rattan: Which vehicle type? What is that vehicle engaged in? What is the state of the road it is in?
[43:31] Arjun Rattan: Is it in a city? Is it in a row? It is. Is it in a highway then? Because different triggers, right?
[43:37] Arjun Rattan: For example, if it's an Amazon delivery van, your trigger will be different versus I can't even imagine a truck and someone trying to cross it here.
[43:46] Arjun Rattan: But in India I can imagine it. So at what levels do you go activate. Is my takeaway correct?
[43:52] Arjun Rattan: That's what I'm reading here. Just tell me that.
[43:54] Arjun Rattan: Basically tell me the use cases, describe them clearly with your scenarios and then we will come and tell you what we can do and which use case case and tell me why this use case, or at least intuitively, this is the most high value use case to solve for.
[44:08] Gautam Kunapuli: Correct. And then here's where.
[44:11] Arjun Rattan: And then.
[44:12] Gautam Kunapuli: And then in counterpoint, where possible, if you can identify this is what isn't, it is not.
[44:23] Gautam Kunapuli: It's not always easy to write negative examples. Is my is my point. Meta point rather.
[44:29] Gautam Kunapuli: And getting those negative examples and thinking about it early, whether it's you and I or the engineers are working on the problem early on, I think will cut our dev time pretty substantially.
[44:44] Arjun Rattan: All right, how much do you think has. You say substantially.
[44:51] Arjun Rattan: So when you say substantially, I hear we can reduce it by say on a dev cycle of 245 days.
[44:59] Arjun Rattan: I can get it to like 120 days or less.
[45:02] Gautam Kunapuli: 120 depending on. Okay, so I think depending on what you mean.
[45:10] Gautam Kunapuli: If you're saying 2ga, you'll have to account for the fact.
[45:13] Arjun Rattan: Let's just say alpha. Forget ga, let's just say alpha. I'm just thinking alpha right now.
[45:17] Gautam Kunapuli: What my point really is, again, I guess one thing you should be aware of, which you probably are, but I'll reiterate is you can build everything and be ready to go and then if you push it into a GA build, it actually only hits GA two months later.
[45:37] Arjun Rattan: Yes.
[45:39] Gautam Kunapuli: So I'm just trying to. So I don't think your 120 days should account for those two months.
[45:45] Gautam Kunapuli: It should be GA ready is my point.
[45:47] Arjun Rattan: I agree with you. I don't think the definition needs to account for the rollout.
[45:51] Arjun Rattan: It needs to be, hey, I can get it out and it will work.
[45:54] Gautam Kunapuli: Correct.
[45:55] Gautam Kunapuli: And now when we talk about alpha, beta and ga, the product definition should not ideally change between the alpha beta and ga.
[46:06] Gautam Kunapuli: Any new product variations, use cases, etc that you come up with should be handled in the next version.
[46:13] Gautam Kunapuli: So if that makes sense. Right. So you say here is what pedestrian collision looks like.
[46:19] Gautam Kunapuli: Here are some use cases that I'm expecting it to handle.
[46:22] Gautam Kunapuli: And here are some use cases that are definitely false positive. Definitely should be.
[46:28] Gautam Kunapuli: Should be ignored. They should not show up as false positives.
[46:31] Gautam Kunapuli: Then we will measure our performance in alpha and in beta to get there.
[46:37] Arjun Rattan: Yeah, but Gautam, my thinking on this, and I get it, why we have a waterfall model and why Ang will insist on predictability.
[46:47] Arjun Rattan: However, I won't know what I won't know. I will try my best to put that is.
[46:53] Gautam Kunapuli: That is exactly correct. And we will have to deal with that. Don't know. What we don't know.
[46:57] Arjun Rattan: Yeah. And don't know. Don't know.
[46:59] Gautam Kunapuli: You're the nail on the head.
[47:00] Gautam Kunapuli: This is where I think as a team, product engineering shit breaks down sometimes.
[47:06] Gautam Kunapuli: Not because we're sitting there fighting with each other. We're not. We are in alignment.
[47:11] Gautam Kunapuli: What we are not aggressive about is restricting scope. In fact, we, we. That's how scope creeps.
[47:20] Gautam Kunapuli: This is the feedback that I recently.
[47:25] Gautam Kunapuli: This is what I've kind of taken away from like the last, you know, by auditing the last eight products that we have basically built so far.
[47:34] Arjun Rattan: Right.
[47:34] Gautam Kunapuli: Like this is.
[47:34] Gautam Kunapuli: This is just a personal feeling is when you run into some of these, we'll have to be judicious about which ones we do want to consider and which ones we bunt when we come to that.
[47:45] Gautam Kunapuli: And at some places the precision is so bad that we will have to consider it.
[47:49] Gautam Kunapuli: At which point we'll have to put that in the bin of bid and scope it.
[47:53] Gautam Kunapuli: Yeah, we'll have to answer the difficult question.
[47:56] Gautam Kunapuli: Was this thing we discovered something we could have identified when we first.
[48:02] Arjun Rattan: Yeah, yeah. So I will get on that. I'm just trying to build out the first version of this.
[48:07] Gautam Kunapuli: So I'll take a look at what you have as well, if you're happy to share.
[48:12] Arjun Rattan: Yeah, absolutely. I'll share this with you.
[48:14] Arjun Rattan: And I am not going to get too deep on this in the first pass.
[48:17] Arjun Rattan: My first pass is just to make sure we are all aligned on two or three things, which is, hey, this is what I'm trying to hit.
[48:22] Arjun Rattan: These are the customers who've asked for it. These are the edge case, not the edge cases.
[48:26] Arjun Rattan: These are the positive scenarios, at least that I have things.
[48:29] Arjun Rattan: And then if you align on the direction, then the TBDs will be okay. What are the negative samples?
[48:35] Arjun Rattan: What is an actual AI definition for those AI definitions? Do I have Proof points.
[48:40] Arjun Rattan: Till I have proof points, I'm not going to ask you to build anything or I'm going to tell you.
[48:44] Arjun Rattan: Look, intuitively, these two or three things make sense.
[48:48] Arjun Rattan: So for example, the reason I'm saying Amazon right now is I know we are giving pedestrian warning to Amazon.
[48:54] Arjun Rattan: So I'm like, okay, screw everything.
[48:56] Arjun Rattan: I can at least take Amazon as my mental model and I can say, hey, would they care about AIOC plus what would be the things they would care about for AIO C or what problem it would solve for them?
[49:08] Arjun Rattan: And then if nothing else, I can go test that with the Amazon sales rep and like dude, would they be interested?
[49:13] Arjun Rattan: So I can go do all of that work and give a. I got
[49:18] Gautam Kunapuli: to run here soon, right?
[49:19] Gautam Kunapuli: But there are two other things that I know Michael will ask for that I have also found incredibly helpful in order to.
[49:27] Gautam Kunapuli: So at this point all I'm doing is becoming very execution centric, right.
[49:32] Gautam Kunapuli: So I'm only worried about delivery and timelines. What is the definition of that in your mind? Right.
[49:40] Gautam Kunapuli: And we are not good historically as an engineering group of like explicitly articulating a definition of done.
[49:48] Gautam Kunapuli: So we should write that out of what that means.
[49:52] Gautam Kunapuli: And you may say, hey, that's all that's, that's not a problem, it's there in the metrics, etc.
[49:58] Gautam Kunapuli: But I must insist on clearly writing out some explicit this project is done.
[50:03] Gautam Kunapuli: When you have this thing working end to end on the edge, it should generate alerts, it should, it should work as an AI feature.
[50:11] Gautam Kunapuli: Here are some expectations around its performance.
[50:14] Gautam Kunapuli: Here are some rough precision recall numbers or basic targets.
[50:17] Gautam Kunapuli: They should be achievable, which we will probably figure out during discovery as well.
[50:22] Gautam Kunapuli: And we may need to iterate upon it. Right?
[50:24] Gautam Kunapuli: So that kind of definition of done, I think we haven't formalized it. We should hand wave that less.
[50:34] Arjun Rattan: Oh, interesting.
[50:36] Arjun Rattan: I'm trying to think about when I guess it's a little different in a B2B context because when I worked in B2C the definition of done was essentially you went and ran an experiment at the end with whatever you were trying to do with that system.
[50:57] Arjun Rattan: And I won't say it was a definition of that. Nothing was ever done. You always had V2.
[51:01] Arjun Rattan: Okay, I heard your thing that makes sense.
[51:04] Gautam Kunapuli: I mean the project never ends.
[51:06] Arjun Rattan: Right?
[51:06] Gautam Kunapuli: Like I fully understand. But.
[51:08] Gautam Kunapuli: But to me if it's done, then it's done and when we pick it up again it is still pedestrian collision warning in the Omnicam AIOC plus but it's now v2, and then it'll be v3, and then it'll be v4, etc.
[51:24] Arjun Rattan: That way.
[51:25] Gautam Kunapuli: Each of these is nicely gated behind a version number with a limited scope.
[51:31] Gautam Kunapuli: That is something we did not do well for. Fatigue index, for example.
[51:35] Gautam Kunapuli: It's going to be an awesome feature, but we just had such an ambitious scope and we just picked off so much more that even now I get so much grief from everybody.
[51:45] Gautam Kunapuli: You haven't launched it. It's been 19 months. You are just launching it now. Is that anybody's fault?
[51:51] Gautam Kunapuli: Yeah, I think it's, it's my fault. I think we didn't break the problem down into. Yeah, whatever.
[51:57] Gautam Kunapuli: Like you get the idea, right?
[51:58] Arjun Rattan: So I get the idea. And last you said there was one more, you wanted to give me a call out, correct?
[52:06] Gautam Kunapuli: When we come to sequencing, I know for a fact that we are awful at this at times, not always, but
[52:18] Arjun Rattan: getting involved in sequencing with you guys.
[52:21] Gautam Kunapuli: Will you be getting involved in sequencing? You will, right?
[52:24] Arjun Rattan: Oh, interesting.
[52:26] Arjun Rattan: Not that I haven't gotten involved, it's just I would imagine that at a, at a prioritization level, once the initiative is mapped out and it has been signed off, like, hey, these are the six projects we're going to go work on.
[52:40] Gautam Kunapuli: No, I meant, I meant sequencing of the epics within this.
[52:45] Gautam Kunapuli: You are saying go build pedestrian collision warning on AIOC plus and then there will be four teams that will build four different pieces.
[52:54] Gautam Kunapuli: There's going to be a model team that's going to build a neural network model.
[52:59] Gautam Kunapuli: There's going to be a state machine team that's going to build the state machines and configurations around it and deploy it.
[53:04] Gautam Kunapuli: There's going to be a backend team that is going to build the backend pipeline to eat the metadata and then process it, to consume the metadata and process it.
[53:14] Gautam Kunapuli: And then there may be an annotation tool team that has to go and work on.
[53:18] Gautam Kunapuli: You see, there are, there are.
[53:19] Arjun Rattan: Yeah, no, I understand the layers.
[53:23] Gautam Kunapuli: That's the sequencing that I'm talking about, the sequencing of the project itself.
[53:26] Gautam Kunapuli: Once we have allocation. So where do we fall down?
[53:30] Gautam Kunapuli: Typically is we don't always operate under the principle of, hey, let's just assume that the AI team is going to build some model, put some hooks in place and be ready to consume an event when they generate it.
[53:47] Gautam Kunapuli: That is the place we need to be at. Lane swerving is a great example of this.
[53:54] Gautam Kunapuli: Drowsiness is also a great example of this where some of the more complex back end components are Only now being built even though the AI itself was already the AI models.
[54:08] Arjun Rattan: Yeah, I understood. Scaffolding is an issue. All right.
[54:10] Gautam Kunapuli: Scaffolding is an issue. Okay. Again, these are all very fixable.
[54:15] Gautam Kunapuli: I'm just calling them out because these are the things that I'm that are top of mind right now.
[54:20] Gautam Kunapuli: So that we are much better in 2026 than we are in 2025.
[54:24] Gautam Kunapuli: Because I'm tired of going into every MBR and answering and getting the same question from him every time.
[54:29] Gautam Kunapuli: Or from Amish. Why does it take you six months to build a product? Why is this still not in ga?
[54:34] Gautam Kunapuli: And of course there is.
[54:36] Arjun Rattan: Why aren't they beating product on it? I'm guessing they also ask Nihar the same question.
[54:42] Gautam Kunapuli: Yeah, it's. It's. You and I are going to be in the soup here. I know, right?
[54:47] Gautam Kunapuli: So Nihar was in the soup and then he extricated himself.
[54:51] Arjun Rattan: I just want to make sure product is in the soup too.
[54:54] Gautam Kunapuli: Yeah, that's his product. Right.
[54:56] Gautam Kunapuli: So Nihar is in the soup and I'm the one that became the owner of reporting on the velocity and doing the analysis, etc.
[55:03] Gautam Kunapuli: Which. This is what it concludes.
[55:05] Gautam Kunapuli: So if you look at the February MBR at the bottom, you will see an analysis on product velocity.
[55:12] Arjun Rattan: So take a look on this like, is it a. Is it a senior pm? Okay, I'm going to stop recording for a sec.
[55:21] Arjun Rattan: Give me one sec. I don't want to talk about this
[55:23] Gautam Kunapuli: with the note on.
[55:25] Arjun Rattan: Let's see how do you. Okay, Arjuns, if I just kick it out, it is still.
[55:30] Gautam Kunapuli: Yeah, no, you can throw it out.
[55:33] Arjun Rattan: Okay.
[55:33] Gautam Kunapuli: That's what I do.
[55:35] Arjun Rattan: It'll retain the rest of the recording, right? It won't lose it. Okay. Because I had good stuff here.
[55:39] Arjun Rattan: Okay, Block, just remove.