extends Area2D

var tp = {}
var dir:Vector2
var locked:bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_door_area_entered(area: Area2D) -> void:
	if area.is_in_group("player") and not locked:
		area.get_parent().active = false
		await get_tree().create_timer(0.4).timeout
		area.get_parent().position += (dir* 288)
		await get_tree().create_timer(0.6).timeout
		area.get_parent().active = true


func _on_door_area_exited(area: Area2D) -> void:
	pass # Replace with function body.
