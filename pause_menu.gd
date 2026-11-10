extends CanvasLayer

## Menu pause.
## Esc / P  -> buka atau tutup pause.
## Tombol "LANJUTKAN" -> lanjut main.
## Tombol "MAIN MENU" -> kembali ke halaman utama (menu.tscn).


func _ready() -> void:
	# Tetap jalan walaupun SceneTree sedang di-pause.
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = false
	get_tree().paused = false


func _unhandled_input(event: InputEvent) -> void:
	if not event.is_action_pressed("pause"):
		return

	if visible:
		resume()
	else:
		open()

	get_viewport().set_input_as_handled()


func open() -> void:
	if visible:
		return

	visible = true
	get_tree().paused = true
	$Root/Center/Panel/VBox/Resume.grab_focus()


func resume() -> void:
	visible = false
	get_tree().paused = false


func _on_resume_pressed() -> void:
	resume()


func _on_main_menu_pressed() -> void:
	visible = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://menu.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
