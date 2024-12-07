extends Node2D

class_name ChangeDigimonWindow
#elementos de cena
@export var card0: DigimonCard
@export var card1: DigimonCard
@export var buttonPanel: ButtonPanel
@export var relatedPlayer: Player
@export var noCompanionLabel: Label
@export var partyTitle: Label
#função ready
func _ready() -> void:
	self.visible = false

#configuração de digimons da party
var configure: Dictionary = {
	0 : [1, 2],
	1 : [0, 2],
	2 : [0, 1]
}

#função quando aberto
func opening() -> void:
	self.buttonPanel.blockAllButtons()
	var configuration: Array = configure[Campaign.playerCurrentChoice]
	if(Campaign.playerParty[configuration[0]] == null and Campaign.playerParty[configuration[1]] == null):
		self.noCompanionLabel.text = tr(StringName("NoCompanion"))
		self.noCompanionLabel.visible = true
	else:
		self.noCompanionLabel.visible = false
		self.card0.buildCard(configuration[0])
		self.card1.buildCard(configuration[1])
	self.partyTitle.text = tr(StringName("Party"))
	self.visible = true

#função quando fechado
func closing() -> void:
	self.visible = false
	self.buttonPanel.unBlockAllButtons()

#função que força o fechamento da janela
func forcedClose() -> void:
	if(self.visible):
		self.closing()

#chamadas de troca
func changeDigmon0() -> void:
	if(relatedPlayer.canAct):
		relatedPlayer.canAct = false
		relatedPlayer.BTM.choosing = false
		relatedPlayer.changeDigimon(self.card0.relatedPosition)

func changeDigmon1() -> void:
	if(relatedPlayer.canAct):
		relatedPlayer.canAct = false
		relatedPlayer.BTM.choosing = false
		relatedPlayer.changeDigimon(self.card1.relatedPosition)
