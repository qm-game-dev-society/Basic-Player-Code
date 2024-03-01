class_name HealthSystem
extends Node

signal died

var _maxHealth  : float
var _currentHealth : float

func _ready():
	add_to_group("HealthSystem")
	_currentHealth = _maxHealth

func CurrentHealth() -> float:
	return _currentHealth

func ChangeHealth(change: float) -> void:
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

