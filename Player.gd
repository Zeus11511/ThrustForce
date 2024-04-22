extends RigidBody3D

## How much vertical force to apply when moving.
@export_range(750.0, 3000) var thrust: float = 1000.0
@export var torque_thrust: float = 100.0
var is_transitioning: bool = false
@onready var explosion_audio: AudioStreamPlayer = $ExplosionSound
@onready var success_audio: AudioStreamPlayer = $SuccessSound
@onready var thrust_audio: AudioStreamPlayer3D = $ThrustAudio
@onready var booster_particles: GPUParticles3D = $BoosterParticles
@onready var Right_booster_particles: GPUParticles3D = $RightBoosterParticles
@onready var Left_booster_particles: GPUParticles3D = $LeftBoosterParticles
@onready var explosion_particles: GPUParticles3D = $ExplosionParticles
@onready var success_particles: GPUParticles3D = $SuccessParticles
 
signal level_complete;
signal level_failed;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
		apply_central_force(basis.y * delta * thrust)
		booster_particles.emitting = true
		if thrust_audio.playing == false:
			thrust_audio.play()
	else:
			booster_particles.emitting = false
			thrust_audio.stop()
			
	if Input.is_action_pressed("RotateLeft"):
		apply_torque(Vector3(0.0, 0.0, torque_thrust * delta))
		Right_booster_particles.emitting = true
	else:
		Right_booster_particles.emitting = false
	
	if Input.is_action_pressed("RotateRight"):
		apply_torque(Vector3(0.0, 0.0, -torque_thrust* delta))
		Left_booster_particles.emitting = true
	else:
		Left_booster_particles.emitting = false
		

func _on_body_entered(body: Node) -> void:
	if is_transitioning == false:
		if "Goal" in body.get_groups():
			complete_level()
		elif not "Launch" in body.get_groups():
			crash_sequence()
		
func crash_sequence() -> void:
	explosion_particles.emitting = true
	explosion_audio.play()
	set_process(false)

	is_transitioning = true
	var tween = create_tween()
	tween.tween_interval(1.0)
	tween.tween_callback(failed)

	
func complete_level() -> void:
	print("Level Complete!")
	success_particles.emitting = true
	success_audio.play()
	set_process(false)
	is_transitioning = true
	var tween = create_tween()
	tween.tween_interval(1.0)
	tween.tween_callback(done)

func done() -> void:
	level_complete.emit();

func failed() -> void:
	level_failed.emit();
	set_process(true);


