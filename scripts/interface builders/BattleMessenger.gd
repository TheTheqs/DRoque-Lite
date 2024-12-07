extends Node2D


class_name BattleMessenger
#variáveis de controle
var speaking: bool = false
var messageQueue: Array[String] = []
@export var changeMessageTimer: Timer
@export var content: RichTextLabel
@export var anime: AnimationPlayer
@export var BTM: BattleManager

func showMessage(newMessage: String) -> void:
	if!(newMessage in messageQueue):
		if(not speaking):
			BTM.inAction("Battle Messenger")
			speaking = true
			messageQueue.append(newMessage)
			speak()
		else:
			messageQueue.append(newMessage)
 
func speak() -> void:
	if(messageQueue.size() > 0):
		changeText(messageQueue[0])

func onChangeMessageTimeout():
	if(messageQueue.size() > 0):
		speak()
	else:
		speaking = false
		BTM.outAction("Battle Messenger")

func changeText(newMsg: String) -> void:
	content.text = ""
	content.text = str("[center]" + newMsg + "[/center]")
	self.anime.play("blink")

func afterBlink(anim: String) -> void:
	if(anim == "blink"):
		messageQueue.remove_at(0)
		changeMessageTimer.start(1.0)
