extends Node2D

var player : Player
var level : Level

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("Player") as Player
	level = get_node("Level") as Level
	
	
	# Gets all the area2Ds marked as automatically killing the player
	# (Eg falling off the map) and attaches their body entered signal to the
	# Dead zone method
	for _node in level.get_children():
		if _node.name == "DeadZone":
			_node.body_entered.connect(DeadZone)

# Checks if player has entered collsion section and starts respawn procedure
# if this is the case
func DeadZone(body: Node2D) -> void:
	if body.name == "Player":
		player.Died()
		respawn()
	
# Resets the level and respawns the player at the default spawn point
# Need to change later if support for checkpoints is added
func respawn() -> void:
	level.Respawn()
	player.Respawn(level.getSpawnPosition())



