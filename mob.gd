extends CharacterBody2D

var player
var health = Global.mobHealth
var dmgDone = Global.playerAtkDmg
var dmgMulti = Global.playerAtkDmgMulti
var mobExp = 12

signal mob_muere


func _ready():
	player = get_node("/root/Game/Player")
	%Slime.play_walk()



func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 250
	move_and_slide()
	
	
func take_damage():
	%Slime.play_hurt()
	health -= dmgDone
	
		
	if health <= 0:
		mob_muere.emit()
		queue_free()
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position


func _on_mob_muere() -> void:
	print("señal mob muerte")
	Global.ADD_EXP(mobExp)
