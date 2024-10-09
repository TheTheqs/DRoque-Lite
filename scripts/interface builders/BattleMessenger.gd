extends RichTextLabel


class_name BattleMessenger
#variáveis de controle
var speaking: bool = false
var messageQueue: Array[String]
@export var changeMessageTimer: Timer

func showMessage(newMessage: String) -> void:
	if(not speaking):
		BTM.inAction()
		speaking = true
		messageQueue.append(newMessage)
		speak()
	else:
		messageQueue.append(newMessage)

func speak() -> void:
	if(messageQueue.size() > 0):
		self.text = "[center]"+ messageQueue[0] +"[/center]"
		messageQueue.remove_at(0)
		changeMessageTimer.start(0.4)

func onChangeMessageTimeout():
	if(messageQueue.size() > 0):
		speak()
	else:
		speaking = false
		BTM.outAction()
