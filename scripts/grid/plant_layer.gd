extends TileMapLayer

var plants: Dictionary

func click(cell_coords: Vector2):
	print(cell_coords)
	var cell_atlas_coords = get_cell_atlas_coords(cell_coords)
	if cell_atlas_coords == Vector2i(-1,-1):
		plant(cell_coords)
	else:
		uproot(cell_coords)


func plant(cell_coords: Vector2):
	print("setting")
	plants[cell_coords] = BasePlant.new()
	print(get_plant(cell_coords).type)
	set_cell(cell_coords, 0, Vector2i(2,1))


func uproot(cell_coords: Vector2):
	print("uprooting")
	erase_cell(cell_coords)


# A work-around the fact that GDScript 4.3 does not have typed
# Dictionaries.
func get_plant(plant_coords: Vector2) -> BasePlant:
	var return_plant: BasePlant = plants[plant_coords]
	return return_plant
