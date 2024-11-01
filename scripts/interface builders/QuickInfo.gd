extends Node2D

class_name QuickInfo
#elementos de cena
@export var closeButton: Button
@export var icon: Sprite2D
@export var content: RichTextLabel
@export var title: Label
#variável de controle fechar/abrir
var cardFont

func _ready() -> void:
	self.visible = false

#funções de exibição e encerramento
func popWindow(nicon: CompressedTexture2D, ntitle: String, ncontent: String, ninfoCard) -> void:
	icon.texture = nicon
	content.text = "[center]" + ncontent + "[/center]"
	cardFont = ninfoCard
	title.text = ntitle
	self.visible = true

func closeWindow() -> void:
	if(cardFont.has_method("unblockAllButtons")):
		cardFont.unblockAllButtons()
		self.visible = false
	else:
		print("ERRO: Invalid card font")
