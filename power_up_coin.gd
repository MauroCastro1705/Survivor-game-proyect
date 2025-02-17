extends Area2D
#can be picked up


func _on_body_entered(_body: Node2D) -> void:	
	var ValorVidaUp = 50.0
	Global.playerHealth = min(Global.playerHealth +ValorVidaUp, Global.playerMaxHealth)
	print("mas vida")
	queue_free()
	if Global.HealthCoinsOnScreen > 0:
		Global.HealthCoinsOnScreen -= 1
