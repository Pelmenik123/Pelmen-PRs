/client/proc/atmosscan()
	set category = "Debug.Mapping"
	set name = "Check Piping"
	if(!src.holder)
		to_chat(src, "Only administrators may use this command.")
		return
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Check Piping") //If you are copy-pasting this, ensure the 4th parameter is unique to the new proc!

	if(tgui_alert(usr, "WARNING: This command should not be run on a live server. Do you want to continue?", "Check Piping", list("No", "Yes")) == "No")
		return

	//all plumbing - yes, some things might get stated twice, doesn't matter.
	to_chat(usr, "Checking for unconnected pipes")
	var/list/atmos = list()
	for(var/turf/T in world)
		for(var/obj/machinery/atmospherics/atm in T)
			atmos += atm
	//Manifolds 3w
	for(var/obj/machinery/atmospherics/pipe/manifold/pipe in atmos)
		if(!pipe.node1 || !pipe.node2 || !pipe.node3)
			to_chat(usr, "Unconnected [pipe.name] located at [pipe.x],[pipe.y],[pipe.z] ([get_area(pipe.loc)])")
	//Manifolds 4w
	for(var/obj/machinery/atmospherics/pipe/manifold4w/pipe in atmos)
		if(!pipe.node1 || !pipe.node2 || !pipe.node3 || !pipe.node4)
			to_chat(usr, "Unconnected [pipe.name] located at [pipe.x],[pipe.y],[pipe.z] ([get_area(pipe.loc)])")
	//Pipes
	for(var/obj/machinery/atmospherics/pipe/simple/pipe in atmos)
		if(!pipe.node1 || !pipe.node2)
			to_chat(usr, "Unconnected [pipe.name] located at [pipe.x],[pipe.y],[pipe.z] ([get_area(pipe.loc)])")
	to_chat(usr, "Checking for overlapping pipes...")
	for(var/turf/T in world)
		for(var/dir in GLOB.cardinal)
			var/list/check = list(0, 0, 0)
			var/done = 0
			for(var/obj/machinery/atmospherics/pipe in T)
				if(dir & pipe.initialize_directions)
					for(var/ct in pipe.connect_types)
						check[ct]++
						if(check[ct] > 1)
							to_chat(usr, "Overlapping pipe ([pipe.name]) located at [T.x],[T.y],[T.z] ([get_area(T)])")
							done = 1
							break
				if(done)
					break
	to_chat(usr, "Done")

/client/proc/powerdebug()
	set category = "Debug.Mapping"
	set name = "Check Power"
	if(!src.holder)
		to_chat(src, "Only administrators may use this command.")
		return
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Check Power") //If you are copy-pasting this, ensure the 4th parameter is unique to the new proc!

	for(var/datum/powernet/PN in SSmachines.powernets)
		if(!PN.nodes || !PN.nodes.len)
			if(PN.cables && (PN.cables.len > 1))
				var/obj/structure/cable/C = PN.cables[1]
				to_chat(usr, "Powernet with no nodes! (number [PN.number]) - example cable at [C.x], [C.y], [C.z] in area [get_area(C.loc)]")

		if(!PN.cables || (PN.cables.len < 10))
			if(PN.cables && (PN.cables.len > 1))
				var/obj/structure/cable/C = PN.cables[1]
				to_chat(usr, "Powernet with fewer than 10 cables! (number [PN.number]) - example cable at [C.x], [C.y], [C.z] in area [get_area(C.loc)]")
