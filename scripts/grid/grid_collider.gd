extends CollisionShape2D

@export var show_debug = true

func _ready():
	# Make sure we redraw whenever the shape changes
	resize(Vector2(16*2,16*2))
	shape.changed.connect(_on_shape_changed)

func _draw():
	if not show_debug or not shape:
		return
	var rect = Rect2(
		-shape.size/2,  # Position (centered)
		shape.size      # Size
	)
	draw_rect(rect, debug_color)

func _on_shape_changed():
	queue_redraw()

# Resizes the shape of the collision. Called by Grid parent
# Upon scene instantiation
func resize(new_size: Vector2) -> void:
	self.shape.set_size(new_size)
