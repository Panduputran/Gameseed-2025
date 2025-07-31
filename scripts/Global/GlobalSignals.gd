extends Node

# Variabel untuk menyimpan referensi ke objek InteractiveObject yang bisa diinteraksi saat ini
var _current_interactable_object: InteractiveObject = null

func set_interactable_object(obj: InteractiveObject):
	_current_interactable_object = obj

func get_interactable_object() -> InteractiveObject:
	return _current_interactable_object
