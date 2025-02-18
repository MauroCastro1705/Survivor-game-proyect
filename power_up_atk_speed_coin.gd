extends Area2D
#can be picked up by the player

func _on_body_entered(_body: Node2D) -> void:
	queue_free()
	Global.ATK_SPD_COIN()
	GlobalCriticos.SHOW_MSG(global_position, "Atk Speed Up!")
