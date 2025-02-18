extends Area2D
#can be picked up


func _on_body_entered(_body: Node2D) -> void:	
	queue_free()
	Global.HEALTH_COIN()
	GlobalCriticos.SHOW_MSG(global_position, "Health Restored!")
