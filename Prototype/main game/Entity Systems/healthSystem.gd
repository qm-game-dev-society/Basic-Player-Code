class_name HealthSystem
extends Node

signal died

var _maxHealth  : int
var _currentHealth : int

func _ready():
	_currentHealth = _maxHealth

func CurrentHealth() -> int:
	return _currentHealth

func ChangeHealth(change: int) -> void:
	_currentHealth += change
	CheckDead()

func Kill() -> void:
	died.emit()
	_currentHealth = 0

func ResetHealth() -> void:
	_currentHealth = _maxHealth

func CheckDead() -> void:
	if _currentHealth <= 0:
		died.emit()

