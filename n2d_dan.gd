extends Sprite2D

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
		print( self.frame )
		pass

func _physics_process( _delta ) :
	DANMETHOD_animate_dan()

# Called when the node enters the scene tree for the first time.
func _ready(): 
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process( _delta ):
	pass
