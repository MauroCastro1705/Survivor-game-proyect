extends Node

const CRIT_LABEL = preload("res://crit_dmg_label.tscn")

### CRITICOS###
func SHOW_CRIT(mob_position: Vector2):
		var crit_label_mob = CRIT_LABEL.instantiate()
		get_parent().add_child(crit_label_mob)
		crit_label_mob.global_position = mob_position		
		crit_label_mob.text = "Daño Critico!"
		crit_label_mob.visible = true
		 # Crear animación con Tween
		var tween = get_tree().create_tween()
		tween.parallel().tween_property(crit_label_mob, "modulate:a", 0, 1.5)  # Desvanecer en 1.5s
		tween.parallel().tween_property(crit_label_mob, "position:y", crit_label_mob.position.y - 20, 1.5)  # Subir 20px en 1.5s
		await tween.finished
		crit_label_mob.queue_free()
		
