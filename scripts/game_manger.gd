extends Node

var score = 0
var health = 3

func _ready() -> void:
	add_to_group("game_manager")

func add_point() -> void:
	score += 1

func take_damage() -> void:
	health = max(0, health - 1)
	if health == 0:
		print("Player died")

func update_ui() -> void:
	pass

