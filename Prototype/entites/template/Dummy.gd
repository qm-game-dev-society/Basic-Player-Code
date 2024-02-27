class_name Entity
extends CharacterBody2D

var cooldown : float
var hurt : int

func hit(damage:int) -> void:
	hurt += damage
	cooldown = 5

func _process(delta):
	if cooldown > 0:
		$Label.text = str(hurt)
		cooldown -= delta
	else:
		$Label.text = ""
		hurt = 0

