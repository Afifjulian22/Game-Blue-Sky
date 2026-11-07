extends CharacterBody2D

# ------------------------------------------------------------------ tuning
@export var speed: float = 240.0
@export var jump_velocity: float = -400.0
@export var max_jumps: int = 2
@export var respawn_delay: float = 0.55
@export var invulnerable_time: float = 1.0
@export var fall_limit: float = 1000.0

# --- lives / hearts -------------------------------------------------------
const MAX_LIVES: int = 3
const HEART_SHEET := preload("res://Free/Pixel Heart Sprite Sheet 32x32.png")
const HEART_SIZE: float = 44.0
const HEART_GAP: float = 6.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var btn_left: TouchScreenButton = $CanvasLayer/BtnLeft
@onready var btn_right: TouchScreenButton = $CanvasLayer/BtnRight
@onready var btn_jump: TouchScreenButton = $CanvasLayer/BtnJump

var jump_count: int = 0
var spawn_point: Vector2 = Vector2.ZERO
var safe_position: Vector2 = Vector2.ZERO
var is_dead: bool = false
var is_invulnerable: bool = false
var lives: int = MAX_LIVES
var _heart_full: AtlasTexture
var _heart_empty: AtlasTexture


func _ready() -> void:
	spawn_point = global_position
	safe_position = global_position

	# Heart sprite sheet (32x32): frame 0 = full, frame 2 = empty.
	_heart_full = AtlasTexture.new()
	_heart_full.atlas = HEART_SHEET
	_heart_full.region = Rect2(0, 0, 32, 32)

	_heart_empty = AtlasTexture.new()
	_heart_empty.atlas = HEART_SHEET
	_heart_empty.region = Rect2(64, 0, 32, 32)

	lives = MAX_LIVES
	_update_hearts()

	_layout_touch_buttons()
	get_viewport().size_changed.connect(_layout_touch_buttons)


# Keep the on-screen pad and the hearts in the corners whatever the
# window / phone size is.
func _layout_touch_buttons() -> void:
	var vp := get_viewport_rect().size
	var margin := 110.0
	btn_left.position = Vector2(84.0, vp.y - margin)
	btn_right.position = Vector2(196.0, vp.y - margin)
	btn_jump.position = Vector2(vp.x - margin, vp.y - margin)

	var hearts := _hearts()
	var total := MAX_LIVES * HEART_SIZE + (MAX_LIVES - 1) * HEART_GAP
	var start_x := vp.x - 24.0 - total
	for i in hearts.size():
		hearts[i].size = Vector2(HEART_SIZE, HEART_SIZE)
		hearts[i].position = Vector2(start_x + i * (HEART_SIZE + HEART_GAP), 20.0)


func _hearts() -> Array:
	return [$CanvasLayer/Heart1, $CanvasLayer/Heart2, $CanvasLayer/Heart3]


func _update_hearts() -> void:
	var hearts := _hearts()
	for i in hearts.size():
		hearts[i].texture = _heart_full if i < lives else _heart_empty


func _physics_process(delta: float) -> void:
	if is_dead:
		return

	# --- gravity -------------------------------------------------------
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		jump_count = 0

	# --- jump (double jump included) -----------------------------------
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() or jump_count < max_jumps:
			velocity.y = jump_velocity
			jump_count += 1

	# --- walk ----------------------------------------------------------
	var direction := Input.get_axis("move_left", "move_right")
	if direction != 0.0:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0.0, speed * 6.0 * delta)

	move_and_slide()

	# --- respawn anchor: remember the last static platform we stood on --
	if is_on_floor() and not _standing_on_moving_body():
		safe_position = global_position

	if global_position.y > fall_limit:
		die()
		return

	_update_animation(direction)


func _standing_on_moving_body() -> bool:
	for i in get_slide_collision_count():
		var collider := get_slide_collision(i).get_collider()
		if collider is AnimatableBody2D:
			return true
	return false


func _update_animation(direction: float) -> void:
	if not is_on_floor():
		if velocity.y > 30.0:
			sprite.play("fall")
		elif jump_count >= max_jumps:
			sprite.play("2jump")
		else:
			sprite.play("jump")
	else:
		if absf(direction) > 0.01:
			sprite.play("run")
		else:
			sprite.play("idle")

	if direction < 0.0:
		sprite.flip_h = true
	elif direction > 0.0:
		sprite.flip_h = false


# Called by every hazard (spikes, saws, fire, kill zone, pit).
func die() -> void:
	if is_dead or is_invulnerable:
		return

	is_dead = true
	lives -= 1
	_update_hearts()
	velocity = Vector2.ZERO
	sprite.play("hit")
	await get_tree().create_timer(respawn_delay).timeout
	_respawn()


func _respawn() -> void:
	if lives <= 0:
		# Out of lives: back to the starting checkpoint with a fresh set.
		lives = MAX_LIVES
		_update_hearts()
		safe_position = spawn_point
		global_position = spawn_point
	else:
		# Still has lives: respawn on the last solid foothold.
		global_position = safe_position

	velocity = Vector2.ZERO
	jump_count = 0
	is_dead = false
	sprite.play("idle")

	# Short grace period so the player is not instantly killed again.
	is_invulnerable = true
	sprite.modulate.a = 0.5
	await get_tree().create_timer(invulnerable_time).timeout
	if not is_inside_tree():
		return
	sprite.modulate.a = 1.0
	is_invulnerable = false
