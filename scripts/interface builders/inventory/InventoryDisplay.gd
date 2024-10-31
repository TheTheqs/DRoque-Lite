extends Node

class_name InventoryDisplay
#elementos da cena
@export var title: Label
@export var closeButton: Button
@export var buttonPanel: ButtonPanel

func _ready():
	self.visible = false
#funções de abertura e ecnerramento
func opening() -> void:
	buttonPanel.blockAllButtons()
	title.text = tr(StringName("Inventory"))
	self.visible = true

func closing() -> void:
	self.visible = false
	buttonPanel.unBlockAllButtons()
