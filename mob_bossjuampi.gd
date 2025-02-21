extends CharacterBody2D

@onready var player#solo se declara
@onready var health = Global.bigBossHealth
@onready var MaxHealth = Global.bigBossMaxHealth
@onready var mobExp = Global.bigBossExpValue
@onready var _animated_sprite: AnimatedSprite2D
@onready var shooting_point = %ShootingPoint

signal Boss_mob_muere
const CRIT_LABEL = preload("res://crit_dmg_label.tscn")

func _ready():
	player = get_node("/root/Game/Player")
	_animated_sprite = $AnimatedSprite2D


func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * Global.bigBossVelocity
	move_and_slide()
	#_animated_sprite.play("ataque")
	%Boss_barravida.value = health
	%Boss_barravida.max_value = MaxHealth


func take_damage():
	var dmgDone = Global.playerAtkDmg
	var dmgMulti = Global.playerCritMulti
	var critChance = Global.playerCritChance
	
	if randf() < critChance:
		dmgDone *= dmgMulti  # Aumentar el daño
		%Boss_barravida.value = health
		print("daño critico")
		#SHOW CRIT funcion GlobalCriticos autoload
		GlobalCriticos.SHOW_CRIT(global_position)
		
	_animated_sprite.play("hurt")
	health -= dmgDone
	if health <= 0:
		Boss_mob_muere.emit()
		queue_free()
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position		


func _on_Boss_mob_muere() -> void:
	print("señal jefe muerte")
	#agregar experiencia al pj
	Global.ADD_EXP(mobExp)
