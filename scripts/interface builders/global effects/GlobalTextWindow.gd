extends Node2D

class_name GlobalTextWindow
#elementos de Cena
@export var textTimer: Timer
@export var message: Label
@export var moveOnButton: Button
@export var globalEffect: GlobalVFX

func _ready() -> void:
	self.moveOnButton.visible = false
	self.visible = false
	
#função de mensagem na tela!
func showMessage(nmessage: String) -> void:
	self.message.text = nmessage
	self.visible = true
	self.textTimer.start(1.0)

func timerTimeOut() -> void:
	self.moveOnButton.visible = true

func buttonDown() -> void:
	self.visible = false
	self.globalEffect.afterMessage()
