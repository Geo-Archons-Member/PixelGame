extends Node

var sfx_volume
var bgm_volume

var sfx_toggle
var bgm_toggle

func _ready():
	if bgm_toggle == null:
		bgm_toggle = true
	if sfx_toggle == null:
		sfx_toggle = true

func toggle_sfx():
	if sfx_toggle == true:
		sfx_toggle = false
		sfx_volume = -100
	else:
		sfx_toggle = true
		sfx_volume = 0
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), sfx_volume)
	
func toggle_bgm():
	if bgm_toggle == true:
		bgm_toggle = false
		bgm_volume = -100
	else:
		bgm_toggle = true
		bgm_volume = 0
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("BGM"), bgm_volume)
