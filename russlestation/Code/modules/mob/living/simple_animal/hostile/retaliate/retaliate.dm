/mob/living/simple_animal/hostile/retaliate

/mob/living/simple_animal/hostile/retaliate/Found(var/atom/A)
	if(isliving(A))
		var/mob/living/L = A
		if(!L.stat)
			stance = HOSTILE_STANCE_ATTACK
			return L
		else
			enemies -= L
	else if(istype(A, /obj/mecha))
		var/obj/mecha/M = A
		if(M.occupant)
			stance = HOSTILE_STANCE_ATTACK
			return A

/mob/living/simple_animal/hostile/retaliate/ListTargets()
	if(!enemies.len)
		return list()
	var/list/see = ..()
	see &= enemies // Remove all entries that aren't in enemies
	return see

/mob/living/simple_animal/hostile/retaliate/proc/Retaliate()
	..()
	var/list/around = view(src, 7)

	for(var/atom/movable/A in around)
		if(A == src)
			continue
		if(isliving(A))
			var/mob/living/M = A
			if(!attack_same && M.faction != faction)
				enemies |= M
		else if(istype(A, /obj/mecha))
			var/obj/mecha/M = A
			if(M.occupant)
				enemies |= M
				enemies |= M.occupant
	for(var/mob/living/simple_animal/hostile/retaliate/R in around)
		if(!attack_same && !R.attack_same && R.faction != faction)
			R.enemies |= enemies
	return 0

/mob/living/simple_animal/hostile/retaliate/adjustBruteLoss(var/damage)
	..(damage)
	Retaliate()

/mob/living/simple_animal/hostile/retaliate/DestroySurroundings()
	for(var/dir in cardinal) // North, South, East, West
		var/obj/structure/obstacle = locate(/obj/structure, get_step(src, dir))
		if(istype(obstacle, /obj/structure/closet) || istype(obstacle, /obj/structure/table))
			obstacle.attack_animal(src)