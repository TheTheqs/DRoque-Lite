extends Node2D

#classe que constroi e mantém os status de vida, nome e mana do digimon
class_name HUDDisplay
#elementos em cena
@export var nameAndLevel: RichTextLabel
@export var health: ProgressBar
@export var mana: ProgressBar
@export var ownerPlayer: Tamer
var relatedDigimon: Digimon

func _ready()-> void:
	relatedDigimon = ownerPlayer.digimon
	if(ownerPlayer is Enemy):
		health.fill_mode = ProgressBar.FILL_END_TO_BEGIN

#função que estabelece valores
func setHealth() -> void:
	health.max_value = relatedDigimon.maxHelth
	health.value = relatedDigimon.currentHealth

func setMana() -> void:
	mana.max_value = relatedDigimon.maxMana
	mana.value = relatedDigimon.currentMana

func updateValues() -> void:
	nameAndLevel.text = "[center]" + tr(relatedDigimon.digimonName) + "\nLv. " + str(relatedDigimon.currentLevel) + "[/center]"
	setHealth()
	setMana()
