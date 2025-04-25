extends Area2D

@onready var trap_timer: Timer = $Timer
@onready var restart_timer: Timer = $RestartTimer
@onready var fire: GPUParticles2D = $Fire
@onready var hitbox: CollisionShape2D = $Hitbox
@onready var game_manager: Node2D = $"../../GameManager"


var trap_on := false
var damage = 1

func _ready() -> void:
	trap_timer.start()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		game_manager.trapDamage()


func _on_timer_timeout() -> void:
	trap_on = false
	hitbox.disabled = true
	fire.emitting = false
	restart_timer.start()


func _on_restart_timer_timeout() -> void:
	trap_on = true
	hitbox.disabled = false
	fire.emitting = true
	trap_timer.start()
