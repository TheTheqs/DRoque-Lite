extends Node2D
#classe "gerente" das janelas de opções
class_name GameMenu
#elementos de cena
@export var title: Label
@export var closeButton: Button
@export var backButton: Button
@export var canvas: CanvasLayer
@export var confimWindow: ConfirmationWindow
@export var fade: CanvasModulate
@export var buttonPanel: ButtonPanel
@export var BTM: BattleManager
#lista de janelas em cena
@export var allMenus: Array[MenuWindow]
#variável que indica a janela que está atualmente aberta
var currentWindow: MenuWindow
#função ready
func _ready() -> void:
	self.toggleVisible(false)
	self.currentWindow = self.allMenus[0]

#função de abertura do menu
func opening() -> void:
	self.buttonPanel.blockAllButtons()
	self.openMenu(0)
	self.fade.color = Color(0.15, 0.15, 0.15)
	self.toggleVisible(true)

#função que abre um novo menu
func openMenu(index: int) -> void:
	self.currentWindow.visible = false
	if(index != -1): #aqui, coloca-se -1 quando vc quer regarregar a página vigente.
		self.currentWindow = allMenus[index]
	self.backButton.visible = not (index == 0)
	self.currentWindow.openSelf()

func closing() -> void:
	self.toggleVisible(false)
	if(self.confimWindow.visible):
		self.confimWindow.confirmNo()
	self.fade.color = Color(1, 1, 1)
	self.buttonPanel.unBlockAllButtons()

func goingBack() -> void:
	openMenu(currentWindow.pastWindow)

func toggleVisible(isVisible: bool) -> void:
	self.canvas.visible = isVisible
	self.visible = isVisible
#função que força o fechamento do menu quando necessário
func forcedClose() -> void:
	if(self.visible):
		self.closing()
