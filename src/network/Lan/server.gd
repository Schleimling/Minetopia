extends Node

var IP_ADRESS: String = "127.0.0.1"
var PORT: int = 45654



func join_server() -> void:
	var client: Object = ENetMultiplayerPeer.new()
	var err: Error = client.create_client(IP_ADRESS, PORT)
	multiplayer.multiplayer_peer = client
	
	if err != OK:
		print(err)
		return
	
	print("connected")
	
func leave_server() -> void:
	multiplayer.multiplayer_peer = OfflineMultiplayerPeer.new()
