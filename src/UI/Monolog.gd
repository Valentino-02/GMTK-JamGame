extends Control

var text_index:int = 0
var current_story:Array[Array]

@export var text_speed:float = 0.1
@export var end_cooldown:float = 2

func _ready():
	$TextureRect.modulate.a = 0

func display_next_monolog(text_array):
	current_story = text_array
	text_index = 0
	
	for t in text_array:
		# wait for next text
		await GlobalScenes.CurrentMainScene.nextMonolog
		$%Label.text = ""
		
		if text_index >= text_array.size() or current_story != text_array: return
		# textbox appears
		$%AnimationPlayer.play_backwards("Fade")
		# display betatest number
		if text_array == STORY.MONOLOGS and text_index == 0:
			$%Label.text = "Betatest n°"+str(GlobalScenes.retry_number+107)+text_array[text_index][1]
		# setup textbox
		else: $%Label.text = text_array[text_index][1]
		display_chara(text_array[text_index][0])
		await $%AnimationPlayer.animation_finished
		# display characters
		for i in $%Label.get_total_character_count():
			$%Label.visible_characters += 1
			if $%Label.text[i] == " ": $AudioStreamPlayer.play()
			await get_tree().create_timer(text_speed).timeout
		$%Label.visible_characters = -1
		#wait for reading cooldown
		await get_tree().create_timer(end_cooldown).timeout
		# textbox disappears
		reset_textbox()
		text_index += 1

func reset_textbox():
	$%Label.visible_characters = 0
	$%Label.text = ""
	$%AnimationPlayer.play("Fade")

func read_monologs():
	display_next_monolog(STORY.MONOLOGS)

func read_choice_ending():
	display_next_monolog(STORY.CHOICE)

func read_ending1():
	display_next_monolog(STORY.ENDING1)

func read_ending2():
	display_next_monolog(STORY.ENDING2)

func read_fail_ending():
	display_next_monolog(STORY.FAIL)

func display_chara(type:String):
	match type:
		"H":
			$AudioStreamPlayer.pitch_scale = 1.2
			$%Chara.texture = load("res://assets/Characters/Portrait.png")
		"C":
			$AudioStreamPlayer.pitch_scale = 0.8
			$%Chara.texture = null
		"H2":
			$AudioStreamPlayer.pitch_scale = 1.2
			$%Chara.texture = load("res://assets/Characters/Portrai2t.png")
