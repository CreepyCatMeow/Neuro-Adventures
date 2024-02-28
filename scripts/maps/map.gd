extends Node2D
class_name MAP

@export var BASE_NTX_CHANCE := 0.4
@export var NTX_REQ := 50
@export var PITY_REQ := 300 
@export var PITY_STEP := 0.1

var enemies_killed_since_last_ntx := 0
var ntx_chance := 0.2

#region ACHIEVEMENT RELATED
var gymbag_drone_count := 0
var swarm_max := false 
var raise_the_timer := false 
var say_it_back_max := false 
var dual_strike_max := false 
#endregion

func _ready() -> void:
	
	add_to_group("map")
	Globals.map_ready.emit() 
	spawn_enemies()

func spawn_enemies() -> void:
	pass 
