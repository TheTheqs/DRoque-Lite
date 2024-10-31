extends Node2D

class_name QuickInfo
#elementos de cena
@export var closeButton: Button
@export var icon: Sprite2D
@export var content: RichTextLabel
@export var title: Label
#variável de controle fechar/abrir
var infoCard: InfoCard

func _ready() -> void:
	self.visible = false

#funções de exibição e encerramento
func popWindow(nicon: CompressedTexture2D, ntitle: String, ncontent: String, ninfoCard: InfoCard) -> void:
	icon.texture = nicon
	content.text = "[center]" + ncontent + "[/center]"
	infoCard = ninfoCard
	title.text = ntitle
	self.visible = true

func closeWindow() -> void:
	self.visible = false
	infoCard.closeWindow()
