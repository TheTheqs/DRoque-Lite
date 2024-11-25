extends Node2D

class_name ConfirmationWindow
#elementos de cena
@export var message: Label
@export var yesLabel: Label
@export var noLabel: Label
#elemento requerente
var source
#função de início
func _ready() ->void:
	self.visible = false
#abertura da janela
func requireConfirmation(newMessage: String, nSource) -> void:
	self.source = nSource
	self.message.text = newMessage
	self.yesLabel.text = tr(StringName("Yes"))
	self.noLabel.text = tr(StringName("No"))
	self.visible = true
#confirmação positiva
func confirmYes() -> void:
	self.visible = false
	source.confirmation(true)
#confirmação negativa
func confirmNo() -> void:
	self.visible = false
	source.confirmation(false)
