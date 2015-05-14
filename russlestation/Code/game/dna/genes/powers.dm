
///////////////////////////////////
// POWERS
///////////////////////////////////

/datum/dna/gene/basic/nobreath
	name="No Breathing"
	activation_messages=list("You feel no need to breathe.")
	deactivation_messages=list("You fell the need to breathe again.")
	mutation=mNobreath

	New()
		block=NOBREATHBLOCK

/datum/dna/gene/basic/remoteview
	name="Remote Viewing"
	activation_messages=list("Your mind expands.")
	deactivation_messages=list("Your mind returns to normal.")
	mutation=mRemote

	New()
		block=REMOTEVIEWBLOCK

	activate(var/mob/M, var/connected, var/flags)
		..(M,connected,flags)
		M.verbs += /mob/living/carbon/human/proc/remoteobserve

/datum/dna/gene/basic/regenerate
	name="Regenerate"
	activation_messages=list("You feel better.")
	mutation=mRegen

	New()
		block=REGENERATEBLOCK

/datum/dna/gene/basic/increaserun
	name="Super Speed"
	activation_messages=list("Your leg muscles pulsate.")
	deactivation_messages=list("You start to slow down.")
	mutation=mRun

	New()
		block=INCREASERUNBLOCK

/datum/dna/gene/basic/remotetalk
	name="Telepathy"
	activation_messages=list("You expand your mind outwards.")
	deactivation_messages=list("Your mind returns to you.")
	mutation=mRemotetalk

	New()
		block=REMOTETALKBLOCK

	activate(var/mob/M, var/connected, var/flags)
		..(M,connected,flags)
		M.verbs += /mob/living/carbon/human/proc/remotesay

/datum/dna/gene/basic/morph
	name="Morph"
	activation_messages=list("Your skin feels strange.")
	deactivation_messages=list("Your skin no longer feels strange.")
	mutation=mMorph

	New()
		block=MORPHBLOCK

	activate(var/mob/M)
		..(M)
		M.verbs += /mob/living/carbon/human/proc/morph

//Not used on bay. Also possibly broken ~Aztec
/datum/dna/gene/basic/heat_resist
	name="Heat Resistance"
	activation_messages=list("Your skin is icy to the touch.")
	mutation=mHeatres

	New()
		block=COLDBLOCK

	can_activate(var/mob/M,var/flags)
		if(flags & MUTCHK_FORCED)
			return !(/datum/dna/gene/basic/cold_resist in M.active_genes)
		// Probability check
		var/_prob = 15
		if(COLD_RESISTANCE in M.mutations)
			_prob=5
		if(probinj(_prob,(flags&MUTCHK_FORCED)))
			return 1

	OnDrawUnderlays(var/mob/M,var/g,var/fat)
		return "cold[fat]_s"


/datum/dna/gene/basic/cold_resist
	name="Cold Resistance"
	activation_messages=list("Your body is filled with warmth.")
	deactivation_messages=list("Your body returns to normal.")
	mutation=COLD_RESISTANCE

	New()
		block=FIREBLOCK

	can_activate(var/mob/M,var/flags)
		if(flags & MUTCHK_FORCED)
			return 1
		//	return !(/datum/dna/gene/basic/heat_resist in M.active_genes)
		// Probability check
		var/_prob=30
		//if(mHeatres in M.mutations)
		//	_prob=5
		if(probinj(_prob,(flags&MUTCHK_FORCED)))
			return 1

	OnDrawUnderlays(var/mob/M,var/g,var/fat)
		return "fire[fat]_s"

/datum/dna/gene/basic/noprints
	name="No Prints"
	activation_messages=list("Your fingers feel numb.")
	deactivation_messages=list("Your fingerprints have grown back.")
	mutation=mFingerprints

	New()
		block=NOPRINTSBLOCK

/datum/dna/gene/basic/noshock
	name="Shock Immunity"
	activation_messages=list("Your skin feels strange.")
	deactivation_messages=list("Your skin returns to normal.")
	mutation=mShock

	New()
		block=SHOCKIMMUNITYBLOCK

/datum/dna/gene/basic/midget
	name="Midget"
	activation_messages=list("Your skin feels rubbery.")
	deactivation_messages=list("Your skin returns to normal.")
	mutation=mSmallsize

	New()
		block=SMALLSIZEBLOCK

	can_activate(var/mob/M,var/flags)
		// Can't be big and small.
		if(HULK in M.mutations)
			return 0
		return ..(M,flags)

	activate(var/mob/M, var/connected, var/flags)
		..(M,connected,flags)
		M.pass_flags |= 1

	deactivate(var/mob/M, var/connected, var/flags)
		..(M,connected,flags)
		M.pass_flags &= ~1 //This may cause issues down the track, but offhand I can't think of any other way for humans to get passtable short of varediting so it should be fine. ~Z

/datum/dna/gene/basic/hulk
	name="Hulk"
	activation_messages=list("Your muscles hurt.")
	deactivation_messages=list("You calm down.")
	mutation=HULK

	New()
		block=HULKBLOCK

	can_activate(var/mob/M,var/flags)
		// Can't be big and small.
		if(mSmallsize in M.mutations)
			return 0
		return ..(M,flags)

	OnDrawUnderlays(var/mob/M,var/g,var/fat)
		if(fat)
			return "hulk_[fat]_s"
		else
			return "hulk_[g]_s"
		return 0

	OnMobLife(var/mob/living/carbon/human/M)
		if(!istype(M)) return
		if(M.health <= 25)
			M.mutations.Remove(HULK)
			M.update_mutations()		//update our mutation overlays
			M << "\red You suddenly feel very weak."
			M.Weaken(3)
			M.emote("collapse")

/datum/dna/gene/basic/xray
	name="X-Ray Vision"
	activation_messages=list("The walls suddenly disappear.")
	deactivation_messages=list("The walls suddenly reappear.")
	mutation=XRAY

	New()
		block=XRAYBLOCK

/datum/dna/gene/basic/tk
	name="Telekenesis"
	activation_messages=list("You feel smarter.")
	deactivation_messages=list("You mind returns to normal.")
	mutation=TK
	activation_prob=15

	New()
		block=TELEBLOCK
	OnDrawUnderlays(var/mob/M,var/g,var/fat)
		return "telekinesishead[fat]_s"

/datum/dna/gene/basic/muscles
	name="Muscular"
	activation_messages=list("You feel stronger.")
	deactivation_messages=list("You feel weak again.")
	mutation=gMuscles
	activation_prob=0

/datum/dna/gene/basic/weak
	name="Weak"
	activation_messages=list("You feel weak.")
	deactivation_messages=list("You feel normal again.")
	mutation=gWeak
	activation_prob=0

/datum/dna/gene/basic/Regenslow
	name="Regenerative"
	activation_messages=list("Your skin feels frail")
	deactivation_messages=list("Your skin no longer feels frail")
	mutation=gRegenslow
	activation_prob=0

/datum/dna/gene/basic/hypersensitive
	name="Hypersensitive"
	activation_messages=list("You feel that stuns last longer now")
	deactivation_messages=list("You feel that stuns go away quicker now")
	mutation=gHypersensitive
	activation_prob=0