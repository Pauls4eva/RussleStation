/datum/game_mode/metro
	name="Factions"
	config_tag = "Factions"
	required_players = 1
	required_enemies = 1
	recommended_enemies = 10

/datum/game_mode/traitor/announce()
	world << "<B>The current game mode is - Metro!</B>"
	world << "<B>All crew must prepare for the upcoming radiation storms, get ready for ANYTHING.</B>"


/proc/event()
	event = 1

	var/eventNumbersToPickFrom = list(1,2)

	if((world.time/10)>=360)//If an hour has passed, relatively speaking. Also, if ninjas are allowed to spawn and if there is not already a ninja for the round.
		eventNumbersToPickFrom += 3
	switch(pick(eventNumbersToPickFrom))

		if(1)
			high_radiation_event()

		if(2)
			alien_infestation()