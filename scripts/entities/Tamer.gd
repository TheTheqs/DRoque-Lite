extends Node

class_name Tamer
#Current Digimon
@export var digimon : Digimon

#Sumoning Digimon
func summonDigimon(index: int) -> void:
	var data: DigimonData = DDB.getDigimonData(index)
	digimon.setStats(data)
