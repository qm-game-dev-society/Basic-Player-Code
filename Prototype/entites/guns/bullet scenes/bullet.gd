class_name Bullet
extends Node2D

@export var bullet_dammage : float = 10
@export var bullet_critical : float = 0.3
@export var bullet_rate : float = 0.2
@export var autofire : bool = false
@export var bullet_velocity = 10
@export var bullet_spread : float = 0.1
@export var bullet_count : int = 1
@export var pierce : float = 0


func _physics_process(delta):
	position.x += bullet_velocity*cos(global_rotation)
	position.y += bullet_velocity*sin(global_rotation)
	

func _on_timer_timeout():
	destroyBullet()


func _on_area_entered(area):
	if not area.is_in_group("player") and not area.is_in_group("bullet"):
		bullet_dammage = bullet_dammage * pierce
	if bullet_dammage < 1:
		destroyBullet()

func destroyBullet():
	queue_free()
