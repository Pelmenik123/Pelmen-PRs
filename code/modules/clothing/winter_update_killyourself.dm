/obj/item/clothing/suit/winter_slut
	name = "Набор утеплённой одежды"
	desc = "Набор утеплённой одежды и укреплённой одежды, имеющий опознавательные знаки отдела"
	icon = 'icons/mob/clothing/species/wintet_fffffffff/service/human.dmi'

	icon_state = "service_helmet"
	item_state = "winter_slut"
	w_class = WEIGHT_CLASS_BULKY

	body_parts_covered = FULL_BODY
	cold_protection = FULL_BODY
	clothing_flags = THICKMATERIAL
	slowdown = 1
	allowed = list(/obj/item/tank/internals/emergency_oxygen,/obj/item/pen,/obj/item/flashlight/pen)
	armor = list("melee" = 10, "bullet" = 5, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HIDETAIL
	strip_delay = 70
	put_on_delay = 70
	sprite_sheets = list(
		SPECIES_DRASK = 'icons/mob/clothing/species/wintet_fffffffff/service/drask.dmi',
		SPECIES_VOX = 'icons/mob/clothing/species/wintet_fffffffff/service/vox.dmi',
		SPECIES_GREY = 'icons/mob/clothing/species/wintet_fffffffff/service/grey.dmi',
		SPECIES_MONKEY = 'icons/mob/clothing/species/wintet_fffffffff/service/monkey.dmi',
		SPECIES_TAJARAN = 'icons/mob/clothing/species/wintet_fffffffff/service/tajaran.dmi',
		SPECIES_VULPKANIN = 'icons/mob/clothing/species/wintet_fffffffff/service/vulpkanin.dmi',
		SPECIES_UNATHI = 'icons/mob/clothing/species/wintet_fffffffff/service/tajaran.dmi',
		)
	
/obj/item/clothing/suit/winter_slut/cringiner
	icon = 'icons/mob/clothing/species/wintet_fffffffff/engineering/engineer_human.dmi'
	icon_state = "eng_helmet"
	
	sprite_sheets = list(
		SPECIES_DRASK = 'icons/mob/clothing/species/wintet_fffffffff/engineering/eng_drask.dmi',
		SPECIES_VOX = 'icons/mob/clothing/species/wintet_fffffffff/engineering/eng_vox.dmi',
		SPECIES_GREY = 'icons/mob/clothing/species/wintet_fffffffff/engineering/eng_grey.dmi',
		SPECIES_MONKEY = 'icons/mob/clothing/species/wintet_fffffffff/engineering/eng_monkey.dmi',
		SPECIES_TAJARAN = 'icons/mob/clothing/species/wintet_fffffffff/engineering/eng_tajaran.dmi',
		SPECIES_VULPKANIN = 'icons/mob/clothing/species/wintet_fffffffff/engineering/eng_vulp.dmi',
		SPECIES_UNATHI = 'icons/mob/clothing/species/wintet_fffffffff/engineering/eng_tajaran.dmi'
		)

/obj/item/clothing/suit/winter_slut/cringiner/ChefChmo
	icon_state = "ce_helmet"
/obj/item/clothing/suit/winter_slut/cringiner/Atmos
	icon_state = "atmos_helmet"
	armor = list("melee" = 10, "bullet" = 5, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 70, "acid" = 0)

/obj/item/clothing/suit/winter_slut/command
	icon = 'icons/mob/clothing/species/wintet_fffffffff/command/human.dmi'
	icon_state = "com_helmet"
	sprite_sheets = list(
		SPECIES_GREY = 'icons/mob/clothing/species/wintet_fffffffff/command/grey.dmi',
		SPECIES_MONKEY = 'icons/mob/clothing/species/wintet_fffffffff/command/monkey.dmi',
		SPECIES_TAJARAN = 'icons/mob/clothing/species/wintet_fffffffff/command/tajaran.dmi',
		SPECIES_VULPKANIN = 'icons/mob/clothing/species/wintet_fffffffff/command/vulp.dmi',
		SPECIES_UNATHI = 'icons/mob/clothing/species/wintet_fffffffff/command/tajaran.dmi'
		)

/obj/item/clothing/suit/winter_slut/medical
	icon = 'icons/mob/clothing/species/wintet_fffffffff/medical/human.dmi'
	icon_state = "med_helmet"
	sprite_sheets = list(
		SPECIES_DRASK = 'icons/mob/clothing/species/wintet_fffffffff/medical/drask.dmi',
		SPECIES_VOX = 'icons/mob/clothing/species/wintet_fffffffff/medical/vox.dmi',
		SPECIES_GREY = 'icons/mob/clothing/species/wintet_fffffffff/medical/grey.dmi',
		SPECIES_MONKEY = 'icons/mob/clothing/species/wintet_fffffffff/medical/monkey.dmi',
		SPECIES_TAJARAN = 'icons/mob/clothing/species/wintet_fffffffff/medical/tajaran.dmi',
		SPECIES_VULPKANIN = 'icons/mob/clothing/species/wintet_fffffffff/medical/vulp.dmi',
		SPECIES_UNATHI = 'icons/mob/clothing/species/wintet_fffffffff/medical/tajaran.dmi'
		)

/obj/item/clothing/suit/winter_slut/medical/cmo
	icon_state = "cmo_helmet"

/obj/item/clothing/suit/winter_slut/rnd
	icon = 'icons/mob/clothing/species/wintet_fffffffff/rnd/human.dmi'
	icon_state = "scientist_helmet"
	armor = list("melee" = 10, "bullet" = 5, "laser" = 0,"energy" = 0, "bomb" = 20, "bio" = 20, "rad" = 0, "fire" = 0, "acid" = 0)
	sprite_sheets = list(
		SPECIES_DRASK = 'icons/mob/clothing/species/wintet_fffffffff/rnd/drask.dmi',
		SPECIES_VOX = 'icons/mob/clothing/species/wintet_fffffffff/rnd/vox.dmi',
		SPECIES_GREY = 'icons/mob/clothing/species/wintet_fffffffff/rnd/grey.dmi',
		SPECIES_MONKEY = 'icons/mob/clothing/species/wintet_fffffffff/rnd/monkey.dmi',
		SPECIES_TAJARAN = 'icons/mob/clothing/species/wintet_fffffffff/rnd/tajaran.dmi',
		SPECIES_VULPKANIN = 'icons/mob/clothing/species/wintet_fffffffff/rnd/vulpkanin.dmi',
		SPECIES_UNATHI = 'icons/mob/clothing/species/wintet_fffffffff/rnd/tajaran.dmi'
		)

/obj/item/clothing/suit/winter_slut/rnd/rd
	icon_state = "rd_helmet"

/obj/item/clothing/suit/winter_slut/shitcurity
	icon = 'icons/mob/clothing/species/wintet_fffffffff/sec/grey.dmi'
	icon_state = "sec_helmet"
	armor = list("melee" = 20, "bullet" = 20, "laser" = 10,"energy" = 5, "bomb" = 20, "bio" = 20, "rad" = 0, "fire" = 0, "acid" = 0)
	sprite_sheets = list(
		SPECIES_VOX = 'icons/mob/clothing/species/wintet_fffffffff/sec/vox.dmi',
		SPECIES_GREY = 'icons/mob/clothing/species/wintet_fffffffff/sec/grey.dmi',
		SPECIES_MONKEY = 'icons/mob/clothing/species/wintet_fffffffff/sec/monkey.dmi',
		SPECIES_TAJARAN = 'icons/mob/clothing/species/wintet_fffffffff/sec/tajaran.dmi',
		SPECIES_VULPKANIN = 'icons/mob/clothing/species/wintet_fffffffff/sec/vulpkanin.dmi',
		SPECIES_UNATHI = 'icons/mob/clothing/species/wintet_fffffffff/sec/tajaran.dmi'
		)

/obj/item/clothing/suit/winter_slut/shitcurity/hos
	icon_state = "hos_helmet"
