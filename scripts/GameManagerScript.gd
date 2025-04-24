extends Node

var health = 5

func trapDamage():
	health -= 1
	print("Player lost 1 health")
	if health <= 0:
		print("Player died, reloading scene")
		get_tree().reload_current_scene()
