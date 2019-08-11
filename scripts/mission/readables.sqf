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
	readable_31
];

//DEBUG////////////////////////////////////////////////////////////////////////////////////////////
private _debug = true;
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

{["init", [_x, "images\paper2.paa",
"
<t size='2'>What is the Government planning?</t><br/>
23.04.2036 by Albin Nowak<br/><br/>

Many of you might have noticed the increase of military presence in our towns and villages. Soldiers in strange suits carrying suitcases and other items into shops, hospitals and the like, only to emerge empty handed shortly after, at which point they proceed to load back into their armored trucks and disappear without a trace. As if that was not weird enough, peculiar metal constructions can be seen along the roads when driving from town to town, many of which are guarded by heavily armed soldiers. What does it all mean?<br/><br/>

A source that wants to remain anonymous might be able to shine some light on the event unfolding before us. According to him the strange suits these soldiers are wearing are so called ‘CBRN’ suits, which armies are using to protect their soldiers against so called ‘chemical warfare’. For clarification on what that kind of war would look like, one could read up on the horrible use of ‘mustard gas’ during the first World War. On the other hand the previously mentioned metal constructs seem to be decontamination showers, used to wash off particles left behind by some of these chemical attacks.<br/><br/>

Sadly this source does not know as to why the LDF are doing what they are doing. His best guess was that they are currently undergoing a large scale training exercise. However if they are actually preparing for chemical warfare then two new questions arise. Who would attack Livonia and what will happen to us, the ones that don’t have fancy suits to protect themselves?
"
]] call BIS_fnc_initLeaflet;} forEach [readable_1,readable_2,readable_3,readable_4];

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

["init", [readable_10, "images\paper2.paa",
"
<t size='2'>Crumpled Note #1:</t><br/>
28.05.36<br/>
What a bunch of crap! Leaving all my shit behind for some stupid evacuation zone and hoping these underpaid moron soldiers won’t steal anything? I don’t think so. I’ll use the remaining days I got until they lock this place up for good, to slowly smuggle all my important shit up the road to my old parents house. That place has been abandoned for years, gives me the creeps to be there at night but what other choice do I have, I don’t want everybody in the village including the soldiers to know what I’m doing, now do I?
"
]] call BIS_fnc_initLeaflet;

["init", [readable_11, "images\paper2.paa",
"
<t size='2'>Crumpled Note #2:</t><br/>
31.05.36<br/>
Well, last day of the evacuation period. I still have no plans to go to one of those crowded evacuation zones. I’ll just head to Wrzeszcz and buy myself supplies for a few weeks and camp out in my old parents house. Besides, I wanna keep an eye on what those morons are gonna do when they think they are unobserved.<br/>
----<br/>
Just got back from the store, didn’t get as many supplies as I wanted to, however one thing I noticed is that the news must’ve really put some fear in people since they are selling respirators now. I’m not particularly concerned that any country would care about small Livonia but hey, they were pretty cheap and I mean it doesn’t hurt to have one right? Either way, time to pack up and get going.
"
]] call BIS_fnc_initLeaflet;

["init", [readable_12, "images\paper2.paa",
"
<t size='2'>Survivor Note #1:</t><br/>
If you read this:<br/>
This is the fourth ransacked store we’ve come across, this message is meant to save you some time if you planned on looking for supplies in here, there is nothing edible left. We are going further east, since there seems to be nothing left anywhere close in the west.<br/><br/>

P.S.: Isn’t it concerning how scarce supplies have become in a matter of only 2 years.
"
]] call BIS_fnc_initLeaflet;

["init", [readable_13, "images\paper2.paa",
"
<t size='2'>Survivor Note #2:</t><br/>
Maja, don’t go to the evacuation zones. Take the children and leave the country. Just go and stay at your sisters place in Poland. I have asked my commanding officer about the evacuation zones and these containers we are delivering to almost every village and he said he doesn’t know either. He said he knows that these containers are filled with some sort of chemicals or something and that he heard the evacuation zones are only meant to temporarily house the civilians while something is being set up. Whatever it is I don’t think it’s something good. Why would they not tell us what we are doing if it was good?<br/><br/>

Please go to your sister, I will write you a letter when I know more. I love you, don’t let anyone know I told you this or I could get in serious trouble. Especially Zofia! She always had a loose mouth.
"
]] call BIS_fnc_initLeaflet;

["init", [readable_14, "images\paper2.paa",
"
<t size='2'>Survivor Note #3:</t><br/>
If you are from the news read this, if you aren’t then take this to someone who is!<br/><br/>

I don’t have much time so I’ll keep this short. My brother just died in my arms and it’s the armies’ fault. Me, my brother and several others from the village were fed up with the lack of water and food, so we decided to confront the soldiers stationed closest to us in Gieraltow. Since they always seem to have enough food and water, we figured they could share some with the people outside Gieraltow. However they wanted to shoo us away as if we were some hungry annoying animals and when we got angry and things escalated it happened. One of the soldiers shot and it hit my brother in the stomach. We screamed at them he needs help but they just pointed their weapons at us so we quickly backed off. By the time we got to a car my brother was no longer conscious and by the time we were back in Wrzeszcz he was already dead.<br/><br/>

Anyway, when we left I could hear the soldiers talk about ‘what to do now’ and their voices seemed nervous. I’m not sure what they are planning to do, but I sure as hell won’t stick around to find out. I leave this note here with my brother in case something happens to me. I hope that someone from the news comes by and tells everybody what the LDF has done!<br/><br/>

Signed, Eryk Zajac. 24.07.2036
"
]] call BIS_fnc_initLeaflet;

