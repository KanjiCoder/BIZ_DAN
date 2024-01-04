extends Node

var dan_var =( 200 )
@onready var psr_dan = preload( "res://s2d_dan.tscn" )
@onready var psr_boom : PackedScene = preload( "res://s2d_boom.tscn" )
@onready var n2d_world : Node2D = get_tree().root.get_child(0)

## DONT DO THIS , IT MAKES IDEMPOTENTNESS OF READY FUCKING HARD ####
## @onready var DANDATA_s2d_dan   : Sprite2D = psr_dan.instantiate()
var DANDATA_s2d_dan : Sprite2D =( null )
var DANDATA_number_of_dans : int =( 0 )

func DANFUNC_err( i_err_msg : String ):
	print( i_err_msg )
	get_tree().quit()
	pass
	
func DANFUNC_INI():
	DANFUNC_spawn_dan_at_start_position( )

func DANFUNC_ready():
	## DO NOTHING, MANUALLY MANAGE INITIALIZATION ORDER ##
	pass

func DANFUNC_kill_dan_with_explosion( s2d_dan ) :

	var s2d_boom = psr_boom.instantiate()
	s2d_dan =( n2d_world.DANDATA_s2d_dan )
	s2d_boom.position.x =( s2d_dan.position.x )
	s2d_boom.position.y =( s2d_dan.position.y )
	n2d_world.add_child( s2d_boom )

	n2d_world.WORLDFUNC_you_died()

func DANFUNC_spawn_dan_at_start_position( ) :
	pass
	DANFUNC_create_dan_if_dan_not_exist( )
	DANFUNC_print_number_of_dans()
	pass
	var client_area : Vector2i = DisplayServer.window_get_size( 0 )
	DANDATA_s2d_dan.position.x =( client_area.x / 2 )
	DANDATA_s2d_dan.position.y =( 128 )
	pass

func DANFUNC_print_number_of_dans( ):
	print( "[_NUMBER_OF_DANS_]" , DANDATA_number_of_dans )
	pass
	
func DANFUNC_create_dan_if_dan_not_exist( ):
	if( null == DANDATA_s2d_dan ) :
		DANDATA_s2d_dan = psr_dan.instantiate()
		n2d_world.add_child( DANDATA_s2d_dan )
		n2d_world.DANDATA_s2d_dan =( DANDATA_s2d_dan ) ##HACKISH_AS_FUCK##
		DANDATA_number_of_dans +=( 1 )
		DANFUNC_print_number_of_dans()
		if( DANDATA_number_of_dans > 1 ):
			DANFUNC_err( "[_TOO_MANY_DANS_]" )

# Called when the node enters the scene tree for the first time.
func _ready():
	DANFUNC_ready()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	## FOR_DAN_UPDATE_CODE_SEE[ n2d_dan.gd ] ##
	pass
