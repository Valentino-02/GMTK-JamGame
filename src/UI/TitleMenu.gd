extends Control


@onready var StartGameBtn = $StartGameBtn


func _ready():
	StartGameBtn.pressed.connect(_on_start_game)


func _on_start_game() -> void:
	GlobalScenes.RootScene.change_UI(ScenesPaths.MainGameUI)
	GlobalScenes.RootScene.change_main_scene(ScenesPaths.MainGame)
