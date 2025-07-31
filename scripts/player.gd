extends CharacterBody3D

@export var walk_speed = 5.0 # Kecepatan berjalan
@export var sprint_speed = 8.0 # Kecepatan berlari
@export var jump_velocity = 4.5 # Kekuatan lompat
@export var mouse_sensitivity = 0.002 # Sensitivitas mouse

var current_speed = walk_speed
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var camera: Camera3D = $Camera3D # Dapatkan referensi ke Camera3D menggunakan @onready

func _ready():
	# Mengunci kursor mouse ke tengah layar dan menyembunyikannya
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	# Mengendalikan rotasi kamera dengan mouse
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity) # Rotasi Y (yaw) untuk kiri/kanan
		camera.rotate_x(-event.relative.y * mouse_sensitivity) # Rotasi X (pitch) untuk atas/bawah
		# Batasi rotasi vertikal kamera agar tidak berputar 360 derajat
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))

	# Melepaskan kursor mouse dengan tombol ESC
	if event.is_action_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	# Gravitasi
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Lompat
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Kecepatan lari (sprint)
	current_speed = walk_speed
	if Input.is_action_pressed("sprint"):
		current_speed = sprint_speed

	# Arah input dan pergerakan
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	# Menggunakan transform.basis untuk mengubah input 2D menjadi arah 3D relatif terhadap orientasi player
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)

	move_and_slide()
