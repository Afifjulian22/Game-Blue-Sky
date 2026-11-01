extends Area2D

@export_enum("horizontal", "vertical") var movement_axis: String = "vertical"
@export var travel_distance: float = 40.0
@export var movement_speed: float = 1.4

var _origin: Vector2
var _elapsed: float = 0.0

func _ready() -> void:
	_origin = position

func _physics_process(delta: float) -> void:
	_elapsed += delta * movement_speed
	var offset := sin(_elapsed) * travel_distance
	if movement_axis == "horizontal":
		position = _origin + Vector2(offset, 0.0)
	else:
		position = _origin + Vector2(0.0, offset)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		get_tree().call_deferred("change_scene_to_file", "res://node_2d.tscn")
