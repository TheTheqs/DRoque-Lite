extends Node2D

class_name Alert
#elementos de cena
@export var message: Label
@export var closeButton: Button
var source
#função de início
func _ready() -> void:
	self.visible = false

#função principal
func showAlert(nMessage: String, nSource) -> void:
	self.message.text = nMessage
	self.source = nSource
	self.visible = true

func closeAlert() -> void:
	self.visible = false
	self.source.closeAlert()
