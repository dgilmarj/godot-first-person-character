extends Node

onready var spawn_point = $Spawn_Point

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	spawn_point.translation = Vector3(0,35,0)
	pass


func _input(event):
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_Dead_Zone_body_entered(body):
	print("DEAD ZONE!")
	body.translation = spawn_point.translation
