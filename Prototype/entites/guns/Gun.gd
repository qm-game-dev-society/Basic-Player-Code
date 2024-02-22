class_name Gun
extends Node2D

signal GunAction(name : String)

var player : Player

var GunName : String
var BulletScene : PackedScene

var AutoFire : bool
var ReloadTime : float
var CoolDown : float
var SpreadAmount: float



func _ready():
	look_at(get_global_mouse_position())

func _process(_delta):
	look_at(get_global_mouse_position())

func FIRE(prepTime : float) -> void: # Actived when gun is fired
	print("fire gun:" + GunName + ", prepTime:" + str(prepTime))

func RELOAD() -> void: # Activated when reload key is pressed
	print("reloaded gun:" + GunName)

func ARM() -> void: # Activated when gun is armed
	print("armed gun:" + GunName)

func UNARM() -> void: # Activated when gun is unarmed
	print("unarmed gun:" + GunName)

func InstantiateBullet() -> Bullet:
	var bullet : Bullet = BulletScene.instantiate() as Bullet
	get_parent().get_parent().add_child(bullet)
	bullet.global_position = global_position
	bullet.global_rotation = global_rotation + PI*SpreadAmount*randf_range(-(bullet.bullet_spread), bullet.bullet_spread)/6
	player.healthInterface.died.connect(bullet.destroyBullet)
	return bullet

func DestroyAllBullets() -> void:
	pass
