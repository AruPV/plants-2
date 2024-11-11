extends RigidBody2D


@onready var collider: CollisionShape2D = $CollisionShape2D as CollisionShape2D

var is_held = false
var local_mouse_position = Vector2(0,0)
var target_position = Vector2(0,0)
var target_rotation = 0.0
var spring_strength = 10
var damping = 1
var rotation_factor = 0.015
var max_rotation = PI/4
var rotation_spring_strength = 8.0
var rotation_damping = 2.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("kahoots")
	pass # Replace with function body.

func _process(_delta: float) -> void:
	if is_held:
		target_position = get_global_mouse_position() - local_mouse_position
		if !Input.is_mouse_button_pressed(1):
			is_held = false


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if target_position:
		var current_pos = state.transform.origin
		var direction = target_position - current_pos

		var velocity = state.linear_velocity

		target_rotation = -velocity.x * rotation_factor

		target_rotation = clamp(target_rotation, -max_rotation, max_rotation)

		# Spring force
		var force = direction * spring_strength
		# Damping (reduces oscillation)
		force -= state.linear_velocity * damping

		var current_rotation = state.transform.get_rotation()
		var rotation_error = target_rotation - current_rotation
		var torque = rotation_error * rotation_spring_strength
		torque -= state.angular_velocity * rotation_damping
		
		state.apply_central_force(force)
		state.apply_torque(torque)

func _on_input_event(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
	if event.is_class("InputEventMouseButton"):
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			print("picked up!")
			is_held = true
			local_mouse_position = get_local_mouse_position()
		elif event.button_index == MOUSE_BUTTON_LEFT && !event.pressed:
			print("dropped")
			is_held = false
	elif is_held && event.is_class("InputEventMouseMotion"):
		target_position = event.position

func _on_mouse_entered() -> void:
	print("aye")

