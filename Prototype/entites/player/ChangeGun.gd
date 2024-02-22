extends GunState

var scene

# Finds location and loads object for gun to equip in fileSysten
func enter(_msg := {}) -> void:
	assert(_msg.has("gun"), "No Gun named to equip")
	assert(load("res://entites/guns/gunScenes/" + _msg["gun"] + ".tscn") != null, "Gun: " + _msg["gun"] + " does not exist")
	
	scene = load("res://entites/guns/gunScenes/" + _msg["gun"] + ".tscn")
	
	

# Instantiates gun as child of player node and calls ARM method within the 
# gun node then transitions back to idle
func update(_delta: float) -> void:

	player.gun = scene.instantiate()
	player.gun.position = Vector2.ZERO
	player.add_child(player.gun)
	player.gun.ARM()
	state_machine.transition_to("Idle")
