extends Node

@onready var label: Label = %Label
@onready var label_menang: Label = %Winner
@onready var panel_menang: Panel = $Panel

var points = 0
func add_point():
	points += 1
	print(points)
	label.text = "Poin : " +str(points)
	
func tampilkan_kemenangan():
	panel_menang.show()
	label_menang.text = "Selamat! Total point kamu: " + str(points)

func _on_end_point_body_entered(body: Node2D) -> void:
	if body.name == "player": # Pastikan yang menyentuh adalah pemain
		tampilkan_kemenangan()
		# Tambahkan kode get_tree().paused = true di sini jika ingin menghentikan permainan
