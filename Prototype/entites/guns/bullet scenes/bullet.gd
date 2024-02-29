class_name Bullet
extends Area2D

@export var bullet_dammage : float
@export var bullet_critical : float 
@export var bullet_velocity: float
@export var pierce : float 


func _physics_process(_delta):
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


func _on_body_entered(body):
	if(body is Entity):
		var entity = body as Entity
		entity.hit(bullet_dammage)
		bullet_dammage = bullet_dammage * pierce
		print(bullet_dammage)
	if bullet_dammage < 1:
		destroyBullet()

	if(body.is_in_group("ground")):
		destroyBullet()
