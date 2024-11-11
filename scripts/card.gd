extends RigidBody2D


@onready var collider: CollisionShape2D = $CollisionShape2D as CollisionShape2D
var is_held = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("kahoots")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_input_event(viewport:Node, event:InputEvent, shape_idx:int) -> void:
	if event.is_class("InputEventMouseButton") and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			print("picked up!")
			is_held = true
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			print("dropped")
			is_held = false
	elif is_held && event.is_class("InputEventMouseMotion"):
		print(event)


func _on_mouse_entered() -> void:
	print("aye")
	pass # Replace with function body.

