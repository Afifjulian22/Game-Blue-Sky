extends AnimatableBody2D

@export var travel_distance: float = 18.0
@export var motion_phase: float = 0.0
@export var speed: float = 0.9

var _origin: Vector2
var _elapsed: float = 0.0

func _ready() -> void:
	_origin = position
	_elapsed = motion_phase
	sync_to_physics = true
	collision_layer = 1
	collision_mask = 1

func _physics_process(delta: float) -> void:
	_elapsed += delta * speed
	position = _origin + Vector2(0.0, sin(_elapsed) * travel_distance)