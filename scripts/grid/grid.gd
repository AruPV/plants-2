# Grid Class. Parent node for the layers that hold the logic for
# both the background of the grid and the plants on top of it
extends Area2D
class_name Grid

# Only works with even tile counts ATM
const tile_y_count = 8
const tile_x_count = 8
const tile_size = 16

@onready var grass_layer: TileMapLayer = $GrassLayer as TileMapLayer
@onready var plant_layer: TileMapLayer = $PlantLayer as TileMapLayer
@onready var collider: CollisionShape2D = $GridCollider as CollisionShape2D

func _ready() -> void:
	# Determine min and max coords for used cells
	var max_x = tile_x_count/2 - 1
	var min_x = -(tile_x_count/2)
	var max_y = tile_y_count/2 - 1
	var min_y = -(tile_y_count/2)

	# Set cells as used cells
	for x in range (min_x, max_x+1):
		for y in range (min_y, max_y+1):
			print("x: " + str(x) + ", y: " + str(y))
			grass_layer.set_cell(Vector2i(x,y), 0, Vector2i(0,0))

	# Change the size of the Collider appropriatedly
	collider.resize(Vector2(tile_size*tile_x_count,tile_size*tile_y_count))
	print("Used cells" + str(grass_layer.get_used_cells()))

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event.is_class("InputEventMouseButton") and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var local_pos = grass_layer.to_local(get_local_mouse_position())
			var map_pos = grass_layer.local_to_map(local_pos)
			var cell_coords = grass_layer.get_cell_atlas_coords(map_pos)
			handle_cell_click(map_pos)
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			pass


func handle_cell_click(cell_coords: Vector2) -> void:
	plant_layer.click(cell_coords)
	pass
