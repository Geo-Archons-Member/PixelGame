extends Node

var player : int
var grid_data : Array

#initiate at start
func _ready():
	
	new_game()

#main process
func _process(delta):
	pass

				
func new_game():
	player = 1
	grid_data = [ 
		[0,0,0],
		[0,0,0],
		[0,0,0]
	]

func _on_1_released():
	print("click")
	pass # Replace with function body.

func _on_2_released():
	print("click")
	pass # Replace with function body.

func _on_3_released():
	print("click")
	pass # Replace with function body.


func _on_4_released():
	print("click")
	pass # Replace with function body.


func _on_5_released():
	print("click")
	pass # Replace with function body.


func _on_6_released():
	print("click")
	pass # Replace with function body.


func _on_7_released():
	print("click")
	pass # Replace with function body.


func _on_8_released():
	print("click")
	pass # Replace with function body.


func _on_9_released():
	print("click")
	pass # Replace with function body.
