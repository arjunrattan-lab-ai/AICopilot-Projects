## Comments By Person


Safety MBR March 2026 — All Comments by Person
👤 Hemant Banavar
(Already extracted in full — see earlier in our conversation)

Topic	Comment
Live streaming 85%	"also, are we now able to support live streaming multicast? thats a txdot requirement right?"
AIDC+ parity messaging	"whats the messaging to the field... it needs to be that AIDC+ is at full parity with AIDC by end of H1?"
Enhanced telematics gap	"can you say more? our safety telematics coverage overall is still pretty low right? cc @john.choi"
Cloud ALPR	👏 reaction
Speed Sign Detection delayed	"how can we ship this faster? also is there a platform where this can ship faster? AIDC+?"
Custom Event Tags delayed	"why is this delayed? this was locked and ready a while ago."
Visualizations 2.0 agentic workflow	"what does this mean?"
Passenger Detection	"GA?"
Two Way Call in Safety P0 list	"why is this project here? this should be in ai platform no?"
Provision/Birdseye delay	"does this impact customer commits?"
P0 Projects / AIOC+	"can we discuss AIOC+ models? we should create a plan for what we are going to launch it with and start work in parallel - ped detection"
Redash access restriction	"can we revert this and then comeback and whiteboard a plan here @amish.babu -- this is causing problems across all teams"
Events v3 missing from project list	"why is this not in your project list above?"



👤 Shoaib Makani
Topic	Comment
Live streaming 85%	"still too low?"
AI Pipeline Revamp	"great to see us investing for the long run here. thank you team who are working on this one."
Collision AI Annotator	"+1. just awesome to see how quickly you all moved here. what is the % bypassed?"
Eating AI	🙏 reaction
Cloud ALPR	"this was a good example of idea to final design execution. we need to compress design cycle time across the board."
Two Way Call — audio quality	"what are we doing to improve audio quality? what can be done?"
Two Way Call — volume	"what is the volume setting based on? can we set it to 100% for the call always?"
Fatigue Index AIDC+ Jun 30	"any way to pull this in?"
Unsafe Parking precision (mid 90s)	"if we can get this into mid 90s we should start doing in-cab alerting on it?"
AI Automations for events	"at minimum we need to get AI Automations enabled to deliver message or have AI Coach reach out to driver for validated events."
GNARR losses	"i would add sonepar here. they cited missed accident as the reason for not choosing Motive."
AIDC+ high severity collision count	"we have only had 36 high severity collisions on AIDC+ lifetime? that seems impossibly low."
EVE rollout timeline	"this is going to change in a big way once EVE is rolled out for all events? what is timeline for that?"



👤 Amish Babu
Topic	Comment
Collision AI Annotator	"Incredible effort by team here."
Unit Test Coverage	"Thank you."
AI roadmap slips / tradeoffs	"Need to do a better job here on tradeoffs. this remains a key issue. AI Annotator, hey motive, 2 way calling all has some tradeoff. We need a constant roadmap view and how its changing."
Enhanced telematics gap	"It shows we have a testing / dogfooding gap in general? No one noticed this for months? (Including myself)"
E2E collision latency	"can we track this on the AI annotator cohort?"
Edge ALPR	"I'm still a bit confused why edge ALPR is hard/taking a lot of time. Bounding box → Run OCR → embed in video. I dont think we need to worry about precision to begin with. it's just odd to me that we need to do this step. @hareesh.kolluru"
Collision recall AIDC+	"is this real? AIDC+ stats are better than AIDC?"



👤 Nihar Gupta
Topic	Comment
Live streaming Q2 improvements	"@anandh.chellamuthu more improvements coming in Q2?"
AIDC+ parity messaging (reply to Hemant)	"We've been communicating this to the field pretty well on timelines for these features and any slips. I think we will be 99% at parity but some items are still 2H."
Custom Event Tags (reply to Hemant)	"We had multiple discussions on VLM / tags strategy that spanned much of Q1 so unfortunately the scope was not locked until March. We will move quickly now."
Visualizations 2.0	Tagged @michael.benisch
Edge ALPR	"The ask was to deliver this very quickly and cloud based ofc was the fastest path. + @gautam.kunapuli"
AIDC+ model dates	"let's discuss"
Two Way Call	"This creates confusion, so yes, lets just move out of safety P0 list in April."
Provision MX dates	"@baha-eldin.elkorashy can we add this? cc @marc.ische who will be taking over ownership."
Events v3 (reply to Hemant)	"We will add in the next one."
Vision-based Speeding	"@avinash.devulapalli can guide on this. Probably best to get a primer on all of our AI features. @arjun.rattan is also coming up to speed on this."
GNARR losses	"we should add to appendix moving forward along with churn customers / reason" + "@danyyal.khalid can you share loss reasons here?"
Enhanced telematics (reply)	"I think we were getting the signals but they weren't making it to the cloud, which is part of the fix"
E2E latency	"probably should have a view of both, which should be easy to produce."
Collision annotator bypass	"Yup, let's do a quick voice over"
EVE rollout	"Yes it will. We need to properly plan this for Q2 since it is an 'unplanned' project. + @michael.benisch @arshdeep.kaur @arjun.rattan"



