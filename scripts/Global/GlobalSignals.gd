extends Node

# Pastikan tidak ada baris 'class_name GlobalSignals' di sini
# karena ini adalah AutoLoad (Singleton)

var _current_interactable_object: InteractiveObject = null

func set_interactable_object(obj: InteractiveObject):
	_current_interactable_object = obj
	# Memperbaiki baris ini agar lebih eksplisit dalam konversi string
	# Menggunakan 'str(obj.name)' jika 'obj' tidak null, atau literal "null"
	print("GlobalSignals: Set interactable object to ", str(obj.name) if obj != null else "null")


func get_interactable_object() -> InteractiveObject:
	# Memperbaiki baris ini untuk mengatasi error kompatibilitas ternary
	# Pilihan 1 (Disarankan untuk debugging): Print objek itu sendiri
	# Godot akan mengkonversinya ke string secara otomatis (misal: "[Area3D:1234]") atau "null"
	print("GlobalSignals: Getting interactable object: ", _current_interactable_object)

	# Pilihan 2 (Jika Anda bersikeras ingin nama objek): Lebih eksplisit dengan str()
	# var object_name = "null"
	# if _current_interactable_object != null:
	#     object_name = _current_interactable_object.name
	# print("GlobalSignals: Getting interactable object: ", object_name)

	return _current_interactable_object
