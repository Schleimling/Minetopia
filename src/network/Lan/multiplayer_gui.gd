extends Control

func _on_connect_button_button_down() -> void:
	Server.join_server()
