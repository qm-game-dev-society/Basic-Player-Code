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

var BulletDammage : float
var BulletCritical : float
var BulletRate : float
var BulletVelocity
var BulletSpread : float 
var BulletPierce : float 


func angleGun():
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
	print(bullet.get_parent().name)
	bullet.global_position = global_position
	bullet.global_rotation = global_rotation + PI*SpreadAmount*randf_range(-(BulletSpread), BulletSpread)/6
	SetBulletValues(bullet)
	return bullet

func SetBulletValues(bullet) -> void:
	bullet.bullet_dammage = BulletDammage
	bullet.bullet_critical = BulletCritical
	bullet.bullet_velocity = BulletVelocity
	bullet.pierce = BulletPierce


func DestroyAllBullets() -> void:
	pass
