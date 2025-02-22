// Bluespace crystals, used in telescience and when crushed it will blink you to a random turf.
/obj/item/stack/ore/bluespace_crystal
	name = "bluespace crystal"
	desc = "A glowing bluespace crystal, not much is known about how they work. It looks very delicate."
	icon = 'icons/obj/telescience.dmi'
	icon_state = "bluespace_crystal"
	w_class = WEIGHT_CLASS_TINY
	materials = list(MAT_BLUESPACE = MINERAL_MATERIAL_AMOUNT)
	origin_tech = "bluespace=6;materials=3"
	points = 50
	var/blink_range = 8 // The teleport range when crushed/thrown at someone.
	refined_type = /obj/item/stack/sheet/bluespace_crystal
	toolspeed = 1
	usesound = 'sound/items/deconstruct.ogg'

/obj/item/stack/ore/bluespace_crystal/attack_self_tk(mob/user)
	return

/obj/item/stack/ore/bluespace_crystal/New(loc, new_amount, merge = TRUE)
	..()
	pixel_x = rand(-5, 5)
	pixel_y = rand(-5, 5)

/obj/item/stack/ore/bluespace_crystal/attack_self(var/mob/user)
	if(do_after(user, 1 SECONDS, user))
		var/mob/living/carbon/human/bs_user = user
		if(use(1))
			blink_mob(bs_user)
			bs_user.adjustStaminaLoss(33) // same as taser ; balance ideas - increase staminoloss / time to crush, move staminaLoss before blink or even do_after, replace if(do_after...) and if(use(1))
			bs_user.visible_message("<span class='notice'>[bs_user] crushes a [singular_name]!</span>")
	else
		to_chat(user, "<span class='notice'>You need to hold still to crush [singular_name].</span>")

/obj/item/stack/ore/bluespace_crystal/proc/blink_mob(var/mob/living/L)
	if(!is_teleport_allowed(L.z))
		src.visible_message("<span class='warning'>[src]'s fragments begin rapidly vibrating and blink out of existence.</span>")
		qdel(src)
		return
	do_teleport(L, get_turf(L), blink_range, asoundin = 'sound/effects/phasein.ogg')

/obj/item/stack/ore/bluespace_crystal/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	..()
	if(isliving(hit_atom))
		blink_mob(hit_atom)
	qdel(src)

// Bluespace crystal fragments (stops point farming)
/obj/item/stack/ore/bluespace_crystal/refined
	name = "refined bluespace crystal"
	points = 0
	refined_type = null

// Artifical bluespace crystal, doesn't give you much research.
/obj/item/stack/ore/bluespace_crystal/artificial
	name = "artificial bluespace crystal"
	desc = "An artificially made bluespace crystal, it looks delicate."
	origin_tech = "bluespace=3;plasmatech=4"
	materials = list(MAT_BLUESPACE=MINERAL_MATERIAL_AMOUNT * 0.5)
	blink_range = 4 // Not as good as the organic stuff!
	points = 0 // nice try
	refined_type = null

// Polycrystals, aka stacks

GLOBAL_LIST_INIT(bluespace_crystal_recipes, list(new/datum/stack_recipe("Breakdown into bluespace crystal", /obj/item/stack/ore/bluespace_crystal/refined, 1)))

/obj/item/stack/sheet/bluespace_crystal
	name = "bluespace polycrystal"
	icon = 'icons/obj/telescience.dmi'
	icon_state = "polycrystal"
	desc = "A stable polycrystal, made of fused-together bluespace crystals. You could probably break one off."
	origin_tech = "bluespace=6;materials=3"
	merge_type = /obj/item/stack/sheet/bluespace_crystal
	materials = list(MAT_BLUESPACE = MINERAL_MATERIAL_AMOUNT)
	attack_verb = list("блюспейс полиударил", "блюспейс полиогрел", "блюспейс полистукнул", "блюспейс полисокрушил")
	toolspeed = 1
	usesound = 'sound/items/deconstruct.ogg'
	point_value = 30

/obj/item/stack/sheet/bluespace_crystal/Initialize(mapload, new_amount, merge = TRUE)
	. = ..()
	recipes = GLOB.bluespace_crystal_recipes

