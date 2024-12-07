extends Node2D

class_name InfoWindow

@export var buttonPanel: ButtonPanel
@export var title: Label
@export var description: RichTextLabel
@export var skillFrame: Sprite2D
@export var skillIcon: Sprite2D
@export var replaceWindow: RearrangementWindow
#controle sobre replace
var onReplace: bool = false
func _ready() -> void:
	self.visible = false

func updateDisplay(ntitle: String, ncontent: String)-> void:
	title.text = ntitle
	description.text = "[center]" + ncontent + "[/center]"

func showWindow(ntitle: String, ncontent: String) -> void:
	self.onReplace = false
	if(buttonPanel.currentButtonToShow.relatedSkill == null):
		skillFrame.visible = false
	else:
		skillFrame.visible = true
	buttonPanel.descWindowOn = true
	buttonPanel.blockAllButtons()
	updateDisplay(ntitle, ncontent)
	self.visible = true

func hideWindow() -> void:
	self.visible = false
	if(self.onReplace):
		self.replaceWindow.unBlockAllButtons()
	else:
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

func forcedClose() -> void:
	if(self.visible):
		self.hideWindow()

func showWindow2(icon: CompressedTexture2D, ntitle: String, ncontent: String) -> void:
	self.onReplace = true
	self.replaceWindow.blockAllButtons()
	self.skillIcon.texture = icon
	updateDisplay(ntitle, ncontent)
	self.visible = true
