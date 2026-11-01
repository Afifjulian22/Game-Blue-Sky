extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -260.0

var jump_count = 0
var max_jumps = 2

@onready var sprite2D = $AnimatedSprite2D
func _ready() -> void:
	_position_touch_controls()
	get_viewport().size_changed.connect(_position_touch_controls)

func _position_touch_controls() -> void:
	var viewport_size := get_viewport_rect().size
	$CanvasLayer/TouchScreenButton.position = Vector2(maxf(360.0, viewport_size.x - 160.0), viewport_size.y - 150.0)
	$CanvasLayer/TouchScreenButton2.position = Vector2(250.0, viewport_size.y - 150.0)
	$CanvasLayer/TouchScreenButton3.position = Vector2(110.0, viewport_size.y - 150.0)

func _physics_process(delta: float) -> void:
	# 1. Tambahkan gravitasi
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		# Reset hitungan kembali ke 0 jika menyentuh lantai
		jump_count = 0
		
	# 2. Atur Jump
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor() or jump_count < max_jumps:
			velocity.y = JUMP_VELOCITY
			jump_count += 1
			
	# 3. Atur Gerak Kiri/Kanan
	var direction := Input.get_axis("ui_left","ui_right")
	if direction:
		velocity.x = direction * SPEED
	else :
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()
	
	# 4. Membalikkan badan saat ke kiri/kanan
	if velocity.x < 0:
		sprite2D.flip_h = true
	elif velocity.x > 0:
		sprite2D.flip_h = false

	# 5. ATUR ANIMASI SECARA TERTIB (Ini kuncinya!)
	if not is_on_floor():
		# Jika di udara, mainkan animasi lompat
		if jump_count == 2:
			sprite2D.play("2jump")
		else:
			sprite2D.play("jump")
	else:
		# Jika di lantai, cek apakah dia sedang berjalan atau diam
		if velocity.x > 1 or velocity.x < -1:
			sprite2D.play("run")
		else:
			sprite2D.play("idle")
