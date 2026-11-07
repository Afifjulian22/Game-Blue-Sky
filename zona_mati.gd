extends Area2D

# Zona jatuh ke jurang: player mati lalu respawn di pijakan terakhir.
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("die"):
		body.die()
