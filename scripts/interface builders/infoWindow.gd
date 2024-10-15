extends Node2D

class_name InfoWindow

@export var buttonPanel: ButtonPanel
@export var title: RichTextLabel
@export var description: RichTextLabel
@export var skillFrame: Sprite2D
@export var skillIcon: Sprite2D

func _ready() -> void:
	self.visible = false

func updateDisplay(ntitle: String, ncontent: String)-> void:
	title.text = "[center]" + ntitle + "[/center]"
	description.text = "[center]" + ncontent + "[/center]"

func showWindow(ntitle: String, ncontent: String) -> void:
	if(buttonPanel.currentButtonToShow.relatedSkill == null):
		skillFrame.visible = false
	else:
		skillFrame.visible = true
	buttonPanel.descWindowOn = true
	buttonPanel.blockAllsButtons()
	updateDisplay(ntitle, ncontent)
	self.visible = true

func hideWindow() -> void:
	self.visible = false
	buttonPanel.unBlockAllButtons()
	buttonPanel.descWindowOn = false

func showIcon(skill: Skill) -> void:
	if(skill != null):
		skillIcon.texture = skill.skillIcon
		skillIcon.visible = true
		skillFrame.visible = true
	else:
		skillFrame.visible = false
		skillIcon.visible = false
