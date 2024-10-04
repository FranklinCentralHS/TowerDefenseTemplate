class_name ExplodingMissile
extends Projectile

@export var hitbox_size: float = 150.0  # Radius of the large explosion hitbox

# Hitbox and collision setup
@onready var explosion_hitbox: Area2D = Area2D.new()
@onready var explosion_collision_shape: CollisionShape2D = CollisionShape2D.new()

func _ready() -> void:
    _initialize_explosion_hitbox()

func _initialize_explosion_hitbox() -> void:
    # Set up the explosion hitbox with a circular collision shape
    var circle_shape = CircleShape2D.new()
    circle_shape.radius = hitbox_size
    explosion_collision_shape.shape = circle_shape
    
    # Add the explosion collision shape to the hitbox
    explosion_hitbox.add_child(explosion_collision_shape)
    explosion_hitbox.hide()  # Hide the hitbox until it's needed
    add_child(explosion_hitbox)
    
    # Set collision layers and mask for explosion (layer 1, mask 97 -> layers 1, 6, and 7)
    explosion_hitbox.collision_layer = 1
    explosion_hitbox.collision_mask = 97  # Binary 1100001 -> layers 1, 6, and 7

    # Disable the explosion hitbox initially
    explosion_hitbox.set_deferred("monitoring", false)  # This ensures it's not detecting collisions

    # Connect the body_entered signal for the explosion hitbox
    explosion_hitbox.connect("body_entered", Callable(self, "_on_explosion_hitbox_body_entered"))

# This function is called when the missile collides with an enemy, turret, or objective
func _on_projectile_body_entered(body: Node2D) -> void:
    # Handle collision with different objects (e.g., enemies, turrets, objectives)
    if body is Enemy:
        (body.state_machine as EnemyFSM).is_hit(damage)
    elif body is Turret:
        body.health -= damage
    elif body is Objective:
        body.health -= damage

    # After collision, trigger the explosion
    _explode()

# Handle the explosion after the missile hits something
func _explode() -> void:
    # Stop the missile and disable its physics/collision
    set_physics_process(false)
    $CollisionShape2D.set_deferred("disabled", true)
    sprite.hide()

    # Show and position the explosion hitbox
    explosion_hitbox.global_position = global_position
    explosion_hitbox.show()

    # Enable the explosion hitbox for collision detection
    explosion_hitbox.set_deferred("monitoring", true)

    # Play hit VFX animation
    hit_vfx.show()
    hit_vfx.play("hit")

    # The explosion hitbox will now damage anything inside of it
    # Wait for 0.1 seconds to simulate explosion duration and then free the hitbox
    await get_tree().create_timer(0.1).timeout
    explosion_hitbox.queue_free()

# Handle what happens when a body enters the explosion hitbox
func _on_explosion_hitbox_body_entered(body: Node2D) -> void:
    # Check if the body is an enemy and apply damage
    if body is Enemy:
        (body.state_machine as EnemyFSM).is_hit(damage)  # Assuming your Enemy class has an is_hit function
    elif body is Turret:
        body.health -= damage
    elif body is Objective:
        body.health -= damage

    # Additional object types can be handled here
