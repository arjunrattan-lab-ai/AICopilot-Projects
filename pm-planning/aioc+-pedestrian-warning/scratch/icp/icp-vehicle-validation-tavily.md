# Vehicle Validation — Tavily Public Sources (2026-04-22)

**Filter applied:** heavy (Class 5-8) + pre-2020 (no factory BSM). Keep if >50% of units.

**Method:** Tavily advanced search across account websites, sustainability reports, 10-Ks, trade press, FMCSA SAFER, LinkedIn, industry filings. Runs in parallel with internal Snowflake agent.

**Legend:**
- ✅ Clear ICP fit — heavy + aging likely >50%
- ⚠️ Mixed / partial — depends on segmentation
- ❌ Fails filter — light-duty dominant or factory-BSM equipped fleet

---

## Per-account profile

### 1. Waste Connections (WC)
- **Fleet size (public):** ~10,000 vehicles total; ~8,500 route (refuse/recycling) trucks. [2024 Sustainability Report]
- **Vehicle types:** Heavy refuse trucks — front/rear/side loader, roll-off, transfer tractors. Suppliers: Freightliner, Mack, Peterbilt, Autocar w/ Heil, McNeilus, Labrie, Galbreath, UHE bodies.
- **Typical class:** Class 8 dominant (refuse collection vehicles).
- **Fleet age:** Active replacement program — "replacing older trucks with newer, more efficient models." No avg-age disclosed, but refuse trucks typically run 8–12 yrs; ~10% alt-fuel (CNG/biodiesel) means 90% diesel ICE. WCN is not leading EV transition (Republic/WM are).
- **BSM/ADAS mentions:** None — WCN sustainability reports emphasize onboard tablets + engine diagnostics, not ADAS. Factory BSM on refuse chassis is rare pre-2022.
- **ICP fit:** ✅ Strong. Canonical heavy + aging refuse fleet.
- **Sources:** fleetequipmentmag.com/fleet-profile-waste-connections-refuse; sustainability.wasteconnections.com; Henry Fund WCN report (Iowa).

### 2. FirstFleet / Werner
- **Fleet size (public):** FirstFleet ~2,400 tractors, 11,000 trailers, 37 facilities, 2,650 drivers. Werner parent ~7,500+ tractors combined post-acquisition.
- **Vehicle types:** Class 8 dedicated tractor-trailers — grocery, baked goods, corrugated packaging end markets.
- **Typical class:** Class 8 — 100% heavy.
- **Fleet age:** Werner runs "modern truck and trailer fleet" (marketing language). Dedicated contract carriers typically trade every 4–6 yrs — so a 2026 fleet has a mix of post-2020 and pre-2020 tractors. Pre-2020 % likely ~30-40%.
- **BSM/ADAS mentions:** Werner has publicly invested in ADAS via Werner EDGE technology; newer Freightliner/Peterbilt tractors post-2020 often have OEM BSM (Detroit Assurance, Bendix). Older tractors likely do not.
- **ICP fit:** ⚠️ Heavy yes, but aging <50% of fleet questionable. Fleet refresh cadence may put majority of tractors post-2020.
- **Sources:** freightwaves.com; truckinginfo.com; investor.werner.com.

### 3. NYC School Bus Umbrella Services (NYCSBUS)
- **Fleet size (public):** ~800 buses / 800 routes, 1,800 staff, 6 locations.
- **Vehicle types:** School buses — Type A, C, D (primarily Type C full-size + Type A for IEP/special-needs routes).
- **Typical class:** Class 4–7 (Type A small bus = Class 4-5; Type C/D = Class 6-7).
- **Fleet age:** Contract began 2020 on inherited fleet from private operators (Reliant, Pioneer). Public NY school-bus fleets avg 8–12 yrs. 25 new electric buses rolling out in Bronx — tiny fraction.
- **BSM/ADAS mentions:** None. School bus Type C/D did not have standard factory BSM pre-2022 (federal standards for school bus side/blind-spot systems are still evolving).
- **ICP fit:** ✅ Strong. Aging heavy-ish bus fleet, no factory BSM.
- **Sources:** electricschoolbusinitiative.org; mobilityhouse.com; comptroller.nyc.gov (SBUS FY25 financials); linkedin.com/company/nycsbus.

