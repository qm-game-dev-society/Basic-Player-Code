extends Gun

 
func _ready():
	name = "Test gun"
	BulletScene = preload("res://entites/guns/bullet scenes/bullet.tscn")
	AutoFire = false
	ReloadTime = 3
	CoolDown = 0.2
	SpreadAmount = 0.1


func FIRE(prepTime : float) -> void:
	InstantiateBullet()
