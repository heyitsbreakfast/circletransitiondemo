extends Node2D


onready var circle_transition = $CircleTransition


func _ready() -> void:
	circle_transition.visible = true
	circle_transition.transition_out()


func _on_Button_pressed() -> void:
	circle_transition.transition_in()


func _on_CircleTransition_transition_in_done() -> void:
	get_tree().change_scene("res://Level/Level.tscn")
