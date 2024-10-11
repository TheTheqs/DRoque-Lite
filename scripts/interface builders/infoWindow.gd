extends Node2D

class_name InfoWindow

@export var buttonPanel: ButtonPanel
@export var title: RichTextLabel
@export var description: RichTextLabel

func _ready() -> void:
	self.visible = false

func updateDisplay(ntitle: String, ncontent: String)-> void:
	title.text = "[center]" + ntitle + "[/center]"
	description.text = "[center]" + ncontent + "[/center]"

func showWindow(ntitle: String, ncontent: String) -> void:
	buttonPanel.descWindowOn = true
	buttonPanel.blockAllsButtons()
	updateDisplay(ntitle, ncontent)
	self.visible = true

func hideWindow() -> void:
	self.visible = false
	buttonPanel.unBlockAllButtons()
	buttonPanel.descWindowOn = false
