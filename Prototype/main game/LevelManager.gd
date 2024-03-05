extends Node2D
var currentLevelScene : PackedScene
var playerScene : PackedScene
var cameraScene : PackedScene

var player : Player
var level : Level
var camera : PlayerCamera

## Settings
var respawnTime : float = 2

# values 
var resetting : bool = false
var cancelRespawn : bool

var introInProcess : bool


func loadLevel(LevelName : String) -> void:
	cancelRespawn = true
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
	player.canFire = false
	player.canMove = false
	
	cameraScene = preload("res://main game/PlayerCamera.tscn")
	camera = cameraScene.instantiate() as Node2D
	add_child(camera)

	
	StartLevel()
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	loadLevel("TestLevel")

func _process(_delta):
	pass

func _input(event):
	if event is InputEventKey and event.keycode == KEY_R:
		cancelRespawn = false
		reset()

func StartLevel():
	assert(level != null , "No level present in world")
	assert(player != null , "No player present in world")
	
	for _node in level.get_children():
		if _node.is_in_group("deadzone"):
			_node.body_entered.connect(EnterDeadZone)
	
	IntroLevel()

func IntroLevel():
	var tempCamera : PlayerCamera = camera
	introInProcess == true
	for _node in level.get_children():
		if _node.is_in_group("levelEnd"):
			tempCamera.setTarget(_node)
	await get_tree().create_timer(0.75).timeout
	if tempCamera != null:
		tempCamera.setTarget(player)
		player.canMove = true
		player.canFire = true


# Checks if player has entered collsion section and starts respawn procedure
# if this is the case
func EnterDeadZone(body: Node2D) -> void:
	
	if body.name == "Player":
		print("dead zone ")
		killPlayer()
	
# Resets the level and respawns the player at the default spawn point
# Need to change later if support for checkpoints is added
func reset() -> void:
	if cancelRespawn:
		cancelRespawn = false
		print("cancel respawn")
		return
	if resetting == true: 
		return
	resetting = true
	destroyAllBullets()
	level.Respawn()
	player.Respawn(level.getSpawnPosition())
	camera.drag_horizontal_enabled = false
	camera.drag_vertical_enabled = false
	await get_tree().create_timer(0.1).timeout
	camera.drag_horizontal_enabled = true
	camera.drag_vertical_enabled = true
	resetting = false

# reset but for when player dies
func killPlayer() -> void:
	cancelRespawn = false
	player.Died()
	await get_tree().create_timer(respawnTime).timeout
	reset()

func destroyAllBullets() -> void:
	for _node in get_children():
		if _node is Bullet:
			_node.destroyBullet()