👤 Marc Ische
Topic	Comment
Live streaming metric denominator	"Is denominator all attempts whether device had any connectivity or not? Or limited to times device had enough connectivity to be providing state info?"
1-to-multiple livestreaming	"Is this cloud fan-out to multiple viewers...or device sending multiple streams?"
Eating AI	"Is it 'eating' or 'anything to mouth' like food & drink...or will it catch me biting my nails." + "Good to know no nailbiting coaching conversations triggered when my wife isn't in the vehicle with me."
Unsafe Lane Change precision	"Curious about this one as well, best doc to understand it. Vision only, or any maps? Challenges with different sign types, or 'not for me' signs."
Vision-based Speeding	"Curious, pointer to best doc of what this covers? Speed sign applicability to vehicle class, legal vs. warning signs, etc."
Collision recall AIDC+ calibration	"Curious about calibration approach today? self-cal or anything in install app? Time/driving scenario needed to calibrate and start producing the alerts?"



👤 Chandra Rathina
Topic	Comment
Live streaming denominator	"Yes based on state info"
Live streaming improvements	"Yes, we need to refine this metric... bad camera status like disconnected state was still allowed to start stream, this is getting fixed and will see 5% boost. Most other issues are around device picking the jobs. Will share more details. cc @m.bilal"
1-to-multiple livestreaming	"cloud fan-out"
Collision annotator	"cc @ans.zafar"
E2E latency reporting	"We stopped reporting end to end latency for false positives, we can bring back." + "ok to report, but i want to make sure we have all our focus on true positives."
Churn appendix	"Its in Appendix A.2"
Enhanced telematics	"cc @devin.smith @umair.tajammul"
AEP compliance	➕ reaction



👤 Michael Benisch
Topic	Comment
Collision AI Annotator bypass	"We are currently running the system with 60% bypass while catching 99% of collisions and 90+% of near collisions. We have plans to increase the bypass significantly more but want to first get the whole system running with this very low risk version before cranking it up."
Visualizations 2.0 (reply to Hemant)	"We are lacking resources to pick this up so we're going to try to utilize an agentic workflow that we discussed yesterday to leverages very little of the engineers time."
EVE rollout	"By end of March we will have EVE effectively rolled out across all behaviors (AI + collisions) and all customers other than trials... for certain types of events like collisions, EVE actually adds latency for the majority of cases because those will first be processed by EVE and then sent to annotators."



👤 Naveen Krishnamurthy
Topic	Comment
AIDC+ feature dates	"We need to reevaluate these dates on AIDC+ considering the beta and GA train scheduled releases."
Alpha/beta criteria for AIDC+	"We need to consider the new proposal we made in CD MBR to adopt a rigorous alpha/beta criteria before we GA the feature. This is particularly relevant for all net new AI features on AIDC+. We can leverage beta train for AI tiger team builds."
Video upload prioritization	"Does it work on AIDC+ too?"



👤 Gautam Kunapuli
Topic	Comment
Edge ALPR	"We have a model ready to go and there is no AI work being done to deliver ALPR, just the E2E pipeline."
Fatigue AIDC+ date	"This will be pretty tough. We are now simultaneously juggling 3 different priorities for AIDC+: parity with AIDC, net new AIDC+ only features (rapidly growing list: ALPR, Hey Motive, Second Passenger Detection) and UK/EU."
AI Automations for unsafe parking	"Yes, this will likely be added to AI Automations in April/May for bypass."



👤 Avinash Devulapalli
Topic	Comment
Speed Sign Detection (reply to Hemant)	"We carved out a beta build already for beta testing w/ customers by 28-Apr. AIDC+ dev work has not even started due to other higher priority models."
E2E latency	"+1 to Chandra's point. But when TPs are going through AI annotator, we are adding a latency of p50: 6s, p80: 9s, p90: 13s."
Vision-based Speeding detail	"Beta 1 plan is for Regular speed sign detection (legal) and Beta 2 planned for Truck speed sign detection. Both phases will not detect Advisory signs."
IMU shortage	"Yes aware about this. Added the point."



👤 Alexa Witowski
Topic	Comment
Passenger Detection	"I don't think I ever saw the PRD or designs for this. Can you please share access? Want to make sure I'm giving any input required given this is for MX." + tagged Ling Lee and Leni Zneimer for intl roadmap
OC Livestream	"can we make sure we Beta in MX to check cell coverage and/or the need for low-bitrate enhancements like we had to put in for AIDC in MX? OC live stream will be big for security in MX."
Fatigue Index	"Can we get Beta running in MX too? This feature will be huge there."
Speed Sign Detection	"Can we get Beta running in MX too?"
GDPR blurring	"Thank you for the hustle here @arshdeep.kaur and team in burning this down."



