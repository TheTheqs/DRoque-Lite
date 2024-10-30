extends Node2D

class_name DigimonDisplay
#Elementos de cena
var currentDigimon: Digimon
@export var buttonPanel: ButtonPanel
@export var iconName: IconName

func _ready() -> void:
	self.visible = false

#principal função, que atualiza as interfaces
func showDisplay(digimon: Digimon) -> void:
#Nome, ícone, tipo e elemento
	iconName.showContent(digimon)
#Função que exibe a janela
func toggleDisplay() -> void:
	if(currentDigimon != null):
		if(self.visible):
			buttonPanel.unBlockAllButtons()
		else:
			buttonPanel.blockAllsButtons()
			showDisplay(currentDigimon)
		self.visible = not self.visible
	else:
		print("Erro: Nenhum digimon selecionado!")
