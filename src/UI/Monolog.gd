extends Control

var text_index:int = 0

@export var text_speed:float = 0.1
@export var end_cooldown:float = 2

func _ready():
	$TextureRect.modulate.a = 0

func display_next_monolog(text_array):
	for t in text_array:
		await GlobalScenes.CurrentMainScene.nextMonolog
		$%AnimationPlayer.play_backwards("Fade")
		$%Label.text = text_array[text_index][1]
		display_chara(text_array[text_index][0])
		await $%AnimationPlayer.animation_finished
		
		for i in $%Label.get_total_character_count():
			$%Label.visible_characters += 1
			await get_tree().create_timer(text_speed)
		
		await get_tree().create_timer(end_cooldown)
		reset_textbox()
		text_index += 1

func reset_textbox():
	$%Label.visible_characters = 0
	$%Label.text = ""
	$%AnimationPlayer.play("Fade")

func read_monologs():
	display_next_monolog(STORY.MONOLOGS)

func read_ending1():
	display_next_monolog(STORY.ENDING1)

func read_ending2():
	display_next_monolog(STORY.ENDING2)

func display_chara(type:String):
	match type:
		"H": $%Chara.texture = null # TODO
		"C": $%Chara.texture = null
