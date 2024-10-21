extends Node2D

@export var roomScene:PackedScene = preload("res://Escenas/Room.tscn")
@export var doorScene:PackedScene = preload("res://Escenas/Door.tscn")

@export var numRooms:int = 5

var rooms:Array[Node2D] = []
var roomLv:int = 1
var viewport:Vector2 = Vector2(1152, 648+24)
var minEnemies:int = 1*roomLv
var maxEnemies:int = 3*roomLv
var enemies:Array = ["e1", "e2", "e3"]
var boss:Array = ["boss1"]

func initialize(enemies:Array, boss:Array):
	self.enemies = enemies
	self.boss = boss

func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	generateRoom()
	generateRoomContent()

func generateRoom():
	rooms.append(createRoom(Vector2(0,0)))
	
	for i in range(numRooms-1):
		var dir:int
		var changeDir:int
		var n:int
		var newPosition:Vector2
		var posRepeated:bool = false
		
		while posRepeated:
			posRepeated = false
			dir = randi_range(0,1)*2-1
			n = randi_range(0, rooms.size()-1)
			newPosition = rooms[n].position + Vector2(dir, !dir)* changeDir * viewport
			for room in rooms:
				if newPosition == room.position:
					posRepeated = true
					break
				
		rooms.append(createRoom(newPosition))

func createRoom(position:Vector2) -> Node2D:
	var room = roomScene.instantiate()
	add_child(room)
	room.position = position
	return room
	
func generateRoomContent():
	for room in rooms:
		generateDoor(room)
	#generateEnemies(room) if room != room[numRooms-1]

func generateDoor(room:Node2D):
	for otherRoom in rooms:
		if room == otherRoom:
			continue
				
		var doorPosition = otherRoom.position - room.position
		if doorPosition == Vector2(viewport.x, 0):
			otherRoom.doors.append(addDoor(room, Vector2(viewport.x +96, viewport.y/2), Vector2.LEFT))
		elif doorPosition == Vector2(-viewport.x, 0):
			otherRoom.doors.append(addDoor(room, Vector2(viewport.x -96, viewport.y/2), Vector2.RIGHT))
		elif doorPosition == Vector2(viewport.y, 0):
			otherRoom.doors.append(addDoor(room, Vector2(viewport.x/2, viewport.y+96), Vector2.UP))
		elif doorPosition == Vector2(viewport.y, 0):
			otherRoom.doors.append(addDoor(room, Vector2(viewport.x/2, viewport.y-96), Vector2.DOWN))

func addDoor(room:Node2D, offset:Vector2, dir:Vector2) -> Area2D:
	var door = doorScene.instantiate()
	room.add_child(door)
	door.position += offset
	door.dir = dir
	return door

func _process(delta: float) -> void:
	pass
