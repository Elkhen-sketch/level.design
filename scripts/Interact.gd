extends Area2D

@export var text = ""
@export var next_text = ""

@onready var player: CharacterBody2D = $"../Player"
@onready var timer: Timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player.label.text = text

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player.label.text = next_text
		timer.start()

func _on_timer_timeout() -> void:
	player.label.text = ""
