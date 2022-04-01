extends KinematicBody2D

var vel=Vector2(0,0)
const x_vel=500
const jump_vel=-900
const grav=30
var c_jump=0

onready var anim_tree=$AnimationTree
onready var playback = anim_tree.get("parameters/playback")


#activar tree
func _ready():
	anim_tree.active = true
	
func _physics_process(_delta):
	
	#movimientos horizontales
	var oriented=Input.get_axis("ui_left","ui_right")
	vel.x=lerp(vel.x,x_vel*oriented,0.3)
	vel=move_and_slide(vel,Vector2(0,-1))
	vel.y+=grav	
	# saltos
	if is_on_floor():
		c_jump=0
		if Input.is_action_just_pressed("ui_up") :
			vel.y=jump_vel
			c_jump+=1		
	else:
		if Input.is_action_just_pressed("ui_up")and c_jump<=1:
			vel.y=jump_vel
			c_jump+=1
		
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
		if Input.is_action_just_pressed("ui_up"):
			playback.travel('jump')	
	else:
		if Input.is_action_just_pressed("ui_up") and c_jump!=1:
			playback.travel('double_jump')
		if Input.is_action_just_pressed("ui_up") and c_jump==0:
			playback.travel('jump')
	
	print(playback.get_current_node())
		

		
			
				
	
	
	
	 
	
	
	
	
	
