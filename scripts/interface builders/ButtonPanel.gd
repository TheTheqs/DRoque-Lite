extends Node

class_name ButtonPanel
#Elementos da Cena
@export var relatedPlayer: Player
@export var relatedDigimon: Digimon
@export var displayWindow: DigimonDisplay
@export var playerHUDD: HUDDisplay
@export var enemyHUDD: HUDDisplay 
#Botões
@export var allButtons: Array[ButtonDescription]
@export var skillButtons: Array[ButtonDescription]
@export var showDescTimer: Timer
@export var infoWindow: InfoWindow
@export var inventoryDisplay: InventoryDisplay
@export var BM: BattleMessenger
@export var BTM: BattleManager
var descWindowOn: bool = false
var currentButtonToShow: ButtonDescription
#setar os botões padrões.
func _ready() -> void:
	allButtons[0].buttonName = "PassingTurnButtonTittle"
	allButtons[0].buttonDescription = "PassingTurnButtonDescription"
	allButtons[1].buttonName = "MenuButtonTitle"
	allButtons[1].buttonDescription = "MenuButtonDescription"
	allButtons[2].buttonName = "InventoryButtonTittle"
	allButtons[2].buttonDescription = "InventoryButtonDescription"
	allButtons[3].buttonName = "CompanionButtonTittle"
	allButtons[3].buttonDescription = "CompanionButtonDescription"
	allButtons[9].buttonName = "PlayerDisplay"
	allButtons[10].buttonName = "EnemyDisplay"
#função que relaciona cada skill com um botão
func setButtons() -> void:
	for i in range(relatedDigimon.digimonSkills.size()):
		if(relatedDigimon.digimonSkills[i] != null):
			skillButtons[i].associateSkill(relatedDigimon.digimonSkills[i])
		else:
			skillButtons[i].visible = false

func updateButtons() -> void:
	for nbutton: ButtonDescription in skillButtons:
		nbutton.updateSkills()

func blockAllButtons() -> void:
	for cbutton in allButtons:
		cbutton.visible = false


func unBlockAllButtons() -> void:
	for cbutton in allButtons:
		cbutton.visible = true
	setButtons()
	updateButtons()
	toggleDisplay(false)

func _on_pass_turn_button_down():
	currentButtonToShow = allButtons[0]
	showDescTimer.start(0.5)

func _on_menu_button_down():
	currentButtonToShow = allButtons[1]
	showDescTimer.start(0.5)

func _on_inventory_button_down():
	currentButtonToShow = allButtons[2]
	showDescTimer.start(0.5)

func _on_companion_button_down():
	currentButtonToShow = allButtons[3]
	showDescTimer.start(0.5)

func _on_basic_atack_button_down():
	currentButtonToShow = skillButtons[0]
	showDescTimer.start(0.5)

func _on_signature_skill_button_down():
	currentButtonToShow = skillButtons[1]
	showDescTimer.start(0.5)

func _on_extra_skill_1_button_down():
	currentButtonToShow = skillButtons[2]
	showDescTimer.start(0.5)

func _on_extra_skill_2_button_down():
	currentButtonToShow = skillButtons[3]
	showDescTimer.start(0.5)

func _on_extra_skill_3_button_down():
	currentButtonToShow = skillButtons[4]
	showDescTimer.start(0.5)

func showInfoWindow():
	if(currentButtonToShow != null):
		var manaCD: String = ""
		if (currentButtonToShow in skillButtons):
			infoWindow.showIcon(currentButtonToShow.relatedSkill)
			if(currentButtonToShow.relatedSkill.manaCost > 0):
				manaCD += "\n" + "\n" + str(currentButtonToShow.relatedSkill.manaCost) + " [outline_size=6][outline_color=#64A5FF]MP[/outline_color][/outline_size]"
			if(currentButtonToShow.relatedSkill.cooldowm > 0):
				manaCD += "\n" + "\n" + str(currentButtonToShow.relatedSkill.cooldowm) + " CD"
		infoWindow.showWindow(tr(StringName(currentButtonToShow.buttonName)), tr(StringName(currentButtonToShow.buttonDescription)) + manaCD)

func activateButton() -> void:
	showDescTimer.stop()
	if(!descWindowOn and currentButtonToShow != null and relatedPlayer.canAct == true):
		if(currentButtonToShow in skillButtons):
			var selectedSkill: Skill = currentButtonToShow.relatedSkill
			if(selectedSkill.currentCooldown > 0):
				BM.showMessage(tr(StringName("NoCD")))
			elif(selectedSkill.manaCost > relatedDigimon.currentMana):
				BM.showMessage(tr(StringName("NoMana")))
			elif(!selectedSkill.usable):
				BM.showMessage(tr(StringName("CantUse")))
			else:
				relatedDigimon.chooseAction(selectedSkill)
				relatedPlayer.canAct = false
				BTM.choosing = false
				BTM.outAction("Button Panel")
		elif(currentButtonToShow == allButtons[0]):
			relatedPlayer.canAct = false
			BTM.choosing = false
			BTM.passingTurn()
	if(currentButtonToShow == allButtons[2] and !descWindowOn):
		inventoryDisplay.opening()
#funções de exibição da tela de informações de digimon
func showDisplay(digimon: Digimon) -> void:
	displayWindow.currentDigimon = digimon
	displayWindow.toggleDisplay()

func enemyDisplay() -> void:
	showDisplay(relatedDigimon.enemy)
	toggleDisplay(true)
func playerDisplay() -> void:
	showDisplay(relatedDigimon)
	toggleDisplay(true)

func toggleDisplay(hide: bool) -> void:
	if(hide):
		playerHUDD.modulate.a = 0.1
		enemyHUDD.modulate.a = 0.1
	else:
		playerHUDD.modulate.a = 1
		enemyHUDD.modulate.a = 1
	
