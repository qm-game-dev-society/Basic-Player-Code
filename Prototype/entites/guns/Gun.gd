class_name Gun
extends Node2D

signal GunAction(name : String)



var _GunName
var _HoldDown : bool
var _ReloadTime : float
var _CoolDown : float



func _ready():
	SetName("GUN")

func SetName(gunName: String):
	_GunName = gunName

func GetName() -> String:
	return _GunName

func SetReloadTime(time : float):
	_ReloadTime = time

func GetReloadTime() -> float:
	return _ReloadTime

func SetCoolDownTime(time : float):
	_CoolDown = time

func GetCoolDownTime() -> float:
	return _CoolDown

func FIRE(prepTime : float) -> void: # Actived when gun is fired
	print("fire gun:" + _GunName + ", prepTime:" + str(prepTime))

func RELOAD() -> void: # Activated when reload key is pressed
	print("reloaded gun:" + _GunName)

func ARM() -> void: # Activated when gun is armed
	print("armed gun:" + _GunName)

func UNARM() -> void: # Activated when gun is unarmed
	print("unarmed gun:" + _GunName)

