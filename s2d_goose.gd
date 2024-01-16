extends Sprite2D
@onready var n2d_world : Node2D = get_tree().root.get_child(0)
var psr_boom : PackedScene = preload( "res://s2d_boom.tscn" )
var nod_dancode : Node =( null )
var s2d_dan  : Sprite2D =( null )
var goose_speed : int = 0 ## SET IN INITIALIZER CODE ##
var m_manager_index : int =( 0-1 )

var m_goose_has_honked : int =( 0-1 )

func _on_a2d_goose_body_entered( body ): ## TAG[ _on_body_entered ] ##

	s2d_dan =( n2d_world.DANDATA_s2d_dan )

	if( true == n2d_world.nod_configcode.CONFIGDATA_god_mode_cant_touch_this ):
		n2d_world.nod_dancode.DANFUNC_spawn_explosion_at_dan_location( s2d_dan )
		return ## DAN IS GOD AND YOU CANNOT TOUCH GOD  ##

	if( n2d_world.WORLDDATA_invincible_grace_period_countdown >= 1 ) :
		n2d_world.nod_dancode.DANFUNC_spawn_explosion_at_dan_location( s2d_dan )
		return ## DO NOT INTERACT IF INVINCIBLE PERIOD ##


	n2d_world.nod_dancode.DANFUNC_kill_dan_with_explosion( s2d_dan )

	## This should be inside of the "KILL_DAN" function ##
	## var nod_dancode = n2d_world.nod_dancode
	## n2d_world.WORLDFUNC_you_died()
	
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
	pass
	pass
	var dan_position_y : int =( n2d_world.DANDATA_s2d_dan.position.y )
	if( position.y <= ( dan_position_y + 256 ) ) :
		if( m_goose_has_honked <= 0 ) :
			m_goose_has_honked =  1 
			$ASP_GOOSE.play( )
	
func _ready():

	### JBI_021 : All Things Falling At Same Speed #############
	n2d_world.nod_birdcode.GOOSEFUNC_init_goose_speed( self )

	pass # Replace with function body.
	
func _process( _delta ):
	pass


## ARE YOU FUCKING KIDDING ME ?
## It has to be "a_2d" instead of "a2d" ?
##  func _on_a_2d_goose_body_entered(body):
##	print( "[WHAT_THE_FUCKING_HELL_HOW_DO_I_WIRE_THIS_UP]" )
##	pass # Replace with function body.
	

	
	
	
	
