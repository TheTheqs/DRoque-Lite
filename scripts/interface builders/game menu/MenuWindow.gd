extends Node
#classe abstratada para colocar em abstração alguns atributos e funções repetitivas
class_name MenuWindow
var menuName: String
var pastWindow: int
#conjunto de botões em tela
@export var allButtons: Array[Button]
#Game menu da tela (Classe que gerencia a exibição)
@export var gameMenu: GameMenu

#dicionário de ícones e texto
var buttonEdit: Dictionary = {
	
}
#função de abertura e edição dos botões
func openSelf() -> void:
	self.gameMenu.currentWindow.visible = false
	self.gameMenu.title.text = tr(StringName(self.menuName))
	for key: int in self.buttonEdit:
		self.allButtons[key].icon = load(self.buttonEdit[key][1])
		self.allButtons[key].text = tr(StringName(self.buttonEdit[key][0]))
	self.gameMenu.currentWindow = self
	self.afterBuild()
	self.visible = true
#função abstrata, usada para a adaptação de cada window
func afterBuild() -> void:
	pass
