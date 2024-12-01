extends Node2D

class_name RearrangementWindow
#elementos de cena
@export var currentMessage: Label
@export var evolutionSkills: EvolutionSkills
@export var replaceSkills: ReplaceSkills
@export var infoWindow: InfoWindow
@export var relatedDigimon: Digimon
@export var closeButton: Button
@export var confirmWindow: ConfirmationWindow
@export var alert: Alert
@export var layer: CanvasLayer
@export var fade: CanvasModulate
#variáveis dinâmicas
var isReplace: bool = false
var currentSkillArray: Array = []
#função ready
func _ready() -> void:
	self.settingVisible(false)
	self.allButtons.append(self.closeButton)
#controle de botões
var allButtons: Array[Button] = []
#função de abertura de janela
func setRearrange(newSkills: Array) -> void:
	self.relatedDigimon.BTM.inAction("Skill Rearrangement")
	self.fade.color = Color(0.15, 0.15, 0.15)
	self.currentSkillArray = newSkills
	if(newSkills.size() == 4 and self.relatedDigimon.onEvolving):
		self.isReplace = false
		self.currentMessage.text = tr(StringName(relatedDigimon.digimonName)) + tr(StringName("EvolutionRearrange"))
		self.evolutionSkills.settButtons(newSkills)
	elif(newSkills.size() == 4):
		self.isReplace = true
		self.currentMessage.text = tr(StringName(relatedDigimon.digimonName)) + tr(StringName("ReplaceSkill0")) + tr(StringName(newSkills[3].skillName)) + tr(StringName("ReplaceSkill1"))
		self.replaceSkills.settButtons(newSkills)
	self.visible = true
	self.layer.visible = true
	self.unBlockAllButtons()

#função que bloqueia botões
func blockAllButtons() ->void:
	for nButton: Button in allButtons:
		nButton.disabled = true
#função que desbloqueia os botões
func unBlockAllButtons() -> void:
	for nButton: Button in allButtons:
		nButton.disabled = false
#função que mostra o conteúdo de cada habilidade
func showSkillDesc(skill: Skill) -> void:
	self.infoWindow.showWindow2(skill.skillIcon, tr(StringName(skill.skillName)), tr(StringName(skill.skillDescription)))
	
#encapsulamento do controle de visibilidade
func settingVisible(onOff: bool) -> void:
	self.evolutionSkills.visible = onOff
	self.replaceSkills.visible = onOff
	self.layer.visible = onOff
	self.visible = onOff

func endSelection() -> void:
	if(currentSkillArray.size() == 3):
		self.relatedDigimon.rearrangementSkills = currentSkillArray
		self.relatedDigimon.needRearrangement = false
		self.settingVisible(false)
		self.relatedDigimon.globalFeedback()
	else:
		print("ERROR: Something went wrong, skill array size is ", str(currentSkillArray.size()))
	self.relatedDigimon.BTM.outAction("Skill Rearrangement")
	self.fade.color = Color(1, 1, 1)

func triggerConfirmation(skillName: String) -> void:
	self.blockAllButtons()
	self.confirmWindow.requireConfirmation(tr(StringName("ForgetSkill")) + tr(StringName(skillName)) + "?", self)
#padrão de função de retorno para confirmWindow
func confirmation(confirm: bool) -> void:
	if(confirm):
		if(!self.isReplace):
			self.evolutionSkills.finishingSelection()
		else:
			self.replaceSkills.finishingSelection()
	else:
		self.unBlockAllButtons()

func onClosingButton() -> void:
	self.blockAllButtons()
	self.alert.showAlert(tr(StringName("EVRearrengeAlert")), self)

func closeAlert() -> void:
	self.unBlockAllButtons()
