extends Node

var dan_var =( 200 )
@onready var psr_dan = preload( "res://s2d_dan.tscn" )
@onready var n2d_world : Node2D = get_tree().root.get_child(0)
@onready var DANDATA_s2d_dan   : Sprite2D = psr_dan.instantiate()

func DANFUNC_spawn_dan_at_start_position( ) :
	## var s2d_dan = psr_dan.instantiate()
	var client_area : Vector2i = DisplayServer.window_get_size( 0 )
	DANDATA_s2d_dan.position.x =( client_area.x / 2 )
	DANDATA_s2d_dan.position.y =( 128 )
	n2d_world.add_child( DANDATA_s2d_dan )
	n2d_world.DANDATA_s2d_dan =( DANDATA_s2d_dan ) ##HACKISH_AS_FUCK##
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
