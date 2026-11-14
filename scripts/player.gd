extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var run_sound: AudioStreamPlayer2D = $RunSound

var is_running_sound_playing := false


func _ready() -> void:
	add_to_group("player")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	#inputs the direction // -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")

	#flip the sprite
	if is_on_floor():
		if direction > 0:
			animated_sprite.flip_h = false
		if direction < 0:
			animated_sprite.flip_h = true
	else:
		animated_sprite.play("jump")
	
		
	#play animations
	if direction == 0:
		animated_sprite.play("idle") 
		stop_running_sound()
	else:
		animated_sprite.play("run")
		play_running_sound()
		
	 
	# move the player
	if direction:
		velocity.x = direction * SPEED 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func play_running_sound() -> void:
	if run_sound == null:
		return
	if is_running_sound_playing:
		return
	if not run_sound.playing:
		run_sound.play()
	is_running_sound_playing = true


func stop_running_sound() -> void:
	if run_sound == null:
		return
	if run_sound.playing:
		run_sound.stop()
	is_running_sound_playing = false
