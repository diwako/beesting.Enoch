//INIT/////////////////////////////////////////////////////////////////////////////////////////////
private _allReadables = [
	readable_0,
	readable_1,
	readable_2,
	readable_3,
	readable_4,
	readable_5,
	readable_6,
	readable_7,
	readable_8,
	readable_9,
	readable_10,
	readable_11,
	readable_12,
	readable_13,
	readable_14,
	readable_15,
	readable_16,
	readable_17,
	readable_18,
	readable_19,
	readable_20,
	readable_21,
	readable_22,
	readable_23,
	readable_24,
	readable_25,
	readable_26,
	readable_27,
	readable_28,
	readable_29,
	readable_30,
	readable_31,
	readable_32
];

//DEBUG////////////////////////////////////////////////////////////////////////////////////////////
private _debug = false;
if (_debug) then {
	{
		private _mrkr = createMarkerLocal [("marker_" + str _x), getPosASL _x];
		_mrkr setMarkerTypeLocal "mil_triangle";
		_mrkr setMarkerColorLocal "ColorYellow";
		_mrkr setMarkerAlphaLocal 0.5;
		_mrkr setMarkerSizeLocal [0.5,0.5];
		_mrkr setMarkerTextLocal (str _x);
	} forEach _allReadables;
};

//READABLES////////////////////////////////////////////////////////////////////////////////////////
//0
["init", [readable_0, "images\paper2.paa",
"
<t size='2'>What’s killing the Bees and how to stop it.</t><br/>
15.05.2035<br/><br/>

Worldwide bee colony collapse is not as big a mystery as the chemical industry claims.<br/>
The systemic nature of the problem makes it complex, but not impenetrable. Scientists know that bees are dying from a variety of factors, such as chemicals, drought, habitat destruction, nutrition deficit, air pollution, global warming and more. Many of these causes are interrelated. The bottom line is that we know humans are largely responsible for the two most prominent causes: chemicals and habitat loss.<br/><br/>

Biologists have found more than 150 different chemical residues in bee pollen, a deadly 'chemical cocktail' according to scientists. However the large chemical companies shrug their shoulders at the systemic complexity, as if the mystery were too complicated. They advocate no change in pesticide policy. After all, selling poisons to the world is very profitable.<br/><br/>

So what can we do to stop it? Common sense actions can restore and protect the world’s bees. Here’s a strong start:<br/><br/>

1. Ban the seven chemicals most dangerous to bees..<br/>
2. Protect pollinator health by preserving wild habitat.<br/>
3. Restore ecological agriculture.
"
]] call BIS_fnc_initLeaflet;

//1-4
{["init", [_x, "images\paper2.paa",
"
<t size='2'>What is the Government planning?</t><br/>
23.04.2036 by Albin Nowak<br/><br/>

Many of you might have noticed the increase of military presence in our towns and villages. Soldiers in strange suits carrying suitcases and other items into shops, hospitals and the like, only to emerge empty handed shortly after, at which point they proceed to load back into their armored trucks and disappear without a trace. As if that was not weird enough, peculiar metal constructions can be seen along the roads when driving from town to town, many of which are guarded by heavily armed soldiers. What does it all mean?<br/><br/>

A source that wants to remain anonymous might be able to shine some light on the event unfolding before us. According to him the strange suits these soldiers are wearing are so called ‘CBRN’ suits, which armies are using to protect their soldiers against so called ‘chemical warfare’. For clarification on what that kind of war would look like, one could read up on the horrible use of ‘mustard gas’ during the first World War. On the other hand the previously mentioned metal constructs seem to be decontamination showers, used to wash off particles left behind by some of these chemical attacks.<br/><br/>

Sadly this source does not know as to why the LDF are doing what they are doing. His best guess was that they are currently undergoing a large scale training exercise. However if they are actually preparing for chemical warfare then two new questions arise. Who would attack Livonia and what will happen to us, the ones that don’t have fancy suits to protect themselves?
"
]] call BIS_fnc_initLeaflet;} forEach [readable_1,readable_2,readable_3,readable_4];

