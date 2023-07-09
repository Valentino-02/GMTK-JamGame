extends Control


func _on_start_game() -> void:
	GlobalScenes.RootScene.change_UI(ScenesPaths.MainGameUI)
	GlobalScenes.RootScene.change_main_scene(ScenesPaths.MainGame)
