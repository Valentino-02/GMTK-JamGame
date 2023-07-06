extends Node2D


@onready var animationPlayer = $AnimationPlayer

func _ready():
	animationPlayer.play("Intro")


func _on_intro_finished() -> void:
	GlobalScenes.RootScene.change_UI(ScenesPaths.TitleMenu)
	queue_free()
