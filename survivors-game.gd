extends Node2D

var GameScore = 0

func spawn_mob():
	var new_mob = preload("res://mob.tscn").instantiate()
	new_mob.mob_muere.connect(Score_increment)
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)
	
	
func _ready():
	var GameScore = 0
	Score_update(GameScore)
	get_tree().paused = false

###### MOB TIMER DIFICULTY SETTINGS
func _on_mob_timer_timeout():
	var mobsSpawned = 0
	var msg = ""
	spawn_mob()
	mobsSpawned += 1
	if mobsSpawned == 15:
		%MobTimer.wait_time = 0.4
		show_alert("Los mobs vienen mas rapido!")
	if mobsSpawned == 35:
		%MobTimer.wait_time = 0.32
		show_alert("Los mobs vienen aun mas rapido!")
	if mobsSpawned == 67:
		%MobTimer.wait_time = 0.26
		show_alert("Los mobs vienen muchisimo mas rapido!")
		
func show_alert(msg):
	$%MobSpawnAlert.text = msg
	$%MobSpawnAlert.visible = true
	await get_tree().create_timer(3).timeout
	$%MobSpawnAlert.visible = false


func _on_player_health_depleted():
	get_tree().change_scene_to_file("res://game_over.tscn")

func Score_update(GameScore):
	%ScoreLabel.text = "Score : " + str(GameScore)
	%NivelLabel.text = "Jugador nivel : " + str(Global.playerLEVEL)
	%PlayerName.text = "Jugardor : " + Global.playerNAME
	%"statDaño".text = "Daño : " + str(Global.playerAtkDmg)
	%"statCrit".text = "Crit Chance : " + str(Global.playerCritChance)
	%"statHpRegen".text = "Hp Regen : " + str(Global.playerHPREGEN)
	%"statMovSpeed".text = "Move Speed : " + str(Global.playerMovSpeed)

func Score_increment():
	var ScoreMult = Global.scoreMulti	
	GameScore += 1 * ScoreMult
	Global.playerScore = GameScore
	Score_update(GameScore)
