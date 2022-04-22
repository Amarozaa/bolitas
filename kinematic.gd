extends KinematicBody2D
enum State{ MOVING,POWER_1,POWER_2 }
var vel=Vector2(0,0)
const x_vel=500
const jump_vel=-900
const grav=30
var c_jump=0
var state=State.MOVING
onready var anim_tree=$AnimationTree
onready var playback = anim_tree.get("parameters/playback")
export var positive= true
onready var charge=get_parent().get_node("charge")
onready var joint = get_node("PinJoint2D")
onready var mono = get_parent().get_node("character")




#activar tree
func _ready():
	anim_tree.active = true

func _physics_process(delta):
	match state:
		State.MOVING:
			joint.set_node_b(mono.get_path())
			moving_physics_process(delta)
			
		State.POWER_1:
			power1_physics_process(delta)
		State.POWER_2:
			power2_physics_process(delta)
			
			
			
func moving_physics_process(delta):
	
	#movimientos horizontales
	var oriented=Input.get_axis("left","right")
	vel.x=lerp(vel.x,x_vel*oriented,0.3)
	vel=move_and_slide(vel,Vector2(0,-1),  false,   4,   0.785398, true)

	vel.y+=grav	
	# saltos
	if is_on_floor():
		c_jump=0
		if Input.is_action_just_pressed("up") :
			vel.y=jump_vel
			c_jump+=1		
	else:
		if Input.is_action_just_pressed("up")and c_jump<=1:
			vel.y=jump_vel
			c_jump+=1
			
			
	if Input.is_action_just_pressed("power_1"):
		state=State.POWER_1
		return
		
	if Input.is_action_just_pressed("power_2"):
		
		joint.set_node_b(charge.get_path())
		state=State.POWER_2
		return
		
		
	#Animation
	if is_on_floor():
		
		if oriented !=0:
			playback.travel("run")
			if oriented==1:
				get_node('sprite').set_flip_h( false )	
			if oriented==-1:
				get_node('sprite').set_flip_h( true )
		else:	
			playback.travel('Idle')	
		if Input.is_action_just_pressed("up"):
			playback.travel('jump')	
	else:
		if Input.is_action_just_pressed("up") and c_jump!=1:
			playback.travel('double_jump')
		if Input.is_action_just_pressed("up") and c_jump==0:
			playback.travel('jump')
	
	
func power1_physics_process(_delta):
	playback.travel("ani_power_1")
	var direction=global_position.direction_to(charge.global_position)
	var distance=global_position.distance_to(charge.global_position)
	charge.power1(direction,distance)
	vel=move_and_slide(vel,Vector2(0,-1),  false,   4,   0.785398, true)
	vel.y+=grav	
	vel.x=0
	
	
	if Input.is_action_just_released("power_1"):
		state=State.MOVING
		return
	
	
	
func power2_physics_process(_delta):
	playback.travel("ani_power_1")
	var direction=global_position.direction_to(charge.global_position)
	var r_direction=Vector2(direction[1],-direction[0])
	var distance=global_position.distance_to(charge.global_position)
	charge.power2(r_direction,distance,direction)
	
	
	vel=move_and_slide(vel,Vector2(0,-1),  false,   4,   0.785398, true)
	vel.y+=grav	
	vel.x=0
	
	
	
	if Input.is_action_just_released("power_2"):
		state=State.MOVING
		return

	
	
		

		
			
				
	
	
	
	 
	
	
	
	
	
