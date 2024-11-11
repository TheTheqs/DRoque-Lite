extends Node2D

class_name DigimonCard
#Elementos de cena
@export var digimonIcon: Sprite2D
@export var digimonName: Label
@export var health: ProgressBar
@export var mana: ProgressBar
var relatedPosition: int

#funçao de montagem do cartão
func buildCard(placeInParty: int) -> void:
	if(Campaign.playerParty[placeInParty] != null):
		var digimonStats: DigimonData = DDB.getDigimonData(Campaign.playerParty[placeInParty])
		self.digimonIcon.texture = digimonStats.digimonIcon
		self.digimonName.text = tr(StringName("DigimonName" + str(digimonStats.digimonId)))
		self.setHealth(Campaign.currentHealthMana[placeInParty][0])
		self.setMana(Campaign.currentHealthMana[placeInParty][1])
		self.relatedPosition = placeInParty
		self.visible = true
	else:
		self.visible = false

#função que estabelece valores
func setHealth(currentHealth: float) -> void:
	health.max_value = 100
	health.value = currentHealth*100

func setMana(currentMana: float) -> void:
	mana.max_value = 100
	mana.value = currentMana*100