//5-9
{["init", [_x, "images\paper2.paa",
"
<t size='2'>EVACUATION NOTICE:</t><br/>
Dear citizens,<br/><br/>

Due to national security concerns the area you currently reside in and its surrounding territory will become a restricted area. For information on the closest evacuation center and further proceedings please refer to the police or military personnel that will assist you during your evacuation. Due to the nature of these centers taking pets and large personal belongings with you is not permitted.<br/><br/>

We are very sorry to inform you that the matter is rather pressing and the evacuation of your residence must be completed by the 31.05.2036, or in other terms in exactly 1 week after receiving this informational notice.<br/><br/>

We thank you for your cooperation, sincerely:<br/>
The National Committee of Evacuation Plans
"
]] call BIS_fnc_initLeaflet;} forEach [readable_5,readable_6,readable_7,readable_8,readable_9];

//10
["init", [readable_10, "images\paper2.paa",
"
<t size='2'>Crumpled Note #1:</t><br/>
28.05.36<br/>
What a bunch of crap! Leaving all my shit behind for some stupid evacuation zone and hoping these underpaid moron soldiers won’t steal anything? I don’t think so. I’ll use the remaining days I got until they lock this place up for good, to slowly smuggle all my important shit up the road to my old parents house. That place has been abandoned for years, gives me the creeps to be there at night but what other choice do I have, I don’t want everybody in the village including the soldiers to know what I’m doing, now do I?
"
]] call BIS_fnc_initLeaflet;

//11
["init", [readable_11, "images\paper2.paa",
"
<t size='2'>Crumpled Note #2:</t><br/>
31.05.36<br/>
Well, last day of the evacuation period. I still have no plans to go to one of those crowded evacuation zones. I’ll just head to Wrzeszcz and buy myself supplies for a few weeks and camp out in my old parents house. Besides, I wanna keep an eye on what those morons are gonna do when they think they are unobserved.<br/>
----<br/>
Just got back from the store, didn’t get as many supplies as I wanted to, however one thing I noticed is that the news must’ve really put some fear in people since they are selling respirators now. I’m not particularly concerned that any country would care about small Livonia but hey, they were pretty cheap and I mean it doesn’t hurt to have one right? Either way, time to pack up and get going.
"
]] call BIS_fnc_initLeaflet;

//12
["init", [readable_12, "images\paper2.paa",
"
<t size='2'>Survivor Note #1:</t><br/>
If you read this:<br/>
This is the fourth ransacked store we’ve come across, this message is meant to save you some time if you planned on looking for supplies in here, there is nothing edible left. We are going further east, since there seems to be nothing left anywhere close in the west.<br/><br/>

P.S.: Isn’t it concerning how scarce supplies have become in a matter of only 2 years.
"
]] call BIS_fnc_initLeaflet;

//13
["init", [readable_13, "images\paper2.paa",
"
<t size='2'>Survivor Note #2:</t><br/>
Maja, don’t go to the evacuation zones. Take the children and leave the country. Just go and stay at your sisters place in Poland. I have asked my commanding officer about the evacuation zones and these containers we are delivering to almost every village and he said he doesn’t know either. He said he knows that these containers are filled with some sort of chemicals or something and that he heard the evacuation zones are only meant to temporarily house the civilians while something is being set up. Whatever it is I don’t think it’s something good. Why would they not tell us what we are doing if it was good?<br/><br/>

Please go to your sister, I will write you a letter when I know more. I love you, don’t let anyone know I told you this or I could get in serious trouble. Especially Zofia! She always had a loose mouth.
"
]] call BIS_fnc_initLeaflet;

