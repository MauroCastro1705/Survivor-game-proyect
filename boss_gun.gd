extends Area2D

@onready var shooting_point = %ShootingPoint


func _ready():
	pass

func _process(_delta):
	Normal_Shoot()


func start_shooting_cooldown():
	await get_tree().create_timer(Global.playerAtkSpeed).timeout



func _physics_process(_delta):
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		look_at(enemies_in_range[0].global_position)  # Aim at the closest enemy


#### SHOOT TYPES####
func Normal_Shoot():
	const BULLET = preload("res://bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = shooting_point.global_position
	new_bullet.global_rotation = shooting_point.global_rotation
	get_parent().add_child(new_bullet)  # Spawn bullet in the main scene


#func Burst_Fire():
#	const BULLET = preload("res://bullet.tscn")
#	for i in range(Global.bulletBurstCount):
#		await get_tree().create_timer(Global.bulletBurstDelay).timeout
#		var new_bullet = BULLET.instantiate()
#		new_bullet.global_position = shooting_point.global_position
#		new_bullet.global_rotation = shooting_point.global_rotation
#		get_parent().add_child(new_bullet)

func _on_boss_atk_timer_timeout() -> void:
	Normal_Shoot()
