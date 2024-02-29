class_name Level
extends Node2D

var _levelName : String
var _spawnPosition : Vector2

func setName(LevelName : String) -> void:
	_levelName = LevelName

func getName() -> String:
	return _levelName

func setSpawnPosition(spawn : Vector2):
	_spawnPosition = spawn

func getSpawnPosition() -> Vector2:
	return _spawnPosition

func Respawn():
	for child in self.get_children():
		if(child.is_in_group("entity")):
			var enemy : Entity = child as Entity
			enemy.reset()




