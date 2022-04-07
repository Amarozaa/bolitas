extends RigidBody2D
var contador = 0

func power1(direction,distance):
	print(direction)
	print("poder1")
	apply_central_impulse(direction*500/distance)
	pass

func power2(r_direction,distance,direction):
	contador = contador + 1
	print('el contador es '+ str(contador))
	print(distance)
	#print('hola soy d '+ "d",direction)
	#print('hola soy r '+"r",r_direction)
	apply_central_impulse(6*r_direction)
	
	pass
# Called when the node enters the scene tree for the first time.

func _ready():
	
	pass 