👤 Sean Santschi
Topic	Comment
Two Way Call ownership	"This is a bit messy for the time being until its GA'd. PM owner is Nikhil (connected devices), Eng Owner is Veer (Safety), Comms SKU owned by Brett (AI Platform). What I would prefer to do after it is GA'd is move this to AI platform team 100%, and do proper knowledge transfer on eng side."



👤 Yuvaraj Thiagarajan
Topic	Comment
Two Way Call long-term	"Yes. We need to have plan for transitioning off to communications pod (AI platform) on long run."



👤 Hareesh Kolluru
Topic	Comment
Edge ALPR	"On AIDC+, running another model (OCR) is something we need to do more through testing as we ran into frame loss issue. Our plan is to work on it after Fatigue and target to have code complete by end of May. 2 months in QA release train gets to end of July."



👤 Jeffrey Kalmikoff
Topic	Comment
Edge ALPR UX	"UX POV: The precision is necessary for a high confidence read of the plate to display in the UI of collision event detail page. The feature unburdens the organization from manually zooming into videos to look for license plates."
P0 Projects header	"for visibility, Katrina Zawojski is the Content Designer (fka UX Writer) for all Safety projects."



👤 Umair Tajammul
Topic	Comment
Livestreaming button	"Live streaming button does not show to the customer, if device is not connected."
Enhanced telematics gap	"The gap was more basic. We were not sending available signals with the safety events." + "It was supported for harsh events (covered by defect) but the signals were for collision and AI events."



👤 Muhammad Bilal
Topic	Comment
Livestreaming button correction	"A correction. The button does show but it displays a red dot if disconnected and green if connected. We do incorporate the connection status when calculating this metrics denominator."



👤 Prashant Ramarao
Topic	Comment
Redash access (reply to Hemant)	"We need to work with security to align on this. Redash (an open source tool) is not really capable of supporting our needs. cc: @jiphun.satapathy @hoshedar.mana"
AEP poly-repo compliance	"this is the first I've heard compliance is driving how code is organized? Lets follow-up."



👤 David Sanford
Topic	Comment
Collision recall AIDC+ sample size	"For high severity, the sample size is too low to say. Right now it's 36/36, and statistically that's a completely reasonable result for anything from 92%–100% underlying recall."
AIDC+ trial thresholds effect	"Also note that we're effectively running AIDC+ on trial thresholds, with ~5x the per-vehicle volume, so that would be expected to up the recall ~1–3%."
High severity collision count rationale	Full statistical breakdown — 1 collision per 10 vehicles/year, 10% high severity, ~14k active devices since Jan 1



👤 Zainab Qureshi
Topic	Comment
Enhanced telematics gap	"we generally don't get telematics signals on the vehicles we test on in PK so it might not be clearly noticed... There was an initial bug logged by QA in 2025." + "some work on the edge was also required in some event types."



👤 Joe Pulver
Topic	Comment
Harsh Event Precision AIDC+	"IMU shortage, we need to train models for a new IMU. current IMU stock is exhausted early June."



👤 Devin Smith
Topic	Comment
Fatigue Index GA	"it will be on v58 also for GA"
Unsafe Parking incab alerts	"we have incab alerts coming for unsafe parking as a feature update... We should have an Unsafe Parking alert available by end of Q2."
Lane Swerving incab alerts	"we will also launch Lane Swerving incab alerts after v58 rollout now that we will have 90%+ precision."



👤 Muhammad Talha
Topic	Comment
AI annotator latency	"The AI annotator latency (P90) is ~13 secs."
Latency dashboard	"The dashboard has a granular view at the bottom."



👤 Achin Gupta
Topic	Comment
Eating AI	"It detects solid food items only." + 😀 reaction on Marc's nailbiting joke



👤 Amy Loh
Topic	Comment
GNARR losses	"Any notes on the loss reasons?"



👤 Danyyal Ahmed Khalid (DAK)
Topic	Comment
GNARR churn appendix	"They're not in Appendix A.2 because they're not safety-driven losses, rather general churn accounts impacting Safety ARR."



👤 Baha Elkorashy
Topic	Comment
Provision customer commits (reply to Hemant)	"It may impact Landmark, depending on when that deal is expected to close. Though if we do hit the mid-May timeline, we should be able to make it. Looking into Artera now."
Provision MX tracking	"Yes, it is currently being tracked / managed by Ted Jao, but I can loop in updates and begin KT with Marc soon."



👤 Dhiraj Bathija
Topic	Comment
AEP compliance reference	Linked the internal Slack thread with Paul on compliance driving code organization



👤 Syed Adnan
Topic	Comment
AIDC+ high severity collision count	"Yes, the device count started at around 1000 active devices in July 2025 and has gradually increased. Over the past 9 months since rollout, the average is about 6000 devices per year, and 36 devices in 9 months falls within the expected range."



