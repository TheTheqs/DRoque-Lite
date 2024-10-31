extends Node2D

class_name DigimonDisplay
#Elementos de cena
var currentDigimon: Digimon
@export var buttonPanel: ButtonPanel
@export var iconName: IconName
@export var attributes: AttributesDisplay
@export var quickWindow: QuickInfo
@export var passives: PassivesDisplay
@export var closeButton: Button
#controle de botões
var allButtons: Array[Button] = []

func _ready() -> void:
	allButtons.append(closeButton)
	self.visible = false

#principal função, que atualiza as interfaces
func showDisplay(digimon: Digimon) -> void:
#Nome, ícone, tipo e elemento
	iconName.showContent(digimon)
#atributos
	attributes.showContent(digimon)
#passivas
	var passList: Array = digimon.digimonPassiveSkills.values()
	passives.resetPassList(passList)
#Função que exibe a janela
func toggleDisplay() -> void:
	if(currentDigimon != null):
		if(self.visible):
			buttonPanel.unBlockAllButtons()
		else:
			buttonPanel.blockAllButtons()
			showDisplay(currentDigimon)
		self.visible = not self.visible
	else:
		print("Erro: Nenhum digimon selecionado!")
#funções para controle de botões
func blockAllButtons() -> void:
	if(allButtons.size() > 0):
		for butt : Button in allButtons:
			butt.disabled = true
func unblockAllButtons() -> void:
	if(allButtons.size() > 0):
		for butt : Button in allButtons:
			butt.disabled = false
