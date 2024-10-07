extends Node

class_name Tamer
#elementos de cena
@export var digimon : Digimon
@export var HUDD: HUDDisplay
#tamer attributes
var tamerLevel: int = 3

#Sumoning Digimon
func summonDigimon(index: int) -> void:
	var data: DigimonData = DDB.getDigimonData(index)
	digimon.setStats(data)