//14
["init", [readable_14, "images\paper2.paa",
"
<t size='2'>Survivor Note #3:</t><br/>
If you are from the news read this, if you aren’t then take this to someone who is!<br/><br/>

I don’t have much time so I’ll keep this short. My brother just died in my arms and it’s the armies’ fault. Me, my brother and several others from the village were fed up with the lack of water and food, so we decided to confront the soldiers stationed closest to us in Gieraltow. Since they always seem to have enough food and water, we figured they could share some with the people outside Gieraltow. However they wanted to shoo us away as if we were some hungry annoying animals and when we got angry and things escalated it happened. One of the soldiers shot and it hit my brother in the stomach. We screamed at them he needs help but they just pointed their weapons at us so we quickly backed off. By the time we got to a car my brother was no longer conscious and by the time we were back in Wrzeszcz he was already dead.<br/><br/>

Anyway, when we left I could hear the soldiers talk about ‘what to do now’ and their voices seemed nervous. I’m not sure what they are planning to do, but I sure as hell won’t stick around to find out. I leave this note here with my brother in case something happens to me. I hope that someone from the news comes by and tells everybody what the LDF has done!<br/><br/>

Signed, Eryk Zajac. 24.07.2036
"
]] call BIS_fnc_initLeaflet;

//15-17
{["init", [_x, "images\paper2.paa",
"
<t size='2'>The Crowded 'Evacuation Zones'</t><br/>
18.07.2036 by Albin Nowak<br/><br/>

If you are currently residing in one of the evacuation camps the military has set up this might not be news to you. But only about two and a half months after the government of Livonia has first issued the evacuation notice, the frustration of the people with the lack of space, food and privacy is already reaching a dangerous level.<br/><br/>

With zero explanations from the government and the borderline violent attitude of the military when enforcing order in the camps, the divide between the people and the state is growing bigger by the day. People fed up with this situation are leaving the camps by the dozens with one goal in mind: ‘Going back home.’ Large crowds can be seen outside most villages and towns that have been evacuated, demanding to be let back into their homes. Traffic jams on borders and checkpoints that have been closed for about a week now, are getting bigger and bigger and the large group of protesters in front of the parliament in Andrzejów have declared they will not leave until they have gotten answers.<br/><br/>

A lot of you reading this might wonder when everything will go back to normal and why there is no clear answer to many of the questions that might go through your head. That does not mean there is nothing you can do. Head over to <t color='#4169E1'>https://www.livonia-deserves-answers.lva</t> and inform yourself about how you can help make the government talk.
"
]] call BIS_fnc_initLeaflet;} forEach [readable_15,readable_16,readable_17];

//18
["init", [readable_18, "images\paper2.paa",
"
<t size='2'>Survivor Note #4:</t><br/>
I’m fairly certain yesterday while navigating the minefield I almost died. The crazy thing is that it wasn’t due to a mine, no it was way crazier than that.<br/><br/>

I was just taking a break from walking, eating my ravioli, when I heard some screaming from like a hundred meters away. I quickly got up into a crouch and hid behind the tree. What I saw next was unbelievable: There was a group of people that looked almost tribal, they had really rustical weapons like machetes and they were almost naked. When I looked a little bit closer I noticed some of them were holding down a man while others seemed to bite him. And sure enough that was what they were doing. For the next 2 hours I crouched behind this tree unable to move and scared like hell they would discover me. It was gruesome hearing the man scream with every bite they took until it eventually stopped. After it was all over they flung ‘the rests’ across their shoulders and walked off. What’s really strange about this too is that they did that in the middle of a god damn minefield, it's almost as if they knew where every single mine was.<br/><br/>

Anyway, that will be the last time I venture this far north.
"
]] call BIS_fnc_initLeaflet;

//19
["init", [readable_19, "images\paper2.paa",
"
<t size='2'>MSR Note #1:</t><br/>
Well, guess I’m far from the only one that is sick and tired and just wants to go home. And we could, if it wasn’t for the government's right hand the LDF. Dogs following their master's orders without any thought about what they are actually doing. Either way, there is a couple of guys that plan on just rallying some more people and walk right through the checkpoint. What are they gonna do, shoot us? We live in that village! How can it be that only because some of us were out of town while the evacuation happened, we now can’t enter merely because we don’t have our papers with us. Could they not just let us in and then we could proof we really belong to the village? I thought all evacuation zones were supposed to be public places that anyone could enter and seek shelter in, but apparently there is certain ‘quotas’ that they have to keep.
"
]] call BIS_fnc_initLeaflet;

