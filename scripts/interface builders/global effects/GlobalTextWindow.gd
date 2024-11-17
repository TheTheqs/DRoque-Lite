extends Node2D

class_name GlobalTextWindow
#elementos de Cena
@export var textTimer: Timer
@export var message: Label

func _ready() -> void:
	self.visible = false
	
#função de mensagem na tela!
func showMessage(nmessage: String) -> void:
	self.message.text = nmessage
	self.visible = true
	self.textTimer.start(3.0)

func timerTimeOut() -> void:
	self.visible = false