👤 Ling Lee
Topic	Comment
OC Livestream MX	"This is being tracked on the PMM launch calendar, making note that this is huge for security in Mexico cc @todd.bledsoe"
Passenger Detection MX	👍 reaction



👤 Leni Zneimer
Topic	Comment
OC Livestream MX	"started a slack thread @baha-eldin.elkorashy"



👤 Naveen Krishnamurthy (additional)
Topic	Comment
CAN vehicle activity detection	Flagged in AIDC+ issues thread — concerted effort needed between Telematics and VIA team



👤 Arjun Rattan (you)
Topic	Comment
EVE rollout (tagged by Nihar)	👍 reaction



Quick Summary by Volume
Person	# of Comments	Primary Focus
Nihar Gupta	~15	Responses, clarifications, tagging
Shoaib Makani	~13	Strategic questions + praise
Hemant Banavar	~13	Gaps, delays, customer impact
Amish Babu	~8	Tradeoffs, testing gaps, data
Marc Ische	~6	Definitional/educational questions
Chandra Rathina	~6	Technical clarifications
Avinash Devulapalli	~5	Feature detail + timelines
Alexa Witowski	~5	MX/International coverage
Michael Benisch	~3	AI Annotator depth



Would you like me to do the same for the Support MBR, or cross-reference both to find which topics drew the most cross-functional engagement?




## Comments By Thread
Claude Sonnet 4.6
organize by topics the comments including repsosnes by , so quesitosn asked and rhen resposne chains




Show work
Safety MBR March 2026 — Comments Organized by Topic & Thread
THREAD 1: Live Streaming — Metrics, Multicast & TxDOT
Line item: Live streaming connection success improved to 85% from 70%

Marc Ische: "Is denominator all attempts whether device had any connectivity or not? Or limited to times device had enough connectivity to be providing state info?"
→ Chandra Rathina: "Yes based on state info"
→ Umair Tajammul: "Live streaming button does not show to the customer, if device is not connected."
→ Muhammad Bilal: "A correction. The button does show but it displays a red dot if disconnected and green if connected. We do incorporate the connection status when calculating this metrics denominator."

Shoaib Makani: "still too low?"
→ Nihar Gupta: "@anandh.chellamuthu more improvements coming in Q2?"
→ Chandra Rathina: "Yes, we need to refine this metric... bad camera status like disconnected state was still allowed to start stream, getting fixed, will see 5% boost. Most other issues are around device picking the jobs. Will share more details."

Hemant Banavar: "also, are we now able to support live streaming multicast? thats a txdot requirement right?"
→ (No response captured in doc)