//20
["init", [readable_20, "images\paper2.paa",
"
<t size='2'>MSR Note #2:</t><br/>
There is a large black safe in the back of this truck. I bet you wonder what could be in there. A shitload of money, gold or jewelry? Well, guess you’ll never know. My crew and I tried to crack this piece of shit in several ways already, but I guess unless you’ve got a thermal lance or something like that you can absolutely forget getting into that piece of crap. Oh yeah and nevermind trying to take it with you, it is anchored into the truck and weighs more than a ton I’d guess. Well at least we're not gonna run out of anime any time soon. Now all we need is a DVD player and electricity.
"
]] call BIS_fnc_initLeaflet;

//21
["init", [readable_21, "images\paper2.paa",
"
<t size='2'>Military Note #1:</t><br/>
To all soldiers manning the checkpoint.<br/><br/>

Please make sure to always carry your weapon(s) on your person and to always keep the safety on! The number of civilians camping close to the checkpoint is increasing rapidly. The last thing we want is someone close to the checkpoint getting their hands on a gun and accidentally or not firing it off.<br/><br/>

Keep in mind that failing to follow this order will be rewarded with a severe disciplinary punishment.
"
]] call BIS_fnc_initLeaflet;

//22
["init", [readable_22, "images\paper2.paa",
"
<t size='2'>Military Note #2:</t><br/>
Important notice concerning the decontamination showers:<br/><br/>

Do not leave the decontamination showers on needlessly! A full supply tank will only last about 15 minutes if the showers are left on. Several tanks full of decontamination liquid have already been wasted by leaving the showers running in between individual decontamination processes.<br/><br/>

If you are caught wasting water you’ll get the cost of such a tank subtracted from your paycheck.
"
]] call BIS_fnc_initLeaflet;

//23
["init", [readable_23, "images\paper2.paa",
"
<t size='2'>Military Note #3:</t><br/>
Sergeant Sawicki,<br/><br/>

Your platoon is to deliver the chemical containers that you received this morning to the surrounding villages by the end of tomorrow. For detailed information concerning the exact locations please refer to attachment A of this document. Per location you will have to deliver two of the cylindrical and two of the rectangular containers, making it four in total. The usage for these containers can not be disclosed at this time, however handle them with care and do not open them. Make sure all your boys wear protective gear when working with them. Report back when the delivery has been completed.<br/><br/>

Signed, Lieutenant Piotrowski
"
]] call BIS_fnc_initLeaflet;

//24
["init", [readable_24, "images\paper2.paa",
"
<t size='2'>Military Note #4:</t><br/>
Relocation Order Notice<br/><br/>

Protocol C20 is going to be executed and evacuation zone F is now considered a failure. Prior to the execution all important military equipment currently present in Gieraltow must be relocated to Station F3 north east of the town. All the equipment has to be loaded into CBRN secure containers and it must be made sure that these containers are properly sealed before loading them onto transportation. Furthermore, an effort will be made to give citizens currently residing in evacuation zone F a chance to evacuate from the area that is going to be affected. In this effort all available military personnel are to assist the local population in any capacity they can. Protocol C20 will take action 24 hours after all the equipment has reached Station F3.
"
]] call BIS_fnc_initLeaflet;

