extends Node2D


class_name BattleMessenger
#variáveis de controle
var speaking: bool = false
var messageQueue: Array[String] = []
@export var changeMessageTimer: Timer
@export var content: RichTextLabel
@export var BTM: BattleManager

func showMessage(newMessage: String) -> void:
	if!(newMessage in messageQueue):
		if(not speaking):
			BTM.inAction()
			speaking = true
			messageQueue.append(newMessage)
			speak()
		else:
			messageQueue.append(newMessage)
 
func speak() -> void:
	if(messageQueue.size() > 0):
		changeText(messageQueue[0])
		messageQueue.remove_at(0)
		changeMessageTimer.start(1.0)

func onChangeMessageTimeout():
	if(messageQueue.size() > 0):
		speak()
	else:
		speaking = false
		BTM.outAction("Battle Messenger")

func changeText(newMsg: String) -> void:
	content.text = ""
	content.text = str("[center]" + newMsg + "[/center]")
