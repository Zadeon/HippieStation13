/obj/item/weapon/implant/mind_slave
	name = "mindslave implant"
	desc = "Makes whoever is implanted loyal to the implanter."
	origin_tech = "materials=2;biotech=4;programming=4"
	activated = 0
	var/timerid
	var/slavememory

/obj/item/weapon/implant/mind_slave/get_data()
	var/dat = {"<b>Implant Specifications:</b><BR>
				<b>Name:</b> Syndicate Mindslave implant MK1<BR>
				<b>Life:</b> Varies between 15 and 20 minutes.<BR>
				<b>Important Notes:</b> Personnel injected with this device become loyal to the user and will obey any command given for a limited time.<BR>
				<HR>
				<b>Implant Details:</b><BR>
				<b>Function:</b> Allows user to command anyone implanted to do whatever they want.<BR>
				<b>Special Features:</b> Person with implant MUST obey any order you give. <BR>
				<b>Integrity:</b> Implant will last around 15 and 20 minutes."}
	return dat

/obj/item/weapon/implant/mind_slave/implant(mob/target,mob/user)
	if(target == user)
		target <<"<span class='notice'>You can't implant yourself!</span>"
		return 0
	if(..())
		target << "<span class='notice'>You feel a surge of loyalty towards [user].</span>"
		target << "<span class='notice'>You MUST obey any command given to you (that doesn't violate any rules). You are an antag while mindslaved.</span>"
		var/time = 9000 + rand(60,300)
		timerid = addtimer(src,"remove_mindslave",time)
		target.mind.special_role = "Mindslave"
		slavememory = "<b>Your mindslave master is</b>: [user]. Obey any command they give you!"
		target.mind.store_memory(slavememory)
		return 1
	return 0

/obj/item/weapon/implant/mind_slave/removed(mob/source)
	deltimer(timerid)
	remove_mindslave()
	..()

/obj/item/weapon/implant/mind_slave/Destroy()
	deltimer(timerid)
	remove_mindslave()
	..()

/obj/item/weapon/implant/mind_slave/proc/remove_mindslave()
	if(imp_in)
		imp_in.mind.special_role = ""
		imp_in << "\red YO MAN THE GRIEFTIME IS OVER BECAUSE YOUR MINDSLAVE IMPLANT HAS EXPIRED. REMEMBER THAT YOU ARE NOW NO LONGER AN ANTAG, BUT YOU NO LONGER HAVE TO LISTEN TO YOUR MASTER."
		imp_in.memory -= slavememory

/obj/item/weapon/implanter/mind_slave
	name = "implanter (mind slave)"

/obj/item/weapon/implanter/mind_slave/New()
	imp = new /obj/item/weapon/implant/mind_slave(src)
	..()
	update_icon()


/* for backup reasons
/datum/uplink_item/implants/mind_slave
	name = "Mindslave Implant"
	desc = "An implant injected into another body, forcing the vitcim to obey any command by the user for a limited time."
	item = /obj/item/weapon/storage/box/syndie_kit/imp_mindslave
	cost = 9
	surplus = 20

/obj/item/weapon/storage/box/syndie_kit/imp_mindslave
	name = "Mindslave Implant (with injector)"

/obj/item/weapon/storage/box/syndie_kit/imp_mindslave/New()
	var/obj/item/weapon/implanter/O = new(src)
	O.imp = new /obj/item/weapon/implant/mind_slave(O)
	O.update_icon()
	..()
	return
*/