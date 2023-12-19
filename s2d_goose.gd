extends Sprite2D

var goose_speed : int = 3

func _physics_process( _delta ) :
	offset.y -= goose_speed
	if( offset.y < (0-512) ) : self.queue_free()
	pass
	
func _ready():
	pass # Replace with function body.
	
func _process(delta):
	pass
