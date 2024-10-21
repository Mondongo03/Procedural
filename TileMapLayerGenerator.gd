extends Node2D

@export var numRoomsMax:int = 8
@export var numRooms:int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in numRoomsMax:
		add_child(generateRoom())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func generateRoom():
	var room = Node2D.new()
	room.name = ("room" + str(numRooms))
	room.add_to_group("room" + str(numRooms))
	var floor = TileMap.new()
	floor.name = "floor"
	floor.tile_set = preload("res://Assets/Solaria.tres")

	var wall = TileMap.new()
	wall.name = "floor"
	wall.tile_set = preload("res://Assets/Solaria.tres")
	# Ajustar la posición (opcional)
	floor.position = Vector2(0,0)
	wall.position = Vector2(0,0)
	
	var xMax:int = randi_range(60,120)
	var yMax:int = randi_range(30,80)
	var doors:int = randi_range(1,3)
	var x:int = 0
	var y:int = 0
	# Asegurarse de que el TileSet esté cargado
	if floor.tile_set:
		# Setear suelo
		for i in range(yMax):
			for j in range(xMax):
				floor.set_cell(0, Vector2(x,y),0, Vector2(14,7))
				x+=1
			y+=1
			x=0
		
		#Setear paredes arriba y abajo
		for i in range(xMax):
			wall.set_cell(0, Vector2(i,0),0, Vector2(26,5))
			wall.set_cell(0, Vector2(i,yMax-1),0, Vector2(26,7))
		#Setear paredes izquierda y derecha
		for i in yMax:
			wall.set_cell(0,Vector2(0,i),0, Vector2(25,6))
			wall.set_cell(0,Vector2(xMax-1,i),0, Vector2(27,6))
		#Setear esquinas
		wall.set_cell(0,Vector2(0,0),0, Vector2(25,5))
		wall.set_cell(0,Vector2(xMax-1,0),0, Vector2(27,5))
		wall.set_cell(0,Vector2(0,yMax-1),0, Vector2(25,7))
		wall.set_cell(0,Vector2(xMax-1,yMax-1),0, Vector2(27,7))
	else:
		print("TileSet no cargado correctamente")
	
	room.add_child(floor) #Capa0
	room.add_child(wall) #Capa1
	room.position = Vector2(numRooms*2000, 0)
	numRooms+=1
	print("Nombre: "+room.name)
	print("Grupos: "+str(room.get_groups()))
	print("Grupos: "+str(room.get_groups()))
	print("Coords: "+str(room.position))
	print()
	return room
