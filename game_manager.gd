extends Node

@onready var label: Label = %Label
@onready var label_menang: Label = %Winner
@onready var panel_menang: Panel = %WinPanel

var points: int = 0


func add_point() -> void:
	points += 1
	label.text = "Poin : " + str(points)


func tampilkan_kemenangan() -> void:
	panel_menang.show()
	label_menang.text = "Selamat! Total point kamu: " + str(points)


func _on_end_point_body_entered(body: Node2D) -> void:
	if body.name == "player":
		tampilkan_kemenangan()
