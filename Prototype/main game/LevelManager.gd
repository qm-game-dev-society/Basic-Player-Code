extends Node2D
var currentLevelScene : PackedScene
var playerScene : PackedScene
var cameraScene : PackedScene

var player : Player
var level : Level
var camera : Camera2D

## Settings
var respawnTime : float = 2

# values 
var resetting : bool = false




func loadLevel(LevelName : String) -> void:
	
	# Clear all nodes currently in world
	# TODO: carry player node over when loading new levels
	for n in get_children():
		remove_child(n)
		n.queue_free()
	
	# Load level node
	currentLevelScene = load("res://levels/" + LevelName + ".tscn")
	level = currentLevelScene.instantiate() as Level
	add_child(level)
	
	playerScene = preload("res://entites/player/player.tscn")
	player = playerScene.instantiate() as Player
	add_child(player)
	player.position = level.getSpawnPosition()
	
	cameraScene = preload("res://main game/PlayerCamera.tscn")
	camera = cameraScene.instantiate() as Node2D
	add_child(camera)
	camera.position = Vector2.ZERO
	
	StartLevel()
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	loadLevel("TestLevel")

func _process(_delta):
	camera.position = player.position

func _input(event):
	if event is InputEventKey and event.keycode == KEY_R:
		reset()

func StartLevel():
	assert(level != null , "No level present in world")
	assert(player != null , "No player present in world")
	
	for _node in level.get_children():
		if _node.is_in_group("deadzone"):
			_node.body_entered.connect(EnterDeadZone)

# Checks if player has entered collsion section and starts respawn procedure
# if this is the case
func EnterDeadZone(body: Node2D) -> void:
	print("hello")
	if body.name == "Player":
		killPlayer()
	
# Resets the level and respawns the player at the default spawn point
# Need to change later if support for checkpoints is added
func reset() -> void:
	if resetting == true: 
		return
	resetting = true
	camera.position_smoothing_enabled = false
	destroyAllBullets()
	level.Respawn()
	player.Respawn(level.getSpawnPosition())
	await get_tree().create_timer(0.3).timeout
	camera.position_smoothing_enabled = true
	resetting = false

# reset but for when player dies
func killPlayer() -> void:
	player.Died()
	await get_tree().create_timer(respawnTime).timeout
	reset()

func destroyAllBullets() -> void:
	for _node in get_children():
		if _node is Bullet:
			_node.destroyBullet()


