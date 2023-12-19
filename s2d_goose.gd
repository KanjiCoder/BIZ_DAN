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


## ARE YOU FUCKING KIDDING ME ?
## It has to be "a_2d" instead of "a2d" ?
##  func _on_a_2d_goose_body_entered(body):
##	print( "[WHAT_THE_FUCKING_HELL_HOW_DO_I_WIRE_THIS_UP]" )
##	pass # Replace with function body.
	
func _on_a2d_goose_body_entered(body):
	print( "[_NEXT_TIME_GOOSE_COLLISION_CODE_HERE_]" )
	pass # Replace with function body.
