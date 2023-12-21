extends Sprite2D
### ################################################## ###
### GOOSE COLLISION HANDLER IS IN [ s2d_goose ] Script ###
### ################################################## ###

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
		pass

func _physics_process( _delta ) :
	##if( self.offset.x != 0 ) :
	##	self.position.x = self.offset.x
	##	self.offset.x = 0
	##if( self.offset.y != 0 ) :
	##	self.position.y = self.offset.y
	##	self.offset.y = 0
		
	
	DANMETHOD_animate_dan()

# Called when the node enters the scene tree for the first time.
func _ready(): 
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process( _delta ):
	pass
