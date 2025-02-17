extends Node2D

var GameScore = 0



func spaw_health_coins():
	if Global.HealthCoinsOnScreen < 2:
		var new_coin = preload("res://PowerUpCoin.tscn").instantiate()
		%CoinPathFollow2D.progress_ratio = randf()
		new_coin.global_position = %CoinPathFollow2D.global_position
		add_child(new_coin)
		Global.HealthCoinsOnScreen += 1

func spaw_speed_coins():
	if Global.SpeedCoinsOnScreen < 2:
		var new_speed_coin = preload("res://PowerSpeedUpCoin.tscn").instantiate()
		%CoinPathFollow2D.progress_ratio = randf()
		new_speed_coin.global_position = %CoinPathFollow2D.global_position
		add_child(new_speed_coin)
		Global.SpeedCoinsOnScreen += 1

func spawn_mob():	
	var new_mob = preload("res://mob.tscn").instantiate()
	new_mob.mob_muere.connect(Score_increment)
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)

func incrementar_dificultad():
	var dificultad = Global.playerLEVEL
	if dificultad == 3:
		%MobTimer.wait_time = 0.4
		show_alert("Los mobs vienen mas rapido!")
	if dificultad == 7:
		%MobTimer.wait_time = 0.32
		show_alert("Los mobs vienen aun mas rapido!")
	if dificultad == 12:
		%MobTimer.wait_time = 0.26
		show_alert("Los mobs vienen muchisimo mas rapido!")
		
func show_alert(msg: String):
	%MobSpawnAlert.text = msg
	%MobSpawnAlert.visible = true
	await get_tree().create_timer(3).timeout
	%MobSpawnAlert.visible = false
	
	
func _ready():
	var GameScore = 0
	Score_update(GameScore)
	get_tree().paused = false
	Global.HealthCoinsOnScreen = 0
	Global.SpeedCoinsOnScreen = 0

func _on_mob_timer_timeout():
	spawn_mob()
	incrementar_dificultad()

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


func _on_coin_timer_timeout() -> void:
	spaw_health_coins()
	spaw_speed_coins()


#tree spawner
func _on_tree_timer_timeout() -> void:
		var new_tree = preload("res://Pinetree.tscn").instantiate()
		%CoinPathFollow2D.progress_ratio = randf()
		new_tree.global_position = %CoinPathFollow2D.global_position
		add_child(new_tree)
