extends Position3D

onready var audio_sfx = $AudioEffect
onready var anim = $AnimationPlayer
onready var shot_sfx = preload("res://prefabs/player_demo/soundscrate-gun-shot-1.wav")
onready var shot_particle = preload("res://prefabs/player_demo/Shot_Effect.tscn")
onready var gun_barrel = $Gun_Barrel
onready var fire_timer = $Timer

export(float, 0.1, 1.0, 0.01) var fire_rate = 0.16
export(int, 10, 30) var max_bullet = 15
export(int, 1, 10) var reload_time = 1.6

var can_shoot = true
var bullet_count = 0

signal s_ammo(b_count)
signal s_reload(r_delay)


func _ready():
	audio_sfx.stream = shot_sfx
	fire_timer.wait_time = fire_rate
	bullet_count = max_bullet
	pass
	
func _physics_process(delta):
	
	if Input.is_action_just_pressed("fire"):
		
		if can_shoot and bullet_count > 0:
			bullet_count -= 1
			fire_timer.start()
			_shoot()
			can_shoot = false
			
	if Input.is_action_just_pressed("reload"):
		can_shoot = false
		bullet_count = 0
		_update_hud()
		emit_signal("s_reload", reload_time)
		yield(get_tree().create_timer(reload_time), "timeout")
		bullet_count = max_bullet
		can_shoot = true
		_update_hud()
		


func _shoot():
	var shot_eff = shot_particle.instance()
	shot_eff.translation = gun_barrel.translation
	add_child(shot_eff)
	audio_sfx.playing = true
	anim.play("fire")
	_update_hud()
	
func _update_hud():
	emit_signal("s_ammo", bullet_count)
	
	
	
	


func _on_Timer_timeout():
	can_shoot = true