### 4. Alliance Environmental
- **Fleet size (public):** Not publicly disclosed. FMCSA SAFER shows 234,000 miles/yr (single-entity reporting) — implies a modest operational fleet, likely <100 power units. 16 locations across CA/NV/AZ/WA.
- **Vehicle types:** Remediation/HVAC duct cleaning/asbestos/hazmat vans and service trucks. Website shows branded cargo vans + box trucks.
- **Typical class:** Class 2–5 (service vans and small box trucks — NOT heavy).
- **Fleet age:** Unknown publicly.
- **BSM/ADAS mentions:** None found.
- **ICP fit:** ❌ Weak. Environmental services = predominantly light-duty cargo vans. Fails heavy-duty filter.
- **Sources:** alliance-enviro.com; safer.fmcsa.dot.gov (DOT 2431887); prnewswire.com.

### 5. Blossman Gas
- **Fleet size (public):** ~270+ autogas vehicles documented (2019 case study) + propane bobtails beyond that. 76 branches.
- **Vehicle types:** **Autogas vehicle breakdown (2019 data):** Class 1: 23, Class 2: 103, Class 3: 65, Class 4: 27, Class 5: 4, Class 7: 49. Plus propane delivery bobtails (Class 6-8).
- **Typical class:** **Mixed — majority Class 1-4 autogas light-duty, with a heavy tail of bobtails (Class 7-8).** Heavy share of disclosed autogas fleet = ~20% (Class 5+). Propane bobtails add heavy units not in that count.
- **Fleet age:** Autogas conversion program has been running 5+ yrs as of 2018 — so many converted vehicles are pre-2020.
- **BSM/ADAS mentions:** None.
- **ICP fit:** ⚠️ Heavy portion exists (bobtails) but clearly mixed; needs internal VIN breakdown. Published autogas data skews light-duty.
- **Sources:** allianceautogas.com Blossman case study PDF; blossmangas.com.

### 6. GreenWaste Recovery
- **Fleet size (public):** Not disclosed in a single number, but operates across San Jose, Palo Alto, Santa Cruz, Sacramento — estimated 150-250 collection vehicles.
- **Vehicle types:** Heavy refuse — residential side-loader, rear-loader, roll-off, plus heavy equipment at MRFs.
- **Typical class:** Class 8 dominant.
- **Fleet age:** **100% transitioned to renewable/alternative fuel (R99 renewable diesel, CNG, biodiesel) by 2022** for collection + 2023 for heavy equipment. Heavy equipment has been replaced/retrofitted recently. CA Advanced Clean Fleets rule starting 2025 forces retirement of ICE vehicles at end of useful life. **Fleet is likely newer than peers — pre-2020 % may be below 50%.**
- **BSM/ADAS mentions:** None, but new trucks (2023+) increasingly have factory BSM.
- **ICP fit:** ⚠️ Heavy yes, but fleet refresh pressure from CA regulators + sustainability posture may push pre-2020 <50%.
- **Sources:** greenwaste.com 2020/2023/2024 sustainability reports.

### 7. Gilton Solid Waste Management
- **Fleet size (public):** Not disclosed; services Modesto, Oakdale, Escalon, Riverbank, Hughson, Livingston, Merced/San Joaquin/Stanislaus counties — regional scale, estimated 50-150 trucks.
- **Vehicle types:** Heavy refuse (residential/commercial/industrial automated + side-loader), plus bin/cart trucks. "Automated garbage trucks" referenced.
- **Typical class:** Class 7-8 refuse.
- **Fleet age:** Public record (Merced County franchise doc) notes "long-term contracts are a unique necessity...banks won't lend money needed for expensive equipment, like automated garbage trucks." Implies capex-heavy, long depreciation — skews older.
- **BSM/ADAS mentions:** None.
- **ICP fit:** ✅ Strong. Classic private regional hauler profile.
- **Sources:** gilton.com; web2.co.merced.ca.us franchise agreement PDF; themodestofocus.org.

### 8. Ace Disposal (SLC)
- **Fleet size (public):** 248 power units (FMCSA), 204 drivers. ~194 vehicles in alt-fuel per 2021 DOE case study. Hauls 2,300 tons/day.
- **Vehicle types:** Heavy refuse — front-load, side-load, roll-off, compactors. Introduced Mack LR Electric Class 8.
- **Typical class:** Class 8.
- **Fleet age:** 40-year-old company. 66% of fleet on alternative fuel (CNG/electric). CNG adoption since 2008 — older CNG units are 10-15 yrs old. Active but slow fleet refresh.
- **BSM/ADAS mentions:** None.
- **ICP fit:** ✅ Strong. Heavy, aging, no factory BSM.
- **Sources:** otrucking.com DOT#704273; afdc.energy.gov case 3095; volvogroup.com news 2023; acedisposal.com.

