extends Sprite2D

var boom_frame : int = (0-1) 

################################################################
## Explosions don't need a fancy manager :                    ##
## DONT_NEED : WORLDDATA_array_explosion_length               ##
## DONT_NEED : WORLDDATA_array_explosion                      ##
## Once the explosion is older than 3 seconds , remove it !   ##
## HOLY FUCK.... We are already doing that with "boom_frame" !##
## I thought I was about to fix a memory leak.                ##
## -KanjiCoder                                                ##
## var m_manager_index : int =( 0-1 )                         ##
################################################################

func _physics_process( _delta ):
	boom_frame += 1
	self.set_frame( boom_frame ) 
	if( boom_frame >= 11 ): self.queue_free()
	pass
	
func _ready():
	pass # Replace with function body.
func _process(delta):
	pass
