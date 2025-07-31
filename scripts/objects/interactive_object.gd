# interactive_object.gd
extends Area3D
class_name InteractiveObject # Tambahkan baris ini!

@export var message = "You interacted with an object!"

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node3D):
	if body is CharacterBody3D and body.name == "Player":
		print("Press F to interact with: ", name)
		GlobalSignals.set_interactable_object(self)

func _on_body_exited(body: Node3D):
	if body is CharacterBody3D and body.name == "Player":
		print("Exited interaction area.")
		if GlobalSignals.get_interactable_object() == self:
			GlobalSignals.set_interactable_object(null)

func interact():
	print(message)
	queue_free()
	GlobalSignals.set_interactable_object(null)
