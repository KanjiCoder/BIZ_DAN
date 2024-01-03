extends Sprite2D
@onready var n2d_world : Node2D = get_tree().root.get_child(0)
var psr_boom : PackedScene = preload( "res://s2d_boom.tscn" )
var nod_dancode : Node =( null )
var s2d_dan  : Sprite2D =( null )
var goose_speed : int = 3
var m_manager_index : int =( 0-1 )

func _on_a2d_goose_body_entered( body ):
	print( "[_NEXT_TIME_GOOSE_COLLISION_CODE_HERE_]" )
	var s2d_boom = psr_boom.instantiate()
	s2d_dan =( n2d_world.DANDATA_s2d_dan )
	s2d_boom.position.x =( s2d_dan.position.x )
	s2d_boom.position.y =( s2d_dan.position.y )
	n2d_world.add_child( s2d_boom )

	## TODO HERE : _DAN_SHOULD_HAVE_INVINCIBLE_PERIOD_SO_WE_DONT_CALL_DIE_FUNCTION_REPEATEDLY_
	var nod_dancode = n2d_world.nod_dancode
	n2d_world.WORLDFUNC_you_died()
	
	pass # Replace with function body.

func GOOSEMETHOD_free_my_goose_to_the_afterlife( ):

	## Use this free method to release our goose from 
	## the tracking manager array so that we can :
	## 1. Prevent Stale References From Being In Goose Array
	## 2. Be able to free all geese when dan gets blown up 

	var dex : int = self.m_manager_index
	var m_e  = n2d_world.WORLDDATA_array_goose[ dex ]
	if( m_e == self ) :
		print( "[_IAM_ME_AND_I_SHALL_RELEASE_MYSELF_FROM_MY_MANAGER_]" )
		n2d_world.WORLDDATA_array_goose[ dex ] =( null )
		pass

	self.queue_free()

func _physics_process( _delta ) :
	position.y -= goose_speed
	if( position.y < (0-512) ) : GOOSEMETHOD_free_my_goose_to_the_afterlife() 
	pass
	
func _ready():
	pass # Replace with function body.
	
func _process( _delta ):
	pass


## ARE YOU FUCKING KIDDING ME ?
## It has to be "a_2d" instead of "a2d" ?
##  func _on_a_2d_goose_body_entered(body):
##	print( "[WHAT_THE_FUCKING_HELL_HOW_DO_I_WIRE_THIS_UP]" )
##	pass # Replace with function body.
	

	
	
	
	
