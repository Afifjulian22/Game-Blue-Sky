extends AnimatableBody2D

@export var fall_delay: float = 0.35
@export var fall_speed: float = 165.0

var _triggered := false
var _elapsed := 0.0

func _ready() -> void:
	sync_to_physics = true
	collision_layer = 1
	collision_mask = 1

func _physics_process(delta: float) -> void:
	if not _triggered:
		return
	_elapsed += delta
	if _elapsed >= fall_delay:
		$Sprite2D.texture = preload("res://Free/Traps/Falling Platforms/Off.png")
		$CollisionShape2D.set_deferred("disabled", true)
		position.y += fall_speed * delta
		if position.y > 850.0:
			queue_free()

func _on_trigger_body_entered(body: Node2D) -> void:
	if body.name == "player":
		_triggered = true