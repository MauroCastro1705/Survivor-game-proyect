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
	%GameOver.visible = false
	get_tree().paused = false
func _on_mob_timer_timeout():
	spawn_mob()


func _on_player_health_depleted():
	%GameOver.visible = true
	get_tree().paused = true

func Score_update(GameScore):
	%ScoreLabel.text = "Score : " + str(GameScore)

func Score_increment():
	GameScore += 1
	Score_update(GameScore)

func _on_button_pressed():
	get_tree().reload_current_scene()