{["init", [_x, "images\paper2.paa",
"
<t size='2'>The Crowded 'Evacuation Zones'</t><br/>
18.07.2036 by Albin Nowak<br/><br/>

If you are currently residing in one of the evacuation camps the military has set up this might not be news to you. But only about two and a half months after the government of Livonia has first issued the evacuation notice, the frustration of the people with the lack of space, food and privacy is already reaching a dangerous level.<br/><br/>

With zero explanations from the government and the borderline violent attitude of the military when enforcing order in the camps, the divide between the people and the state is growing bigger by the day. People fed up with this situation are leaving the camps by the dozens with one goal in mind: ‘Going back home.’ Large crowds can be seen outside most villages and towns that have been evacuated, demanding to be let back into their homes. Traffic jams on borders and checkpoints that have been closed for about a week now, are getting bigger and bigger and the large group of protesters in front of the parliament in Andrzejów have declared they will not leave until they have gotten answers.<br/><br/>

A lot of you reading this might wonder when everything will go back to normal and why there is no clear answer to many of the questions that might go through your head. That does not mean there is nothing you can do. Head over to https://www.livonia-deserves-answers.lva and inform yourself about how you can help make the government talk.
"
]] call BIS_fnc_initLeaflet;} forEach [readable_15,readable_16,readable_17];

["init", [readable_18, "images\paper2.paa",
"
<t size='2'>Survivor Note #4:</t><br/>
I’m fairly certain yesterday while navigating the minefield I almost died. The crazy thing is that it wasn’t due to a mine, no it was way crazier than that.<br/><br/>

I was just taking a break from walking, eating my ravioli, when I heard some screaming from like a hundred meters away. I quickly got up into a crouch and hid behind the tree. What I saw next was unbelievable: There was a group of people that looked almost tribal, they had really rustical weapons like machetes and they were almost naked. When I looked a little bit closer I noticed some of them were holding down a man while others seemed to bite him. And sure enough that was what they were doing. For the next 2 hours I crouched behind this tree unable to move and scared like hell they would discover me. It was gruesome hearing the man scream with every bite they took until it eventually stopped. After it was all over they flung ‘the rests’ across their shoulders and walked off. What’s really strange about this too is that they did that in the middle of a god damn minefield, it's almost as if they knew where every single mine was.<br/><br/>

Anyway, that will be the last time I venture this far north.
"
]] call BIS_fnc_initLeaflet;

["init", [readable_19, "images\paper2.paa",
"
<t size='2'>MSR Note #1:</t><br/>
Well, guess I’m far from the only one that is sick and tired and just wants to go home. And we could, if it wasn’t for the government's right hand the LDF. Dogs following their master's orders without any thought about what they are actually doing. Either way, there is a couple of guys that plan on just rallying some more people and walk right through the checkpoint. What are they gonna do, shoot us? We live in that village! How can it be that only because some of us were out of town while the evacuation happened, we now can’t enter merely because we don’t have our papers with us. Could they not just let us in and then we could proof we really belong to the village? I thought all evacuation zones were supposed to be public places that anyone could enter and seek shelter in, but apparently there is certain ‘quotas’ that they have to keep.
"
]] call BIS_fnc_initLeaflet;

["init", [readable_20, "images\paper2.paa",
"
<t size='2'>MSR Note #2:</t><br/>
There is a large black safe in the back of this truck. I bet you wonder what could be in there. A shitload of money, gold or jewelry? Well, guess you’ll never know. My crew and I tried to crack this piece of shit in several ways already, but I guess unless you’ve got a thermal lance or something like that you can absolutely forget getting into that piece of crap. Oh yeah and nevermind trying to take it with you, it is anchored into the truck and weighs more than a ton I’d guess. Well at least we're not gonna run out of anime any time soon. Now all we need is a DVD player and electricity.
"
]] call BIS_fnc_initLeaflet;

//CHANGE TEXTURES//////////////////////////////////////////////////////////////////////////////////
{_x setObjectTexture [0,"images\paper3.paa"];} forEach [readable_5,readable_6,readable_7,readable_8,readable_9,readable_10,readable_11,readable_12,readable_13,readable_14,readable_19,readable_20];
{_x setObjectTexture [0,"#(argb,8,8,3)color(0.835294,0,0,0.0,ca)"];} forEach [readable_18];
{_x setObjectTexture [0,"a3\props_f_enoch\items\documents\data\newspaper_01_co.paa"];} forEach [readable_0,readable_1,readable_2,readable_3,readable_4,readable_15,readable_16,readable_17];