THREAD 2: 1-to-Multiple Livestreaming (2H'26)
Line item: "Live streaming - 1 to multiple viewers (2H'26)"

Marc Ische: "Is this cloud fan-out to multiple viewers...or device sending multiple streams?"
→ Chandra Rathina: "cloud fan-out"
→ Anandh Chellamuthu: "device sends only 1 stream"

THREAD 3: AIDC+ Parity — Field Messaging
Line item: Remaining parity items list

Hemant Banavar: "whats the messaging to the field on this @nihar.gupta — it needs to be that AIDC+ is at full parity with AIDC by end of H1?"
→ Nihar Gupta: "We've been communicating this to the field pretty well on timelines for these features and any slips. I think we will be 99% at parity but some items are still 2H as you can see on bottom of bulleted list."

THREAD 4: Enhanced Telematics Gap on AIDC+
Line item: "Enhanced telematics on AIDC+ was a missed gap to the AIDC experience"

Hemant Banavar: "can you say more? our safety telematics coverage overall is still pretty low right? cc @john.choi"
→ Umair Tajammul: "The gap was more basic. We were not sending available signals with the safety events."
→ Nihar Gupta: "I think we were getting the signals but they weren't making it to the cloud, which is part of the fix. These are the advanced telematics we have at the bottom of every Safety event."
→ Zainab Qureshi: "some work on the edge was also required in some event types." + "we generally don't get telematics signals on the vehicles we test on in PK so it might not be clearly noticed. There was an initial bug logged by QA in 2025."
→ Umair Tajammul: "It was supported for harsh events (covered by defect) but the signals were for collision and AI events."

Amish Babu: "It shows we have a testing / dogfooding gap in general? No one noticed this for months? (Including myself)"
→ Chandra Rathina: "cc @devin.smith @umair.tajammul"

THREAD 5: Cloud ALPR — On Track for 4/30
Line item: "Cloud ALPR on track for 4/30 despite a late start in Q1"

Hemant Banavar: 👏 reaction
Shoaib Makani: "this was a good example of idea to final design execution. we need to compress design cycle time across the board."
→ Chandra Rathina: ➕ reaction

THREAD 6: Edge ALPR — Why Is It Hard?
Line item: AIDC+ ALPR (Cloud Based) section

Amish Babu: "I'm still a bit confused why edge ALPR is hard/taking a lot of time. Bounding box → Run OCR → embed in video. I dont think we need to worry about precision to begin with. it's just odd to me that we need to do this step. @hareesh.kolluru"
→ Nihar Gupta: "The ask was to deliver this very quickly and cloud based ofc was the fastest path. + @gautam.kunapuli"
→ Hareesh Kolluru: "On AIDC+, running another model (OCR) is something we need to do more through testing as we ran into frame loss issue. Our plan is to work on it after Fatigue and target to have code complete by end of May. 2 months in QA release train gets to end of July."
→ Gautam Kunapuli: "We have a model ready to go and there is no AI work being done to deliver ALPR, just the E2E pipeline."
→ Jeffrey Kalmikoff: "UX POV: The precision is necessary for a high confidence read of the plate to display in the UI of collision event detail page. The feature unburdens the organization from manually zooming into videos to look for license plates."

THREAD 7: Speed Sign Detection — Shipping Faster
Line item: AI Speed Sign Detection — Delayed (Beta moved from Mar 31 → Apr 28)

Hemant Banavar: "how can we ship this faster? also is there a platform where this can ship faster? AIDC+?"
→ Avinash Devulapalli: "We carved out a beta build already for beta testing w/ customers by 28-Apr. AIDC+ dev work has not even started due to other higher priority models to be shipped."
→ Abbas Sheikh: "Apr 28"
→ Nihar Gupta: "Yup, more details below. Start with events only, fast follow with alerts. This is just AIDC, AIDC+ will be ready later in Q2."
→ Devin Smith: "it will be on v58 also for GA"
→ Alexa Witowski: "Can we get Beta running in MX too? This feature will be huge there, we should be collecting feedback from that market early."

Marc Ische: "Curious, pointer to best doc of what this covers? Speed sign applicability to vehicle class (truck, w/trailer, etc.), legal vs. warning (yellow signs), etc."
→ Nihar Gupta: "@avinash.devulapalli can guide on this. Probably best to get a primer on all of our AI features. @arjun.rattan is also coming up to speed on this. @devin.smith and I can help."
→ Avinash Devulapalli: "Beta 1 plan is for Regular speed sign detection (legal) and Beta 2 planned for Truck speed sign detection (legal). Both phases will not detect Advisory signs. In future phases we plan for dynamic speed signs — Timeline TBD."

THREAD 8: Custom Event Tags — Why Delayed
Line item: Beta delayed from Apr 15 → TBD by EoM; GA from May 5 → TBD

Hemant Banavar: "why is this delayed? this was locked and ready a while ago."
→ Nihar Gupta: "We had multiple discussions on VLM / tags strategy that spanned much of Q1 so unfortunately the scope was not locked until March. We will move quickly now."

THREAD 9: Visualizations 2.0 — Agentic Workflow
Line item: "Agentic workflow options being explored utilizing previous discovery & PRD inputs" — Blocked

Hemant Banavar: "what does this mean?"
→ Nihar Gupta: tagged @michael.benisch
→ Michael Benisch: "We are lacking resources to pick this up so we're going to try to utilize an agentic workflow that we discussed yesterday to leverages very little of the engineers time and make progress on the project."

THREAD 10: Passenger Detection — Missing GA Date
Line item: Beta: Jun 30, 2026 (AIDC+ only)

Hemant Banavar: "GA?"
→ Alexa Witowski: "@anandh.chellamuthu I don't think I ever saw the PRD or designs for this. Can you please share access? Want to make sure I'm giving any input required given this is for MX."
→ Alexa Witowski: "@lingjun.lee @leni.zneimer this is another one we need to make sure we are tracking on the intl releases roadmap for MX."
→ Ling Lee: 👍 reaction
→ (GA date not answered in doc)

THREAD 11: Two Way Call — Should It Be in Safety P0?
Line item: AIDC+ Two Way Call in Safety P0 project list

Hemant Banavar: "why is this project here? this should be in ai platform no? @sean.santschi @nihar.gupta"
→ Chandra Rathina: "This is two way calling, not heymotive. The Eng work is done by Safety Team & Emb."
→ Chandra Rathina: "And the quality & success rate looks good from early results, we are running PoCs to leverage agora for livestreaming as well (esp TxDoT use case)."
→ Sean Santschi: "This is a bit messy for the time being until its GA'd. PM owner is Nikhil (connected devices team), Eng Owner is Veer (Safety Team), Comms SKU which includes 2WC as the core feature is owned by Brett (AI Platform). What I would prefer to do after it is GA'd and successful is move this to AI platform team 100%, and do proper knowledge transfer on eng side."
→ Yuvaraj Thiagarajan: "Yes. We need to have plan for transitioning off to communications pod (AI platform) on long run."
→ Nihar Gupta: "This creates confusion, so yes, lets just move out of safety P0 list in April."

Shoaib Makani: "what are we doing to improve audio quality? what can be done?"
→ (No specific response captured)

Shoaib Makani: "what is the volume setting based on? can we set it to 100% for the call always?"
→ (No specific response captured)

THREAD 12: Provision / Birdseye AI — Customer Commits
Line item: Birdseye AI DVR delayed to mid-May

Hemant Banavar: "does this impact customer commits @nihar.gupta"
→ Nihar Gupta: "@baha-eldin.elkorashy can you chime in"
→ Baha Elkorashy: "It may impact Landmark, depending on when that deal is expected to close. Though if we do hit the mid-May timeline, we should be able to make it. Looking into Artera now to double check."

Alexa Witowski: "Can we please get vis into the MX dates here?"
→ Nihar Gupta: "@baha-eldin.elkorashy can we add this? cc @marc.ische who will be taking over ownership. Is this called out in your tracker?"
→ Baha Elkorashy: "Yes, it is currently being tracked / managed by Ted Jao, but I can loop in updates and begin KT with Marc soon."

THREAD 13: OC Livestream — Mexico & International
Line item: AI Omnicam Livestream Beta: April 8

Alexa Witowski: "can we make sure we Beta in MX to check cell coverage and/or the need for low-bitrate enhancements like we had to put in for AIDC in MX? OC live stream will be big for security in MX."
→ Baha Elkorashy: "For sure, I'm gathering info on interested accounts in the interest tracker, and have been posting in SE channels. Lmk if there's a specific channel."
→ Leni Zneimer: "started a slack thread @baha-eldin.elkorashy"
→ Ling Lee: "This is being tracked on the PMM launch calendar, making note that this is huge for security in Mexico cc @todd.bledsoe"

THREAD 14: AIOC+ Models — P0 Plan
Line item: P0 Projects (H1 2026) header

Hemant Banavar: "can we discuss AIOC+ models? we should create a plan for what we are going to launch it with and start work in parallel — ped detection"
→ (Seeded the live MBR discussion — no written response chain in doc)

THREAD 15: Redash / Data Access Restriction
Line item: "Redash warehouse access is now restricted based on individual PIAM permissions... prevents sharing a common dashboard across Safety, AI, and Product"

Hemant Banavar: "can we revert this and then comeback and whiteboard a plan here @amish.babu — this is causing problems across all teams"
→ Prashant Ramarao: "We need to work with security to align on this. Redash (an open source tool) is not really capable of supporting our needs. cc: @jiphun.satapathy @hoshedar.mana"

Prashant Ramarao: "this is the first I've heard compliance is driving how code is organized? Lets follow-up."
→ Chandra Rathina: ➕ reaction
→ Dhiraj Bathija: (linked internal Slack thread with Paul on the compliance discussion)

THREAD 16: Events v3 — Not in Project List
Line item: "Events v3 — prioritized key enhancements... requires significant backend/database investment"

Hemant Banavar: "why is this not in your project list above?"
→ Nihar Gupta: "We will add in the next one."

THREAD 17: Collision AI Annotator — Bypass Rates
Line item: "Collision AI annotator now automates most collision video review... rollout at 100% SMB & MM"

Amish Babu: "Incredible effort by team here."
Shoaib Makani: "+1. just awesome to see how quickly you all moved here. what is the % bypassed?"
→ Chandra Rathina: "cc @ans.zafar"
→ Michael Benisch: "We are currently running the system with 60% bypass while catching 99% of collisions and 90+% of near collisions. We have plans to increase the bypass significantly more but want to first get the whole system running with this very low risk version before cranking it up. We can dive into more details live."
→ Nihar Gupta: "Yup, let's do a quick voice over."

THREAD 18: E2E Collision Latency — AI Annotator Cohort
Line item: p50 ~3:04 min, P80 ~4:43 min, p90 ~6:23 min

Amish Babu: "can we track this on the AI annotator cohort?"
→ Chandra Rathina: "We stopped reporting end to end latency for false positives, we can bring back. Today AI annotator pushes to HITL if the confidence is high and this is inclusive of those AI model+LLM calls."
→ Muhammad Talha: "The AI annotator latency (P90) is ~13 secs."
→ Amish Babu: 👍🏽 reaction
→ Nihar Gupta: "probably should have a view of both, which should be easy to produce. Same thing @dhiraj.bathija we discussed for AI events."
→ Chandra Rathina: "ok to report, but i want to make sure we have all our focus on true positives and not divert from that."
→ Muhammad Talha: "The dashboard has a granular view at the bottom."
→ Avinash Devulapalli: "+1 to Chandra's point. But when TPs are going through AI annotator, we are adding a latency of p50: 6s, p80: 9s, p90: 13s. That is inclusive in these metrics atm."
→ Nihar Gupta: "I think Amish's question is not about TP vs FP, but the reduction in time from avoiding annotations. TPs is what we care about."
→ Chandra Rathina: "discuss"

THREAD 19: Collision Recall AIDC+ — Sample Size & Trial Thresholds
Line item: High Severity: 36/36, Low Severity: 89%

Amish Babu: "is this real? AIDC+ stats are better than AIDC?"
→ David Sanford: "For high severity, the sample size is too low to say. Right now it's 36/36, and statistically that's a completely reasonable result for anything from 92%–100% underlying recall. Likewise for low-severity, this is consistent with 85–93% recall."
→ David Sanford: "Also note that we're effectively running AIDC+ on trial thresholds, with ~5x the per-vehicle volume, so that would be expected to up the recall ~1–3%."

Shoaib Makani: "we have only had 36 high severity collisions on AIDC+ lifetime? that seems impossibly low."
→ David Sanford: "I don't know the current AIDC+ vehicle count, but historically we've had a bit under 1 collision per 10 vehicles per year, and ~10% of those are high severity. So 36 high-severity collisions is about what we should expect from 3600 vehicles operating for a year."
→ David Sanford: "I'm seeing ~14k unique devices having produced dpe events since Jan 1, which is a decent proxy for activity. Recent daily activity is ~7–8k."
→ Syed Adnan: "Yes, the device count started at around 1000 active devices in July 2025 and has gradually increased. Over the past 9 months, the average is about 6000 devices per year, and 36 devices in 9 months falls within the expected range."

Marc Ische: "Curious about calibration approach today? self-cal or anything in install app? Time/driving scenario needed to calibrate and start producing the alerts?"
→ Avinash Devulapalli: "cc @adnan.hassan"

THREAD 20: Fatigue Index — Pull in AIDC+ Date
Line item: Fatigue: AIDC Apr 29, 2026, AIDC+ Jun 30, 2026

Shoaib Makani: "any way to pull this in?"
→ Gautam Kunapuli: "This will be pretty tough. We are now at a stage where we are simultaneously juggling 3 different priorities for AIDC+: parity with AIDC, net new AIDC+ only features (this is a rapidly growing list: ALPR, Hey Motive, Second Passenger Detection) and UK/EU."
→ Naveen Krishnamurthy: "We need to consider the new proposal we made in CD MBR to adopt a rigorous alpha/beta criteria before we GA the feature. This is particularly relevant for all net new AI features on AIDC+. We can leverage beta train for AI tiger team builds."
→ Nihar Gupta: "this might be worth discussing here at a high-level, and doing a deep dive separately."

Naveen Krishnamurthy: "We need to reevaluate these dates on AIDC+ considering the beta and GA train scheduled releases."
→ Gautam Kunapuli: "These are aligned to the release schedules in the latest AIDC+ release plan." (linked spreadsheet)
→ Nihar Gupta: "let's discuss"

THREAD 21: Fatigue Index Beta Launch 🔥
Line item: "BETA IS LIVE! Enabled DFI on Motive Internal & 5 Customers on 3/13"

Amish Babu, Gautam Kunapuli, Chandra Rathina, Jeffrey Kalmikoff, Avinash Devulapalli: 🔥🔥🔥🔥🔥 reactions

Shoaib Makani: "at minimum we need to get AI Automations enabled to deliver message or have AI Coach reach out to driver for validated events."
→ Gautam Kunapuli: "Yes, this will likely be added to AI Automations in April/May for bypass."
→ Devin Smith: "we have incab alerts coming for unsafe parking as a feature update... We should have an Unsafe Parking alert available by end of Q2."
→ Devin Smith: "we will also launch Lane Swerving incab alerts after v58 rollout now that we will have 90%+ precision."

Naveen Krishnamurthy: "is the metrics looking good on v55020 customers? When we plan to GA this feature?"
→ Abbas Sheikh: "Apr 28"
→ Nihar Gupta: "Yup, more details below. Start with events only, fast follow with alerts. This is just AIDC, AIDC+ will be ready later in Q2."
→ Devin Smith: "it will be on v58 also for GA"
→ Alexa Witowski: "Can we get Beta running in MX too? This feature will be huge there."

THREAD 22: Eating AI — What Does It Detect
Line item: "Eating AI beta is already changing driver behavior"

Marc Ische: "Is it 'eating' or 'anything to mouth' like food & drink...or will it catch me biting my nails."
→ Nihar Gupta: "Not drinking, just food. Biting nails wont/shouldn't trigger."
→ Achin Gupta: "It detects solid food items only."
→ Marc Ische: "Good to know no nailbiting coaching conversations triggered when my wife isn't in the vehicle with me." 😀

THREAD 23: Unsafe Parking / Unsafe Lane Change Below Targets
Line item: "Stop Sign Violation 92% vs 94% target; Unsafe Lane Change 83% vs 85% target"

Shoaib Makani: "if we can get this into mid 90s we should start doing in-cab alerting on it?"
→ (No direct response on ULC — Devin covered Unsafe Parking and Lane Swerving separately)

Marc Ische: "Curious about this one as well, best doc to understand it. Vision only, or any maps? Challenges with different sign types, or 'not for me' signs."
→ Gautam Kunapuli: "This 2–5% drop is actually due to issues with the speed, where SSVs are incorrectly flagged even when the vehicle drops below the minimum speed threshold. This is due to a lag introduced by some smoothing algorithms and fusion between GPS and vehicle speeds. We have an ongoing project to fix the speed sources. We will test this in Tiger Team in April/May and GA in mid-to-late Q2."

THREAD 24: AI Roadmap Slips & Tradeoffs
Line item: "AI roadmap delivery on AIDC+ saw some slips... pushing some AIDC+ AI features a bit later than originally planned"

Amish Babu: "Need to do a better job here on tradeoffs. this remains a key issue. AI Annotator, hey motive, 2 way calling all has some tradeoff. We need a constant roadmap view and how its changing."
→ Zach Brand: 👍 reaction
→ Chandra Rathina: ➕ reaction
→ Muhammad Talha: ➕ reaction
→ Nihar Gupta: "Better job in terms of identifying the tradeoffs clearly? Let's discuss."

THREAD 25: EVE Rollout — Timeline & Latency Impact
Line item: Improve customer experience with rapidly delivered events

Shoaib Makani: "this is going to change in a big way once EVE is rolled out for all events? what is timeline for that?"
→ Nihar Gupta: "Yes it will. We need to properly plan this for Q2 since it is an 'unplanned' project, and allocate resources accordingly. This is happening as part of Q2 replan. + @michael.benisch @arshdeep.kaur @arjun.rattan"
→ Arjun Rattan: 👍 reaction
→ Chandra Rathina: 👍 reaction
→ Michael Benisch: "By end of March we will have EVE effectively rolled out across all behaviors (AI + collisions) and all customers other than trials. One thing to keep in mind: for certain types of events like collisions, EVE actually adds latency for the majority of cases because those will first be processed by EVE and then sent to annotators."

THREAD 26: Unit Test Coverage
Line item: "Unit Test Coverage — established a safety-wide initiative to automate unit tests to 80%"

Amish Babu: "Thank you."
→ Chandra Rathina: 🙏 reaction
→ Prashant Ramarao: 👏 reaction

THREAD 27: AI Pipeline Revamp — Praise
Line item: AI Pipeline Revamp & Reliability

Shoaib Makani: "great to see us investing for the long run here. thank you team who are working on this one."

THREAD 28: Harsh Event Precision AIDC+ — IMU Shortage
Line item: Harsh event Precision AIDC+ — Delayed

Joe Pulver: "IMU shortage, we need to train models for a new IMU. current IMU stock is exhausted early June."
→ Avinash Devulapalli: "Yes aware about this. Added the point."

THREAD 29: AEP Poly-Repo Compliance — Code Organization
Line item: "Reliability: newer guidelines from SRE/DevProd about migrating AEP from mono-repo to poly-repo due to compliance reasons"

Prashant Ramarao: "this is the first I've heard compliance is driving how code is organized? Lets follow-up."
→ Chandra Rathina: ➕ reaction
→ Dhiraj Bathija: (linked Slack thread with Paul)

THREAD 30: GNARR Losses — Loss Reasons
Line item: "Losses: R&R Express ($233k), Prospect Express ($57k)"

Amy Loh: "Any notes on the loss reasons?"
→ Nihar Gupta: "@danyyal.khalid can you share loss reasons here?" + "we should add to appendix moving forward along with churn customers/reason"
→ Chandra Rathina: "Its in Appendix A.2"
→ Nihar Gupta: "Yeah they should be there actually but dont match what is listed here."
→ Chandra Rathina: 👍 reaction
→ Danyyal Ahmed Khalid (DAK): "They're not in Appendix A.2 because they're not safety-driven losses, rather general churn accounts impacting Safety ARR."
→ Nihar Gupta: 👍, Chandra Rathina: 👍

Shoaib Makani: "i would add sonepar here. they cited missed accident as the reason for not choosing Motive."

THREAD 31: Provision — Mexico Dates
Line item: Provision Integration Launch

Alexa Witowski: "Can we please get vis into the MX dates here?"
→ Nihar Gupta: "@baha-eldin.elkorashy can we add this? cc @marc.ische who will be taking over ownership. Is this called out in your tracker?"
→ Baha Elkorashy: "Yes, it is currently being tracked / managed by Ted Jao, but I can loop in updates and begin KT with Marc soon."

Thread Summary — By Engagement Level
Thread	Topic	# Participants	Most Active
19	Collision recall AIDC+ sample size	5	David Sanford
18	E2E latency / AI annotator cohort	6	Chandra, Nihar, Avinash
11	Two Way Call placement	5	Sean, Nihar, Chandra
20	Fatigue AIDC+ date / juggling priorities	4	Gautam, Naveen, Nihar
21	Fatigue Index beta launch 🔥	7	Shoaib, Gautam, Devin
4	Enhanced telematics gap	5	Umair, Nihar, Zainab
6	Edge ALPR complexity	4	Amish, Hareesh, Gautam
30	GNARR loss reasons	5	Nihar, DAK, Chandra
1	Livestreaming metrics / multicast	5	Marc, Chandra, Bilal
