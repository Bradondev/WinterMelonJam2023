extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var CurrentArea :String
signal CallMeterManager(CurrentArea)
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.


	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left_Player", "Right_Player")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_hit_box_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	CurrentArea = area.name
	
	
func _on_hit_box_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	CurrentArea = "None"



func _on_timer_timeout():
	emit_signal("CallMeterManager", CurrentArea)

