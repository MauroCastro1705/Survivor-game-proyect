extends Area2D

#can be picked up by the player

func _on_body_entered(_body: Node2D) -> void:    
	queue_free()
	Global.SPEED_COIN()
	
