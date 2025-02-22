#define CULT_ELDERGOD "eldergod"
#define CULT_SLAUGHTER "slaughter"

/obj/item/melee/cultblade/dagger
	name = "ritual dagger"
	desc = "A strange dagger said to be used by sinister groups for \"preparing\" a corpse before sacrificing it to their dark gods."
	icon_state = "blood_dagger"
	item_state = "blood_dagger"
	w_class = WEIGHT_CLASS_SMALL
	force = 15
	throwforce = 25
	armour_penetration = 35
	sprite_sheets_inhand = null // Override parent
	var/drawing_rune = FALSE
	var/scribe_multiplier = 1 // Lower is faster

/obj/item/melee/cultblade/dagger/adminbus
	name = "ritual dagger of scribing, +1"
	desc = "VERY fast culto scribing at incredible hihg speed"
	force = 16
	scribe_multiplier = 0.1


/obj/item/melee/cultblade/dagger/Initialize(mapload)
	. = ..()
	update_icon(UPDATE_ICON_STATE)


/obj/item/melee/cultblade/dagger/update_icon_state()
	if(SSticker?.cultdat)
		icon_state = SSticker.cultdat.dagger_icon
		item_state = SSticker.cultdat.dagger_icon
	else
		icon_state = initial(icon_state)
		item_state = initial(item_state)


/obj/item/melee/cultblade/dagger/examine(mob/user)
	. = ..()
	if(iscultist(user) || user.stat == DEAD)
		. += "<span class='cult'>A dagger gifted by [SSticker.cultdat.entity_title3]. Allows the scribing of runes and access to the knowledge archives of the cult of [SSticker.cultdat.entity_name].</span>"
		. += "<span class='cultitalic'>Striking another cultist with it will purge holy water from them.</span>"
		. += "<span class='cultitalic'>Striking a noncultist will tear their flesh.</span>"


/obj/item/melee/cultblade/dagger/attack(mob/living/target, mob/living/user, params, def_zone, skip_attack_anim = FALSE)
	if(iscultist(target))
		if(target.reagents?.has_reagent("holywater")) //allows cultists to be rescued from the clutches of ordained religion
			if(target == user) // Targeting yourself
				to_chat(user, span_warning("You can't remove holy water from yourself!"))
			else // Targeting someone else
				to_chat(user, span_cult("You remove the taint from [target]."))
				to_chat(target, span_cult("[user] removes the taint from your body."))
				var/amount = target.reagents.get_reagent_amount("holywater")
				target.reagents.del_reagent("holywater")
				target.reagents.add_reagent("unholywater", amount)
				add_attack_logs(user, target, "Hit with [src], removing the holy water from them")
		return ATTACK_CHAIN_BLOCKED_ALL
	return ..()


/obj/item/melee/cultblade/dagger/attack_self(mob/user)
	if(!iscultist(user))
		to_chat(user, "<span class='warning'>[src] is covered in unintelligible shapes and markings.</span>")
		return
	scribe_rune(user)

/obj/item/melee/cultblade/dagger/proc/narsie_rune_check(mob/living/user, area/A)
	var/datum/game_mode/gamemode = SSticker.mode

	if(gamemode.cult_objs.cult_status < NARSIE_NEEDS_SUMMONING)
		to_chat(user, "<span class='cultitalic'><b>[SSticker.cultdat.entity_name]</b> is not ready to be summoned yet!</span>")
		return FALSE
	if(gamemode.cult_objs.cult_status == NARSIE_HAS_RISEN)
		to_chat(user, "<span class='cultlarge'>\"I am already here. There is no need to try to summon me now.\"</span>")
		return FALSE
	if(!(gamemode.cult_ascendant))
		to_chat(user, "<span class='cultlarge'>Not enough unfaithful know what awaits them! The cult must ascend first!</span>")
		return FALSE

	var/list/summon_areas = gamemode.cult_objs.obj_summon.summon_spots
	if(!(A in summon_areas))
		to_chat(user, "<span class='cultlarge'>[SSticker.cultdat.entity_name] can only be summoned where the veil is weak - in [english_list(summon_areas)]!</span>")
		return FALSE
	var/confirm_final = tgui_alert(user, "This is the FINAL step to summon your deities power, it is a long, painful ritual and the crew will be alerted to your presence AND your location!",
	"Are you prepared for the final battle?", list("My life for [SSticker.cultdat.entity_name]!", "No"))
	if(user)
		if(confirm_final != "My life for [SSticker.cultdat.entity_name]!")
			to_chat(user, "<span class='cultitalic'><b>You decide to prepare further before scribing the rune.</b></span>")
			return FALSE
		else
			if(locate(/obj/effect/rune) in range(1, user))
				to_chat(user, "<span class='cultlarge'>You need a space cleared of runes before you can summon [SSticker.cultdat.entity_title1]!</span>")
				return FALSE
			else
				return TRUE

/obj/item/melee/cultblade/dagger/proc/can_scribe(mob/living/user)
	if(!src || !user || loc != user || user.incapacitated())
		return FALSE
	var/turf/T = get_turf(user)
	if(isspaceturf(T))
		return FALSE
	if((locate(/obj/effect/rune) in T) || (locate(/obj/effect/rune/narsie) in range(1, T)))
		to_chat(user, "<span class='warning'>There's already a rune here!</span>")
		return FALSE
	if(drawing_rune)
		to_chat(user, "<span class='warning'>You can't draw multiple runes at the same time!</span>")
		return FALSE
	return TRUE


