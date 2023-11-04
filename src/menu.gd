extends Node

@onready var button = get_node("button")
@onready var bgm = get_node("bgm")
@onready var title = get_node("Camera2D/title")
@onready var camera = get_node("Camera2D/camera")
@onready var settings = get_node("Camera2D/settings_marker/settings_animation")


func _ready():
	if AudioServer.get_bus_volume_db(AudioServer.get_bus_index("BGM")) == -100:
		bgm_on.visible = false
		bgm_off.visible = true
		bgm_toggle = false
	if AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")) == -100:
		sfx_on.visible = false
		sfx_off.visible = true
		sfx_toggle = false
	bgm.play()
	title.play("intro")
	camera.play("camera")
	

func _on_play_button_up():
	get_tree().change_scene_to_file("res://src/main.tscn")
	
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		get_tree().quit()

func _on_quit_button_up():
	button.play()
	get_tree().quit()

func _on_play_button_down():
	button.play()


func _on_settings_button_up():
	settings.play("open_settings")


func _on_settings_button_down():
	button.play()

func _on_back_button_down():
	button.play()

func _on_back_button_up():
	settings.play("exit_settings")


func _on_sfx_toggle_button_down():
	button.play()

func _on_bgm_toggle_button_down():
	button.play()

@onready var sfx_on = get_node("Camera2D/settings_marker/sfx_toggle/X")
@onready var sfx_off = get_node("Camera2D/settings_marker/sfx_toggle/O")
@onready var bgm_on = get_node("Camera2D/settings_marker/bgm_toggle/X")
@onready var bgm_off = get_node("Camera2D/settings_marker/bgm_toggle/O")

var sfx_volume
var bgm_volume

var sfx_toggle = true
var bgm_toggle = true

func _on_sfx_toggle_button_up():
	if sfx_toggle == true:
		sfx_on.visible = false
		sfx_off.visible = true
		sfx_toggle = false
		sfx_volume = -100
	else:
		sfx_on.visible = true
		sfx_off.visible = false
		sfx_toggle = true
		sfx_volume = 0
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), sfx_volume)
	

func _on_bgm_toggle_button_up():
	if bgm_toggle == true:
		bgm_on.visible = false
		bgm_off.visible = true
		bgm_toggle = false
		bgm_volume = -100
	else:
		bgm_on.visible = true
		bgm_off.visible = false
		bgm_toggle = true
		bgm_volume = 0
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("BGM"), bgm_volume)
