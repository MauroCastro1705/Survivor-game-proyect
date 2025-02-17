extends Area2D

#can be picked up by the player

func _on_body_entered(_body: Node2D) -> void:
	var speedcoins = Global.SpeedCoinsOnScreen	
	Global.playerMovSpeed += 100 #aumenta la velocidad del jugador
	print("mas velocidad")
	queue_free()
	if speedcoins > 0:
		Global.SpeedCoinsOnScreen -= 1
	