### 9. Waste Connections South / MidSouth
- **Fleet size (public):** Regional WCN segments. WCN 10-Q Q3 2025 shows Southern + MidSouth = ~$744M combined quarterly revenue. Fleet estimate: ~2,000–2,500 vehicles combined based on segment revenue proportion of total ~10,000.
- **Vehicle types:** Same as WCN parent — heavy refuse.
- **Typical class:** Class 8.
- **Fleet age:** Same as WCN — moderate refresh, 90% diesel ICE.
- **BSM/ADAS mentions:** None.
- **ICP fit:** ✅ Strong. Inherits parent profile.
- **Sources:** WCN 10-Q Q3 2025 PDF; wasteconnections.com.

### 10. Recicladora Regiomontana
- **Fleet size (public):** Not disclosed. Small Monterrey-area scrap/recycling business, 30+ yrs. Website (rrsa.mx) is minimal; Instagram presence only.
- **Vehicle types:** Scrap collection — roll-off, flatbeds, forklifts at yard.
- **Typical class:** Likely Class 6-8 (scrap hauling) + yard equipment.
- **Fleet age:** Unknown. Mexico private scrap operations historically run very old fleets (15+ yr trucks common).
- **BSM/ADAS mentions:** None — highly unlikely on a Mexico-market scrap fleet.
- **ICP fit:** ✅ Likely strong, but data thin. Mexico scrap = heavy + old by default.
- **Sources:** rrsa.mx; instagram.com/p/DJr-yuES2qf.

### 11. Parking Lot Painting Company
- **Fleet size (public):** **Data thin** — no hits on the exact company name via Tavily. Likely a small regional striping contractor.
- **Vehicle types:** Striping contractors typically run box trucks, sprayer rigs, pickup trucks with towed thermoplastic equipment, small service vans.
- **Typical class:** **Class 2-5 (pickups, cargo vans, small box trucks)** — primarily light/medium, NOT heavy refuse or transit.
- **Fleet age:** Unknown.
- **BSM/ADAS mentions:** None.
- **ICP fit:** ❌ Likely weak. Parking-lot striping = light/medium-duty work trucks. Fails the "heavy Class 5-8" filter unless the fleet is unusually large box-truck heavy.
- **Sources:** No direct hits. Inference from industry (saffoldpaving.com; acplm.net; etc.).

### 12. Noble Environmental (PA)
- **Fleet size (public):** Not disclosed in a single number. Operates Westmoreland Sanitary Landfill and CNG-fueled refuse fleet. "Smart" CNG trucks referenced.
- **Vehicle types:** Heavy refuse + transfer trucks. Pulls landfill gas to fuel the fleet.
- **Typical class:** Class 8.
- **Fleet age:** CNG investment + "smart" trucks language suggest newer adds, but landfill/haulers hold trucks 10+ yrs.
- **BSM/ADAS mentions:** None.
- **ICP fit:** ✅ Strong. Heavy refuse + CNG fleet.
- **Sources:** nobleenviro.com; wjactv.com; files.dep.state.pa.us.

### 13. AAA Carting & Rubbish Removal (NY)
- **Fleet size (public):** 51-200 employees (LinkedIn). Hudson Valley / Westchester / White Plains / Newburgh / Middletown NY + parts of CT. Estimated 40-80 trucks.
- **Vehicle types:** Roll-off containers (10, 20, 30, 40 yard), residential trash trucks, commercial front-load, demolition & asbestos hauling.
- **Typical class:** Class 7-8 roll-off and refuse.
- **Fleet age:** Unknown, but regional family-owned haulers trade every 10-15 yrs.
- **BSM/ADAS mentions:** None.
- **ICP fit:** ✅ Strong. Classic NY regional heavy refuse.
- **Sources:** aaacarting.com; linkedin.com/company/aaacarting; lohud.com.

