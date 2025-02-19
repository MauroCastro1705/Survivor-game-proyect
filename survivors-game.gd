extends Node2D

var GameScore = 0
var gameTimer = 0


func spaw_health_coins():
	if Global.HealthCoinsOnScreen <= 2:
		var new_coin = preload("res://PowerUpCoin.tscn").instantiate()
		%CoinPathFollow2D.progress_ratio = randf()
		new_coin.global_position = %CoinPathFollow2D.global_position
		add_child(new_coin)
		Global.HealthCoinsOnScreen += 1

func spaw_speed_coins():
	if Global.SpeedCoinsOnScreen <= 2:
		var new_speed_coin = preload("res://PowerSpeedUpCoin.tscn").instantiate()
		%CoinPathFollow2D.progress_ratio = randf()
		new_speed_coin.global_position = %CoinPathFollow2D.global_position
		add_child(new_speed_coin)
		Global.SpeedCoinsOnScreen += 1

func spawn_atk_speed_coins():
	if Global.AtkSpeedCoinsOnScreen <= 2:
		var new_atk_speed_coin = preload("res://power_up_atk_speed_coin.tscn").instantiate()
		%CoinPathFollow2D.progress_ratio = randf()
		new_atk_speed_coin.global_position = %CoinPathFollow2D.global_position
		add_child(new_atk_speed_coin)
		Global.AtkSpeedCoinsOnScreen += 1

func spawn_mob():	
	var new_mob = preload("res://mob.tscn").instantiate()
	new_mob.mob_muere.connect(Score_increment)
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)

func spawn_big_mob():
	var new_big_mob = preload("res://big_mob.tscn").instantiate()
	new_big_mob.mob_muere.connect(Score_increment)
	%PathFollow2D.progress_ratio = randf()
	new_big_mob.global_position = %PathFollow2D.global_position
	add_child(new_big_mob)	

func incrementar_dificultad():
	var dificultad = Global.playerLEVEL
	if dificultad == 4:
		%MobTimer.wait_time = 0.4
		show_alert("!Los Enemigos vienen mas rapido!")
	if dificultad == 8:
		%MobTimer.wait_time = 0.3
		show_alert("!Los Enemigos vienen aun mas rapido!")
	if dificultad == 14:
		%MobTimer.wait_time = 0.2
		show_alert("!Los Enemigos vienen muchisimo mas rapido!")
		
func show_alert(msg: String):
	%MobSpawnAlert.text = msg
	%MobSpawnAlert.visible = true
	await get_tree().create_timer(3).timeout
	%MobSpawnAlert.visible = false
	
	
func _ready():
	Global.isLevelUpCompleted = true
	GameScore = 0
	Score_update()
	get_tree().paused = false
	Global.HealthCoinsOnScreen = 0
	Global.SpeedCoinsOnScreen = 0
	Global.AtkSpeedCoinsOnScreen = 0
	if Input.is_action_pressed("pause"):
		get_tree().paused = true
		#get_tree().change_scene_to_file("res://pause_menu.tscn")


func _physics_process(_delta):
	Global.MOB_DAMAGE()



### MOB SPAWNER ###
func _on_mob_timer_timeout():
	spawn_mob()
	incrementar_dificultad()
	Global.GAME_TIMER()
	if Global.playerScore > 50 and Global.gameTimer == 15:
		spawn_big_mob()#cada 15 mobs normales sale uno grande
		Global.RESET_COINS()

func Score_update():
	%ScoreLabel.text = "Score : " + str(GameScore)
	%NivelLabel.text = "Jugador nivel : " + str(Global.playerLEVEL)
	%PlayerName.text = "Jugardor : " + Global.playerNAME
	%statDaño.text = "Daño : " + str(Global.playerAtkDmg)
	%statCrit.text = "Crit Chance : " + str(Global.playerCritChance)
	%statAtkSpeed.text = "Atk Speed : " + str(Global.playerAtkSpeed)
	%statMovSpeed.text = "Move Speed : " + str(Global.playerMovSpeed)

func Score_increment():
	var ScoreMult = Global.scoreMulti #revisar esto	
	GameScore += 1 * ScoreMult
	Global.playerScore = GameScore
	Score_update()


func _on_coin_timer_timeout() -> void:
	spaw_health_coins()
	spaw_speed_coins()
	spawn_atk_speed_coins()


#tree spawner
func _on_tree_timer_timeout() -> void:
	var new_tree = preload("res://Pinetree.tscn").instantiate()
	%CoinPathFollow2D.progress_ratio = randf()
	new_tree.global_position = %CoinPathFollow2D.global_position
	add_child(new_tree)
	var new_rock1 = preload("res://rock_1.tscn").instantiate()
	%CoinPathFollow2D.progress_ratio = randf()
	new_rock1.global_position = %CoinPathFollow2D.global_position
	add_child(new_rock1)
	var new_rock2 = preload("res://rock_2.tscn").instantiate()
	%CoinPathFollow2D.progress_ratio = randf()
	new_rock2.global_position = %CoinPathFollow2D.global_position
	add_child(new_rock2)
	var new_rock3 = preload("res://rock_3.tscn").instantiate()
	%CoinPathFollow2D.progress_ratio = randf()
	new_rock3.global_position = %CoinPathFollow2D.global_position
	add_child(new_rock3)

func _on_player_health_depleted():
	get_tree().change_scene_to_file("res://game_over.tscn")
