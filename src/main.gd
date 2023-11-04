extends Node

@export var circle_scene : PackedScene
@export var cross_scene : PackedScene
@onready var markers = get_node("Markers")
@onready var marker_circle = get_node("hud/marker_paper/Circle")
@onready var marker_cross = get_node("hud/marker_paper/Cross")
@onready var animated_stamp = get_node("animated_stamp")
@onready var winner_indicator_x = get_node("game_over/winner_holder/X")
@onready var winner_indicator_o = get_node("game_over/winner_holder/O")
@onready var timer = get_node("game_over/Timer")
@onready var camera_movement = get_node("Camera2D/AnimationPlayer")
@onready var badge = get_node("game_over/winner_holder/badge")



@onready var stomp = get_node("stomp")
@onready var button = get_node("Camera2D/button")
@onready var drop = get_node("Camera2D/drop")

@onready var button_1 = $"Board_Design/Buttons/1"
@onready var button_2 = $"Board_Design/Buttons/2"
@onready var button_3 = $"Board_Design/Buttons/3"
@onready var button_4 = $"Board_Design/Buttons/4"
@onready var button_5 = $"Board_Design/Buttons/5"
@onready var button_6 = $"Board_Design/Buttons/6"
@onready var button_7 = $"Board_Design/Buttons/7"
@onready var button_8 = $"Board_Design/Buttons/8"
@onready var button_9 = $"Board_Design/Buttons/9"

var grid_data : Array
var player : int
var moves : int
var winner : int

var row_sum : int
var col_sum : int
var diagonal1_sum : int
var diagonal2_sum : int

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()

func _on_1_released():
	if update_grid_data(0, 0):
		create_marker(button_1.get_position())
	

func _on_2_released():
	if update_grid_data(0, 1):
		create_marker(button_2.get_position())
		stamp(button_2.get_position())
	

func _on_3_released():
	if update_grid_data(0, 2):
		create_marker(button_3.get_position())
	

func _on_4_released():
	if update_grid_data(1, 0):
		create_marker(button_4.get_position())
	

func _on_5_released():
	if update_grid_data(1, 1):
		create_marker(button_5.get_position())
	

func _on_6_released():
	if update_grid_data(1, 2):
		create_marker(button_6.get_position())
	

func _on_7_released():
	if update_grid_data(2, 0):
		create_marker(button_7.get_position())
	

func _on_8_released():
	if update_grid_data(2, 1):
		create_marker(button_8.get_position())
	

func _on_9_released():
	if update_grid_data(2, 2):
		create_marker(button_9.get_position())
	

func update_grid_data(row, col):
	if grid_data[row][col] == 0:
		if player == 1:
			grid_data[row][col] = 1			
			player = 2
		else:
			player = 1
			grid_data[row][col] = -1
		return true
	return false
	
func create_marker(position):
	if winner == 0:
		stamp(position)
		if player == 1:
			var circle = circle_scene.instantiate()
			circle.position = position
			markers.add_child(circle)
			marker_circle.visible = false
			marker_cross.visible = true
		else: 	
			var cross = cross_scene.instantiate()
			cross.position = position
			markers.add_child(cross)
			marker_circle.visible = true
			marker_cross.visible = false
		check_win()
		if winner:
			timer.start()
						
		
func new_game():
	grid_data = [
		[0, 0, 0],
		[0, 0, 0],
		[0, 0, 0]
	]
	player = 1
	moves = 0
	winner = 0
	winner_indicator_o.visible = false
	winner_indicator_x.visible = false
	marker_circle.visible = false
	marker_cross.visible = true
	if markers != null:
		var child_count = markers.get_child_count()
		for i in range(child_count):
			var child = markers.get_child(i)
			child.queue_free()

func check_win():
	#add up the markers in each ros, column and diagonal
	for i in len(grid_data):
		row_sum = grid_data[i][0] + grid_data[i][1] + grid_data[i][2]
		col_sum = grid_data[0][i] + grid_data[1][i] + grid_data[2][i]
		diagonal1_sum = grid_data[0][0] + grid_data[1][1] + grid_data[2][2]
		diagonal2_sum = grid_data[0][2] + grid_data[1][1] + grid_data[2][0]
	
		#check if either player has all of the markers in one line
		if row_sum == 3 or col_sum == 3 or diagonal1_sum == 3 or diagonal2_sum == 3:
			winner = 1
		elif row_sum == -3 or col_sum == -3 or diagonal1_sum == -3 or diagonal2_sum == -3:
			winner = -1
	moves += 1
	if moves == 9 and winner == 0:
		winner = 3	
		marker_circle.visible = true
		marker_cross.visible = true
		return winner
	return winner
	
func stamp(position):
	animated_stamp.stop()
	animated_stamp.visible = true
	animated_stamp.set_position(position)
	animated_stamp.play("stamp")
	stomp.play()

func _on_animated_stamp_animation_finished():
	animated_stamp.visible = false


func _on_timer_timeout():
	if winner == 1:
		winner_indicator_x.visible = true
		winner_indicator_o.visible = false
	elif winner == -1:
		winner_indicator_x.visible = false
		winner_indicator_o.visible = true
	else:
		winner_indicator_x.visible = true
		winner_indicator_o.visible = true
	camera_movement.play("game_over")
	badge.play("drop")

func _on_play_again_button_up():
	button.play()
	new_game()
	camera_movement.play("play_again")
	pass # Replace with function body.

func _on_reset_button_up():
	button.play()
	new_game()

func _on_quit_button_up():
	get_tree().change_scene_to_file("res://src/menu.tscn")


func _on_main_menu_button_up():
	get_tree().change_scene_to_file("res://src/menu.tscn")


func _on_main_menu_button_down():
	button.play()


func _on_play_again_button_down():
	button.play()