### 14. City of Fort Worth
- **Fleet size (public):** ~4,500 vehicles (city-wide fleet per CCG/FASTER implementation). The "2,500-veh water utility" number referenced in the target list is the **water utility subset**.
- **Vehicle types:** Extremely mixed — police sedans, fire apparatus, solid waste packer trucks, water utility service trucks, parks mowers, inspectors' pickups, heavy equipment.
- **Typical class:** **Mixed across Class 1-8.** Water utility subset skews medium-heavy (service trucks, water tankers, vactors). But city-wide, majority is light-duty (sedans, pickups).
- **Fleet age:** FY25-29 CIP lists scheduled apparatus replacement starting 1999, still ongoing — long-lived fleet. Many vehicles 10+ yrs.
- **BSM/ADAS mentions:** None specific to legacy fleet.
- **ICP fit:** ⚠️ Depends on segmentation. Water utility trucks = heavy + aging = fit. City-wide fleet = mixed, fails if counted whole.
- **Sources:** fortworthtexas.gov/files/assets/public/v/1/the-fwlab/documents/budget-documents/fy2025-29-adopted-capital-improvement-plan.pdf; government-fleet.com (CCG Systems article); nctcog.org 2023 Clean Cities survey.

### 15. JEA (Jacksonville)
- **Fleet size (public):** Claimed 6,306 vehicles in target list — JEA public material confirms "commercial fleet" serving 450,000+ customers across 900 sq mi. Actual JEA-owned fleet is smaller (estimates suggest 1,500–2,500 utility vehicles); 6,306 likely includes JEA + C&I customer fleet partners in the Fleet Electrification Program.
- **Vehicle types:** Utility bucket trucks, digger derricks, line trucks, service vans, pickups. Heavy utility equipment.
- **Typical class:** Class 6-8 bucket/digger/line trucks dominate the heavy segment; Class 2-4 service trucks for meter reading.
- **Fleet age:** Bucket trucks run 12-20 yrs. Fleet Electrification Program launched 2023 — refresh is starting, not complete.
- **BSM/ADAS mentions:** None — utility chassis (Altec, Terex) historically lack factory BSM.
- **ICP fit:** ✅ Strong for the utility bucket-truck segment; ⚠️ if meter-reading light-duty is majority.
- **Sources:** jea.com/business_resources/fleet_electrification_program; resource-innovations.com; floridapsc.com 10-yr site plan.

### 16. CapMetro (Austin)
- **Fleet size (public):** **416 buses + 55 Rapid + 78 Pickup + 137 paratransit + 94 vanpools + 10 trains.** Total ~690 transit vehicles.
- **Vehicle types:** Transit buses (40ft coaches) + Rapid BRT + cutaway paratransit + vanpools.
- **Typical class:** Class 7-8 transit coaches dominant. Paratransit = Class 4-5. Pickup vans = Class 2-3.
- **Fleet age:** 10-year fleet replacement schedule. Actively purchasing zero-emission electric buses (New Flyer Xcelsior XE40). Facility being built to house 214 buses / 187 electric — more than half the fleet. **Aggressive refresh underway — pre-2020 % declining.**
- **BSM/ADAS mentions:** New Flyer XE40 (2020+) has OEM ADAS options. Pre-2020 legacy fleet does not.
- **ICP fit:** ⚠️ Heavy yes, but CapMetro is electrifying fast — heavy+aging subset may be <50% in 2 yrs.
- **Sources:** capmetro.org/facts; capmetro.org/electricbus; en.wikipedia.org/wiki/CapMetro_Bus.

### 17. RATP DEV USA
- **Fleet size (public):** 10,001+ employees in North America; 6,000+ team members transporting riders. Parent RATP Group operates 4,500 buses in Paris. US operations include Greensboro, Winston-Salem, multiple TX/NC cities. 4,000 US transit buses is plausible.
- **Vehicle types:** Transit buses — fixed-route, commuter, paratransit.
- **Typical class:** Class 7-8 heavy-duty transit coaches.
- **Fleet age:** RATP Paris avg fleet age ~8 yrs (renewal rate 10-15 yrs). US contract fleets typically operate municipality-owned buses — age dictated by agency procurement, often 12-year buses. Paris is aggressively electrifying; US ops less so.
- **BSM/ADAS mentions:** Buses post-2020 increasingly have OEM Mobileye Shield+ or similar. Pre-2020 fleet generally does not.
- **ICP fit:** ✅ Strong. Heavy transit + diverse contract-age fleets = majority pre-2020 in US.
- **Sources:** linkedin.com/company/ratp-dev-north-america; ratpdev.com/en/usa; sustainable-bus.com; ratpdevusa.com sustainable transportation white paper.

