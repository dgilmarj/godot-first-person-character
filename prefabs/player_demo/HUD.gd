extends Control

onready var ammo_label = $VBoxContainer/AmmoLabel
onready var ammo_bar = $VBoxContainer/ProgressBar
onready var hud_tween = $VBoxContainer/Tween

func _ready():
	
	ammo_label.text = str("Ammo: ", get_parent().get_node("Arm/hand/pistol").max_bullet)
	ammo_bar.value = 100
	pass


func _on_pistol_s_ammo(b_count):
	ammo_label.text = str("Ammo: ", b_count)


func _on_pistol_s_reload(r_delay):
	hud_tween.interpolate_property(ammo_bar, "value", 0, 100, r_delay,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	hud_tween.start()

