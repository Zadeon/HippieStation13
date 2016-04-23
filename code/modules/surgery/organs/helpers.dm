/mob/proc/getorgan(typepath)
	return

/mob/proc/getorganszone(zone)
	return

/mob/proc/getorganslot(slot)
	return

/mob/proc/getrandomorgan(zone, prob)
	return

/mob/living/carbon/getorgan(typepath)
	return (locate(typepath) in internal_organs)

/mob/living/carbon/getorganszone(zone, var/subzones = 0)
	var/list/returnorg = list()
	if(subzones)
		// Include subzones - groin for chest, eyes and mouth for head
		if(zone == "head")
			returnorg = getorganszone("eyes") + getorganszone("mouth")
		if(zone == "chest")
			returnorg = getorganszone("groin")

	for(var/obj/item/organ/internal/O in internal_organs)
		if(zone == O.zone)
			returnorg += O
	return returnorg

/mob/living/carbon/getorganslot(slot)
	for(var/obj/item/organ/internal/O in internal_organs)
		if(slot == O.slot)
			return O

/mob/living/carbon/human/getrandomorgan(zone, prob) //This is the same as get_organ(ran_zone) but it also makes sure that organ is actually attached/exists
	var/list/exceptions = list()
	for(var/obj/item/organ/limb/L in organs)
		if(L.state_flags & ORGAN_REMOVED)
			exceptions.Add(L)
	return get_organ(ran_zone(zone, prob, exceptions))

/mob/proc/getlimb()
	return

/mob/living/carbon/human/getlimb(typepath)
	return (locate(typepath) in organs)

/proc/isorgan(atom/A)
	return istype(A, /obj/item/organ/internal)