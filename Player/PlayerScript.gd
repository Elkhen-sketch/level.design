extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var dash_timer: Timer = $DashTimer
@onready var dash_again_timer: Timer = $DashAgain

const GRAVITY = 1000
const SPEED = 300 
const Jump = -340
const Jump_horizontal = 100
const dash_speed = 900
enum State { Idle, Run, Shoot }

var dash_dir = 0
var doubleJumped := false
var current_state : State
var is_sb = false
var can_sb = true
var gravity = -9.8

func _ready():
	current_state = State.Idle

func _physics_process(delta):
	player_falling(delta)
	player_Idle(delta)
	player_run(delta)

	if Input.is_action_just_pressed("dash") and can_sb:
		print("Dashed!")
		is_sb = true
		can_sb = false
		dash_timer.start()
		dash_again_timer.start()

	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		doubleJumped = false

	if Input.is_action_just_pressed("jump") and (is_on_floor() or !doubleJumped):
		velocity.y = Jump
		if !is_on_floor():
			doubleJumped = true

	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

	move_and_slide()
	player_animations()


func player_falling(delta):
	if !is_on_floor():
		velocity.y += GRAVITY * delta 

func player_Idle(delta):
	if is_on_floor():
		current_state = State.Idle

func player_run(delta):
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		if is_sb:
			velocity.x = direction * dash_speed
			velocity.y = 0
		else:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction != 0:
		current_state = State.Run
		animated_sprite_2d.flip_h = false if direction > 0 else true


func player_animations():
	if current_state == State.Idle:
		animated_sprite_2d.play("Idle")
	elif current_state == State.Run and animated_sprite_2d.animation != "Shot1":
		animated_sprite_2d.play("Run")

	elif current_state == State.Shoot:
		animated_sprite_2d.play("Shot1")
	#match current_state:
		#State.Idle:
		#	animated_sprite_2d.play("Idle")
		#State.Run:
			#animated_sprite_2d.play("Run")
		#State.Jump:
			#animated_sprite_2d.play("Jump")
		#State.Shoot:
			#animated_sprite_2d.play("Shot1")

func _on_dash_timer_timeout() -> void:
	is_sb = false

func _on_dash_again_timeout() -> void:
	can_sb = true
