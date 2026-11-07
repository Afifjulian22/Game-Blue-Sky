extends AnimatableBody2D

# Platform yang jatuh saat diinjak, lalu kembali ke posisi awal
# supaya bagian level ini tetap bisa dicoba lagi setelah respawn.
@export var fall_delay: float = 0.35
@export var fall_speed: float = 165.0

const TEXTURE_ON := preload("res://Free/Traps/Falling Platforms/On (32x10).png")
const TEXTURE_OFF := preload("res://Free/Traps/Falling Platforms/Off.png")

@onready var _sprite: Sprite2D = $Sprite2D

var _origin: Vector2
var _triggered: bool = false
var _elapsed: float = 0.0


func _ready() -> void:
	_origin = position
	sync_to_physics = true
	collision_layer = 1
	collision_mask = 1


func _physics_process(delta: float) -> void:
	if not _triggered:
		return

	_elapsed += delta
	if _elapsed < fall_delay:
		return

	_sprite.texture = TEXTURE_OFF
	$CollisionShape2D.set_deferred("disabled", true)
	position.y += fall_speed * delta

	if position.y > 1100.0:
		_reset()


func _reset() -> void:
	position = _origin
	_sprite.texture = TEXTURE_ON
	$CollisionShape2D.set_deferred("disabled", false)
	_triggered = false
	_elapsed = 0.0


func _on_trigger_body_entered(body: Node2D) -> void:
	if body.name == "player":
		_triggered = true
