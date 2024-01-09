extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process( _delta):
	pass


func _on_a_2d_hay_body_entered(body):

	## TAG[ $_HANDLE_HITTING_THE_HAY_$ ] ##
	## TAG[ $_HANDLE_HITTING_HAY_$     ] ##

	print( "[_HITTING_THE_HAY_]" )
	pass # Replace with function body.






## $_HANDLE_HITTING_THE_HAY_$ ##################################
## $_HANDLE_HITTING_HAY_$     ##################################
##                                                            ##
##  If we hit the hay , we should proceed to the next level.  ##
##  If we miss the hay , we need to die and restart from      ##
##  the beginning .                                           ##
##                                                            ##
##################################   $_HANDLE_HITTING_HAY_$   ## 
################################## $_HANDLE_HITTING_THE_HAY_$ ## 
