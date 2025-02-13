extends CharacterBody2D
signal health_depleted
var health = Global.playerHealth

func _physics_process(delta):	
	%LevelBar.value = Global.playerExp
	%LevelBar.max_value = Global.expToLvlUp
	
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	var movSpeed = Global.playerMovSpeed
	velocity = direction * movSpeed
	move_and_slide()
	
	if velocity.length()> 0.0:
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()
		
	var DAMAGE_RATE = Global.mobDmgRate
	var overlapping_mobs = %hurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health
		
		if health <= 0.0:
			health_depleted.emit()
			print("Player dead")
			Global.save_high_score(Global.playerNAME, Global.playerScore, Global.playerLEVEL)
			
	%ProgressBar.max_value = Global.playerMaxHealth
	%valorVida.text = str(round(health)) + " / " + str(round(Global.playerMaxHealth))
