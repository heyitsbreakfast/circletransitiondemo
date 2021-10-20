extends KinematicBody2D


export var ACCELERATION = 500
export var MAX_SPEED = 100
export var FRICTION = 500


onready var animation_tree = $AnimationTree
onready var animation_player = $AnimationPlayer
onready var animation_state = animation_tree.get("parameters/playback")
onready var collision = $CollisionShape2D
onready var shadow = $Shadow
onready var sprite = $Sprite


var velocity = Vector2.ZERO


func _ready() -> void:
	pass


func _physics_process(delta):
	
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		animation_tree.set("parameters/Run/blend_position", input_vector)
		animation_tree.set("parameters/Idle/blend_position", input_vector)
		animation_state.travel("Run")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		animation_state.travel("Idle")
	
	move()


func _input(event: InputEvent) -> void:
	pass


func move():
	velocity = move_and_slide(velocity)
