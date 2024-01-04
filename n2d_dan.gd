extends Sprite2D
### ################################################## ###
### GOOSE COLLISION HANDLER IS IN [ s2d_goose ] Script ###
### ################################################## ###

@onready var n2d_world : Node2D = get_tree().root.get_child(0)

var fucking_frame_property_value =( 0 )
var held_frames =( 3 ) ## ZERO OR LOWER MAKES ZERO SENSE ! ##
var hold_index  =( 0 )

func DANMETHOD_animate_dan( ) :
	hold_index -=( 1 )
	if( hold_index <= 0 ) :
		hold_index = held_frames
		fucking_frame_property_value += 1
		fucking_frame_property_value =( fucking_frame_property_value % 2 )
		self.frame =( fucking_frame_property_value )
		##p_rint( self.frame )

	if( n2d_world.WORLDDATA_invincible_grace_period_countdown >= 1 ) :
		self.visible =( ! self.visible )
	else :
		self.visible =( true )

		pass

func DANMETHOD_maybe_dan_should_fall_maybe_he_shouldnt( ) :

	if( n2d_world.WORLDDATA_percent_scroll >= 1.0 ) :
		self.position.y +=( n2d_world.nod_configcode.CONFIGDATA_fall_into_hay_speed )

func DANMETHOD_maybe_dan_hit_the_ground_really_hard_and_should_die( ) :

	var client_area : Vector2i = DisplayServer.window_get_size( 0 )
	var bottom_edge =( client_area.y - 1 )
	if( self.position.y >=( bottom_edge - 32 ) ) :
		var s2d_dan =( self )
		n2d_world.nod_dancode.DANFUNC_kill_dan_with_explosion( s2d_dan )

func _physics_process( _delta ) :
	##if( self.offset.x != 0 ) :
	##	self.position.x = self.offset.x
	##	self.offset.x = 0
	##if( self.offset.y != 0 ) :
	##	self.position.y = self.offset.y
	##	self.offset.y = 0
	
	DANMETHOD_animate_dan()
	DANMETHOD_maybe_dan_should_fall_maybe_he_shouldnt()
	DANMETHOD_maybe_dan_hit_the_ground_really_hard_and_should_die()

# Called when the node enters the scene tree for the first time.
func _ready(): 
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process( _delta ):
	pass
