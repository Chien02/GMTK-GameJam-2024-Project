extends CharacterBody2D

class_name Ant

@export_category("Dependencies")
@export var anim_player: AnimationPlayer

@export_category("Properties")
@export var speed : float = 30
@export var accel : float = 10

var direction : Vector2

func _process(_delta):
	pass

func _physics_process(_delta):
	direction = Input.get_vector("left", "right", "up", "down")
	
	velocity.x = move_toward(velocity.x, speed * direction.x, accel)
	velocity.y = move_toward(velocity.y, speed * direction.y, accel)
	
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("ScalableObject"):
			var collider = collision.get_collider()
			if collider.linear_velocity:
				collider.constant_force = velocity

