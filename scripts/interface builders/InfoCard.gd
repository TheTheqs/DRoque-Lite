extends Control

class_name InfoCard
#elementos de cena
@export var icon: Sprite2D
@export var title: Label
@export var button: Button
@export var frame: Sprite2D
#elementos de informação
var infoCardId: int
var iconTexture: CompressedTexture2D
var titleText: String
var cardDescription: String
#fonte do card. Pode ser de diversas classes por isso não será tipado.
var cardFont
var quickWindow: QuickInfo

#função de controle de botões na tela.
func popWindow() -> void:
	if(cardFont.has_method("blockAllButtons")):
		cardFont.blockAllButtons()
		quickWindow.popWindow(iconTexture, titleText, cardDescription, self)
	else:
		print("ERRO: Invalid card font")

func closeWindow() -> void:
	if(cardFont.has_method("unblockAllButtons")):
		cardFont.unblockAllButtons()
	else:
		print("ERRO: Invalid card font")

#função "construtora"
func buildCard(nicon: CompressedTexture2D, ntitle: String, ncontent: String, ncardFont, needFrame: bool) -> void:
	iconTexture = nicon
	icon.texture = nicon
	titleText = ntitle
	title.text = ntitle
	cardDescription = ncontent
	cardFont = ncardFont
	quickWindow = ncardFont.quickWindow
	if(needFrame):
		frame.visible = true
	else:
		frame.visible = false