### 18. Modern Disposal Services (NY)
- **Fleet size (public):** **314 trucks**, nearly 700 employees, 8 facilities (NY Trucking Buyers Guide). Founded 1964, Model City NY.
- **Vehicle types:** Heavy refuse — front-load, residential automated carts (joystick arms), roll-off, plus landfill ops.
- **Typical class:** Class 7-8.
- **Fleet age:** Unknown specifically, but regional family hauler profile → 10-15 yr trucks common.
- **BSM/ADAS mentions:** None. Automated arm technology referenced but that's collection automation, not BSM.
- **ICP fit:** ✅ Strong. Heavy + aging + no BSM.
- **Sources:** moderncorporation.com; nytruckingbuyersguide.com.

### 19. [Placeholder — 19th account not explicitly named in target list]
Target list above totals 18 named accounts. If a 19th is pending, likely mapped to WC-MidSouth being counted separately from WC-South. Treated as one in analysis above (item 9).

---

## Surprises

- **Alliance Environmental**: Assumed "environmental services" = heavy fleet. Public data shows service-van/box-truck contractor profile. **Fails heavy-duty filter.**
- **Blossman Gas**: Assumed propane delivery = heavy bobtails. Public autogas data shows ~80% of the disclosed converted fleet is Class 1-4 (sedans/pickups/service vans). Heavy bobtails exist but are a minority of the total fleet. **Mixed.**
- **City of Fort Worth**: The "2,500-veh water utility" number is a subset of a ~4,500 city-wide fleet. Needs segment-specific vehicle pull, not a whole-fleet claim.
- **GreenWaste + CapMetro**: Both are aggressive early-refresh operators (CA Advanced Clean Fleets mandate + CapMetro electrification). Pre-2020 share may drop below 50% fast — watch the calendar.
- **JEA 6,306 vehicles**: This number likely includes JEA Fleet Electrification Program C&I customer participants, not JEA's owned fleet. Actual owned fleet materially smaller.
- **FirstFleet/Werner**: Dedicated contract carriers refresh tractors faster than refuse haulers. Pre-2020 tractor share uncertain — may be the minority.

## Strong fits (heavy + aging, high confidence) — 10

1. Waste Connections parent
2. Waste Connections South / MidSouth
3. NYCSBUS (school bus)
4. Gilton Solid Waste
5. Ace Disposal
6. Recicladora Regiomontana (assumed from Mexico scrap industry norms)
7. Noble Environmental
8. AAA Carting
9. Modern Disposal
10. RATP DEV USA (transit)

## Weak fits / flags — 5

- **Alliance Environmental** — looks like service vans, not heavy. **Recommend drop from target list on vehicle-profile grounds.**
- **Parking Lot Painting Company** — striping contractor, almost certainly pickup/box-truck light-duty. **Recommend drop unless internal VIN pull proves otherwise.**
- **Blossman Gas** — heavy bobtail tail exists but light-duty autogas dominates published fleet. Flag for internal VIN segmentation.
- **GreenWaste Recovery** — heavy, but fleet refresh pressure may push pre-2020 below 50%. Flag for model-year check.
- **CapMetro** — same refresh-pressure flag as GreenWaste. Aggressive EV transition.

## Data thin

- **Parking Lot Painting Company** — no direct public footprint. Needs SFDC/internal source.
- **Recicladora Regiomontana** — Mexico private scrap, minimal web presence. High confidence on heavy-ICE profile by industry inference, but no specific vehicle count.
- **Gilton Solid Waste** — no public fleet count.
- **Noble Environmental** — no public fleet count.
- **AAA Carting** — employee count only, no fleet count.

## Recommendation

Drop or demote on vehicle-profile grounds:
1. **Alliance Environmental** — light-duty service van fleet, not heavy-duty.
2. **Parking Lot Painting Company** — striping contractor, light/medium duty.

Flag for internal segmentation before calling ICP fit:
3. **Blossman Gas** — split autogas light-duty from propane bobtail heavy.
4. **City of Fort Worth** — confirm we are targeting the water utility heavy subset, not the whole 4,500-vehicle city fleet.
5. **FirstFleet/Werner**, **GreenWaste**, **CapMetro** — confirm pre-2020 % is >50% via VIN model-year pull. Active refresh may have dropped them below threshold.

High-confidence keep (heavy + aging dominant):
6. WC parent, WC South/MidSouth, NYCSBUS, Gilton, Ace Disposal, Recicladora, Noble, AAA Carting, Modern Disposal, RATP DEV, JEA (utility bucket-truck subset).

Cross-check all findings against the parallel Snowflake agent's VIN/model-year pull before finalizing the target list.
