extends Level


# Currently just sets level info using base class (Level class) methods
func _ready():
	setName("Test world")
	setSpawnPosition(Vector2(1 , -23))

