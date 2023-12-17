extends Sprite2D

var cloudspeed : int =( 1 )

func _physics_process( _delta ) :
	offset.y -= cloudspeed
	if( offset.y < (0-512) ) : self.queue_free()
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	cloudspeed = randi_range( 1 , 3 )
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
