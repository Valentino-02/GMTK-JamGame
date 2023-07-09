extends Node
class_name RootScene


@onready var UI_Holder = $UI_Holder


func _ready():
	GlobalScenes.RootScene = self
	GlobalScenes.UI_Holder = UI_Holder
	_start_game()


func change_UI(new_UI: PackedScene) -> void:
	if GlobalScenes.CurrentUI != null:
		GlobalScenes.CurrentUI.queue_free()
	var new_UI_scene = new_UI.instantiate()
	UI_Holder.add_child(new_UI_scene)
	GlobalScenes.CurrentUI = new_UI_scene

func change_main_scene(new_scene: PackedScene) -> void:
	if GlobalScenes.CurrentMainScene != null:
		GlobalScenes.CurrentMainScene.queue_free()
	var new_main_scene = new_scene.instantiate()
#	new_main_scene.reset_game.connect(_start_game)
	add_child(new_main_scene)
	GlobalScenes.CurrentMainScene = new_main_scene


func _start_game() -> void:
	GlobalScenes.retry_number += 1
	change_main_scene(ScenesPaths.IntroScreen)
