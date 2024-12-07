extends Node2D

class_name DigimonDisplay
#Elementos de cena
var currentDigimon: Digimon
@export var buttonPanel: ButtonPanel
@export var healthMana: HealthMana
@export var iconName: IconName
@export var attributes: AttributesDisplay
@export var armory: ArmoryDisplay
@export var quickWindow: QuickInfo
@export var passives: PassivesDisplay
@export var status: StatusEffectDisplay
@export var closeButton: Button
@export var karma: KarmaDisplay
#controle de botões
var allButtons: Array[Button] = []

func _ready() -> void:
	self.visible = false
	allButtons.append(closeButton)
	for nbutton: EquipDisplayButton in armory.equipmentButtons:
		allButtons.append(nbutton.button)


#principal função, que atualiza as interfaces
func showDisplay(digimon: Digimon) -> void:
#Exibir Vida e Mana
	healthMana.showDisplay(digimon)
#Nome, ícone, tipo e elemento
	iconName.showContent(digimon)
#atributos
	attributes.showContent(digimon)
#armory/equipaments
	armory.buildIcons(digimon.armory)
#passives
	var passList: Array = digimon.digimonPassiveSkills.values()
	passives.resetPassList(passList)
#status
	var statsList: Array = digimon.statusEffect.values()
	status.resetStatusList(statsList)
#karma
	karma.editText(digimon.tamer.tamerKarma)
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

func showEquipWindow(equip: Equipment) -> void:
	blockAllButtons()
	quickWindow.popEquipWindow(equip, self)

func forcedClose() -> void:
	if(self.visible):
		self.toggleDisplay()

func resetEquips() -> void:
	self.armory.resetEquipButtons()