/obj/item/melee/cultblade/dagger/proc/scribe_rune(mob/living/user)
	var/list/shields = list()
	var/list/possible_runes = list()
	var/keyword

	if(!can_scribe(user)) // Check this before anything else
		return

	// Choosing a rune
	for(var/I in (subtypesof(/obj/effect/rune) - /obj/effect/rune/malformed))
		var/obj/effect/rune/R = I
		var/rune_name = initial(R.cultist_name)
		if(rune_name)
			possible_runes[rune_name] = R
	if(!length(possible_runes))
		return

	var/chosen_rune = tgui_input_list(user, "Choose a rite to scribe", "Sigils of Power", possible_runes)
	if(!chosen_rune)
		return
	var/obj/effect/rune/rune = possible_runes[chosen_rune]
	var/narsie_rune = FALSE
	if(rune == /obj/effect/rune/narsie)
		narsie_rune = TRUE
	if(initial(rune.req_keyword))
		keyword = tgui_input_text(user, "Please enter a keyword for the rune.", "Enter Keyword")
		if(!keyword)
			return

	// Check everything again, in case they moved
	if(!can_scribe(user))
		return

	// Check if the rune is allowed
	var/area/A = get_area(src)
	var/turf/runeturf = get_turf(user)
	var/datum/game_mode/gamemode = SSticker.mode
	if(ispath(rune, /obj/effect/rune/summon))
		if(!is_station_level(runeturf.z) || istype(A, /area/space))
			to_chat(user, "<span class='cultitalic'>The veil is not weak enough here to summon a cultist, you must be on station!</span>")
			return

	var/old_color = user.color  // we'll temporarily redden the user for better feedback to fellow cultists. Store this to revert them back.
	if(narsie_rune)
		if(!narsie_rune_check(user, A))
			return // don't do shit
		var/list/summon_areas = gamemode.cult_objs.obj_summon.summon_spots
		if(!(A in summon_areas))  // Check again to make sure they didn't move
			to_chat(user, "<span class='cultlarge'>The ritual can only begin where the veil is weak - in [english_list(summon_areas)]!</span>")
			return
		for(var/datum/mind/M in gamemode.cult)
			if(M.current)
				SEND_SOUND(M.current, 'sound/ambience/antag/bloodcult_scribe.ogg')
		GLOB.command_announcement.Announce("Образы внепространственного бога из неизвестного измерения собираются воедино в [A.map_name]. Сорвите ритуал любой ценой, пока станция не была уничтожена! Действие космического закона и стандартных рабочих процедур приостановлено. Весь экипаж должен уничтожать культистов на месте.", "Отдел Центрального Командования по делам высших измерений.", 'sound/AI/spanomalies.ogg')
		log_admin("[key_name_log(user)] started to draw narsie rune!")
		add_game_logs("started to draw narsie rune at [AREACOORD(user)]", user)
		for(var/I in spiral_range_turfs(1, user, 1))
			var/turf/T = I
			var/obj/machinery/shield/cult/narsie/N = new(T)
			shields |= N
		user.color = "red"

	// Draw the rune
	var/mob/living/carbon/human/H = user
	drawing_rune = TRUE
	H.cult_self_harm(initial(rune.scribe_damage))
	var/others_message
	if(!narsie_rune)
		others_message = "<span class='warning'>[user] cuts [user.p_their()] body and begins writing in [user.p_their()] own blood!</span>"
	else
		others_message = "<span class='biggerdanger'>[user] cuts [user.p_their()] body and begins writing something particularly ominous in [user.p_their()] own blood!</span>"
	user.visible_message(others_message,
		"<span class='cultitalic'>You slice open your body and begin drawing a sigil of [SSticker.cultdat.entity_title3].</span>")

	var/scribe_successful = do_after(user, initial(rune.scribe_delay) * scribe_multiplier, runeturf)
	for(var/V in shields) // Only used for the 'Tear Veil' rune
		var/obj/machinery/shield/S = V
		if(S && !QDELETED(S))
			qdel(S)
	user.color = old_color
	if(!scribe_successful)
		drawing_rune = FALSE
		return

	user.visible_message("<span class='warning'>[user] creates a strange circle in [user.p_their()] own blood.</span>",
						 "<span class='cultitalic'>You finish drawing the arcane markings of [SSticker.cultdat.entity_title3].</span>")

	var/obj/effect/rune/R = new rune(runeturf, keyword)
	drawing_rune = FALSE
	if(narsie_rune)
		for(var/obj/effect/rune/I in orange(1, R))
			qdel(I)

	R.blood_DNA = list()
	R.blood_DNA[H.dna.unique_enzymes] = H.dna.blood_type
	R.add_hiddenprint(H)
	R.color = H.dna.species.blood_color
	R.rune_blood_color = H.dna.species.blood_color
	to_chat(user, "<span class='cult'>The [lowertext(initial(rune.cultist_name))] rune [initial(rune.cultist_desc)]</span>")
