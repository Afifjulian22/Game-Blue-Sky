extends Area2D

# Hazard dasar (duri / api). Kalau player menyentuh, player respawn
# di pijakan terakhir, bukan reload scene.
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("play_hit"):
		body.play_hit()
	if body.has_method("die"):
		body.die()
