extends Sprite2D

var boom_frame : int = (0-1) 

func _physics_process( _delta ):
	boom_frame += 1
	self.set_frame( boom_frame ) 
	if( boom_frame >= 11 ): self.queue_free()
	pass
	
func _ready():
	pass # Replace with function body.
func _process(delta):
	pass