//25
["init", [readable_25, "images\paper2.paa",
"
<t size='2'>Police Note:</t><br/>
Information on Evacuation Procedures.<br/><br/>

During the evacuation phase all police personnel is to support the military in its evacuation related tasks. That mostly means handing out the Evacuation Notices to citizens and offering help to those that want it.<br/><br/>

People with impaired mobility: Citizens that have trouble walking and need assistance, such as people in wheelchairs, must be delivered to Evacuation Zone C as it is the only one featuring barrier-free accommodations. Senior citizens that confided to bed and unable to move at all, may be exempt from the evacuation process including their assigned caretaker.<br/><br/>

People that refuse to be evacuated shall be noted down in the form of: [Forename Surname] [Address] [Stated reason for refusal]. These notes shall then be forwarded to the closest military checkpoint.<br/><br/>

Pregnant women and families with children under the age of 3 shall also be directed towards Evacuation Zone C, including all core members of the family: Father, Mother and Children.<br/><br/>

For more information or questions concerning the evacuation procedures please use the following e-mail: <t color='#4169E1'>evac.procedures@govt.lva</t>
"
]] call BIS_fnc_initLeaflet;

//26
["init", [readable_26, "images\paper2.paa",
"
<t size='2'>Hospital Note:</t><br/>
To whom it may concern,<br/><br/>

During the upcoming week, military personnel will deliver several containers to your location: [Hospital Gieraltow]<br/><br/>

For this you will have to prepare a storage area that is both restricted to as few people as possible and below 35° Celsius without any direct sunlight. People having access to this storage area must be informed to not touch or otherwise interact with the containers in any way as it could have dire consequences for the entire surrounding area. Furthermore a/the key or keycard accessing the storage area must be handed over to the team delivering the containers.<br/><br/>

For further questions, please consult the delivery team.<br/>
Signed, Dudek Krystian chairman of the National Committee of Evacuation Plans
"
]] call BIS_fnc_initLeaflet;

//27
["init", [readable_27, "images\paper2.paa",
"
<t size='2'>Survivor Note #5:</t><br/>
If you’re one of those ‘evacuation soldiers’:<br/>
I’m currently no longer residing in my home as you leave me no other choice. To think that you people would go as far as asking us to leave behind our pets for some stupid training excersise or whatever it is you are doing. But I will have none of it. I’ll just take my dog and camp outside your restricted zone until this ‘joke’ is over. If me or my dog get hurt, know it’s on you for trying to make an old man abandon his dog.<br/><br/>

P.S.: I hope you fall down the stairs on the way down.
"
]] call BIS_fnc_initLeaflet;

//28
["init", [readable_28, "images\paper2.paa",
"
<t size='2'>Survivor Note #6:</t><br/>
Hey man, first of all sorry that it took me so long to deliver last time, but it’s getting harder and harder to bring shit across the border. This time I almost got caught 3 times, I even had to temporarily leave behind some of the good shit. Gonna go back and grab it later, then bring it to you. Either way, I was able to bring some of the stuff with me, but it isn’t at the usual drop off point since I saw some police walk around there. To find it just go right from the church up the dirtway. Once you come across the lamppost on the left side the crate is somewhere in a bush there real close. Hope you have no troubles finding it. I’ll call you when I got my hands on the other shit.
"
]] call BIS_fnc_initLeaflet;

//29
["init", [readable_29, "images\paper2.paa",
"
<t size='2'>Survivor Note #7:</t><br/>
Dear people from Customer Service<br/><br/>

I’m pleased by the fact that the repair people you guys send are always so swift in their work when fixing my air-conditioner, however I am starting to get very very angry. This has been the third time it broke this season. I don’t know why, maybe the product is faulty, maybe it hasn’t been set up correctly, or maybe the repair people are rushing their work and overseeing something critical. Whatever the reason may be I hope the next time you show up will be the last time for a while. I have a 2 year old baby and a wife that both can’t sleep in this heat, so please treat this urgently.<br/><br/>

Best regards<br/>
Mazur Rudolf
"
]] call BIS_fnc_initLeaflet;

