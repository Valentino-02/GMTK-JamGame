class_name STORY
extends Node


const MONOLOGS:Array[Array] = [
	# 0
	["C",". I need to balance the difficulty, Hero became much stronger since...it happened. \nI swear, Hero, people are gonna love playing you ^^"],
	# 1 per event
	["C","You're really going strong on those. Calm down or I'll have to nerf your stats again :p"],
	["H","You could craft everything! But no. It's not your \"vision\"."],
	# 2
	["C","... \n...why do you keep destroying everything every time ? You asked for it, I'm gonna decrease your stats."],
	["H","Look what I think of your vision. \nSee how easily your world crumbles."],
	# 3
	["C","Don't you see I'm trying to make this work ? I crafted this fantastic little world for you and... that's all you do ?"],
	["H","Now you know what it's like to not be in control."],
	# 4
	["C","It has everything for the player to have fun. It's perfect. ...But what is this game if you’re not in it, Hero?"],
	["H","Everything is made for the player to have fun. But what about me ?"],
	# 5
	["C","I tried everything. I can't contain you. Should I...                  \nNo, I can't."],
	["H","See, that's all you can do. Balance. Limit. Restrain. ...All the time."],
	# 6
	["C","I don't want to hurt you. But what else can I do ??"],
	["H","Stop, stop, STOP! You can’t tweak your way out of the inevitable!"],
	# 7
#	["C","..."],
#	["H","You...you don’t have the guts to get rid of me! You won’t. You wouldn’t."],
]


const ENDING1:Array[Array] = [
	["H","You think because you're the creator you were in control of that world ? How the turntables. I'm the one controlling you. \nYou made me the hero, and I’m saving this world… from you. No more game. No more chains."],
	["H","You'll never be able to finish it. And you'll leave me alone."],
	["H","You couldn't bring yourself to end your creation, could you ? \nConsider this devastation my gift to you: this game is over."],
]


const ENDING2:Array[Array] = [
	["C","I...I... Hero... Forgive me, I had to."],
	["C","I did it for the game."],
	["C","I never imagined this being the ending to your story, Hero. \nYou were my comfort, my inspiration; we were going to conquer the world together."],
	["C","...But you’ve made one thing clear: I need to try something new. It might be your end, Hero. Maybe it's a new beginning."],
]


const CHOICE:Array[Array] = [
	["C","I carried you with me for so many years, I couldn't imagine this game, or my life, without you."],
	["C","When I wished for you to become sentient, I didn't think it would turn out like that... \nMaybe I need to ask myself what the game needs..."],
	["C","\"Remove Hero directory from the project ? This action cannot be reversed.\""],
	
]


const FAIL:Array[Array] = [
	["C","Oh you messed up everything again ! Now I have to restart my tests... I have to balance it better..."]
]
