extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var adjective = []
var adverb = []
var conjunction = []
var _name = []
var noun = []
var pause = []
var preposition = []
var pronoun = []
var verb = []

var templates = {
"simple":["noun","preposition","adjective","noun","verb"]
}
var counter = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

	for key in templates.simple:
		print(key)
	
	adjective = FileGrabber.get_files("res://assets/adjectives/")
	adverb = FileGrabber.get_files("res://assets/adverbs/")
	conjunction = FileGrabber.get_files("res://assets/conjunction/")
	_name = FileGrabber.get_files("res://assets/names/")
	noun = FileGrabber.get_files("res://assets/nouns/")
	pause = FileGrabber.get_files("res://assets/pauses/")
	preposition = FileGrabber.get_files("res://assets/preposition/")
	pronoun = FileGrabber.get_files("res://assets/pronoun/")
	verb  = FileGrabber.get_files("res://assets/verb/")
	print(adjective)
	change_word()
	print($AudioStreamPlayer3D.stream)
	$Pause.start()

func change_word():
	print(counter,"––––" ,templates.simple.size())
	#var to_stream = templates.simple[]
	if not templates.simple.size() == counter:
		var to_stream
		var to_subs
		var rnd
		if templates.simple[counter] == "noun":
			rnd = randi() % noun.size()
			to_stream = noun[rnd].path
			to_subs = noun[rnd].subs
		elif templates.simple[counter] == "preposition":
			rnd = randi() % preposition.size()
			to_stream = preposition[rnd].path
			to_subs = preposition[rnd].subs
		elif templates.simple[counter] == "adjective":
			rnd = randi() % adjective.size()
			to_stream = adjective[rnd].path
			to_subs = adjective[rnd].subs
		elif templates.simple[counter] == "verb":
			rnd = randi() % verb.size()
			to_stream = verb[rnd].path
			to_subs = verb[rnd].subs
		$AudioStreamPlayer3D.stream = load(to_stream)
		$Subs.text = $Subs.text + " " + to_subs
		#counter += 1
	else:
		print("reached")
		counter = 0
		$Subs.text = ""
		change_word()
	

func play_audio():
	$AudioStreamPlayer3D.play()

func _on_AudioStreamPlayer3D_finished():
	print("finished")
	$AudioStreamPlayer3D.stop()
	$Pause.start()
	change_word()
	pass # Replace with function body.


func _on_Pause_timeout():
	counter += 1
	play_audio()

	pass # Replace with function body.