//30
["init", [readable_30, "images\paper2.paa",
"
<t size='2'>Crumpled Note #3:</t><br/>
03.08.36<br/>
Fucking Christ, just raced the wind for my life. Slept a little bit longer today and was just heading to the military checkpoint between Wrzeszcz and Gieraltow to help raise the numbers of the people trying to pass through. When I wasn’t all that far away anymore I noticed people doing really weird shit. Running towards me, flailing their arms around, holding their throats and such, didn’t take me too long to figure out what was going on when I looked at the soldiers standing there with hazard suits on. Started sprinting back home as fast as I could to put my respirator on. Still can’t believe what they’ve done. ( I wonder what happened to all the people inside Gieraltow ) After that there was finally some answers on the radio. Apparently negotiations that weren’t made public concerning distribution of food, water and living space across the globe have broken down horribly with some countries declaring war on others. Our government is planning to use those chemicals I’ve seen in action today to protect areas where supplies are stored and hand out food and water in the evacuation zones. However there was no information on how long the government plans on doing this and neither how long the food and water would last for all of us. Either way I don’t wanna rely on handouts if I don’t have to, hopefully in a couple of days the chemicals are gone. Then I’ll see what I can do about securing myself some more supplies.
"
]] call BIS_fnc_initLeaflet;

//31
["init", [readable_31, "images\paper2.paa",
"
<t size='2'>Crumpled Note #4:</t><br/>
21.09.36<br/>
Been about a month since they unleashed the chemicals and you can’t even get anywhere near Gieraltow. Doesn’t mean I’ve only been sitting on my ass. Snuck around and saw some people trying to get close to the town, but they’ve either been stopped by soldiers in the area or ran away choking when they got too close. ( I think I’ve even seen a guy dying ) Other people don’t concern me much however and thanks to the incompetence of the LDF I was able to secure myself quite a bit of lot. Over the past few weeks I’ve been closely observing where they patrol and what they are doing. During the day they are mostly occupied with laying mines ( as if the chemicals weren’t enough ), but during the night besides a couple of soldiers manning the checkpoint, most of them seem to go to Gieraltow or maybe even further east. ( not like I can follow them ). Either way, I’ve noticed that a tent and some showers or something right besides the checkpoint are pretty much unobserved and I was able to swoop in last night and get a box of MREs and a box of water. I also took one of their chemical containers, not sure how to use it and I’m not planning on doing it anytime soon but who knows, might come in handy in the future. Left it in front of the door however, don’t really feel comfortable to sleep with that thing in the house.
"
]] call BIS_fnc_initLeaflet;

//32
["init", [readable_32, "images\paper2.paa",
"
<t size='2'>Sermon Excerpt:</t><br/>
...<br/>
And I looked, and behold a pale horse: and his name that sat on him was Death, and Hell followed with him. And power was given unto them over the fourth part of the earth, to kill with sword, and with hunger, and with death, and with the beasts of the earth.<br/>
And when he had opened the fifth seal, I saw under the altar the souls of them that were slain for the word of God, and for the testimony which they held:<br/>
And they cried with a loud voice, saying, How long, O Lord, holy and true, dost thou not judge and avenge our blood on them that dwell on the earth?<br/>
And white robes were given unto every one of them; and it was said unto them, that they should rest yet for a little season, until their fellow servants also and their brethren, that should be killed as they were, should be fulfilled.<br/>
...
"
]] call BIS_fnc_initLeaflet;

//CHANGE TEXTURES//////////////////////////////////////////////////////////////////////////////////
{_x setObjectTexture [0,"images\paper3.paa"];} forEach [readable_5,readable_6,readable_7,readable_8,readable_9,readable_10,readable_11,readable_12,readable_13,readable_14,readable_19,readable_20,readable_21,readable_22,readable_24,readable_25,readable_26,readable_27,readable_28,readable_29,readable_30,readable_31,readable_32];
{_x setObjectTexture [0,"#(argb,8,8,3)color(0.835294,0,0,0.0,ca)"];} forEach [readable_18,readable_23];
{_x setObjectTexture [0,"a3\props_f_enoch\items\documents\data\newspaper_01_co.paa"];} forEach [readable_0,readable_1,readable_2,readable_3,readable_4,readable_15,readable_16,readable_17];