extends Node

class_name Tamer
#elementos de cena
@export var digimon : Digimon
@export var HUDD: HUDDisplay
@export var judge: BattleManager
#tamer attributes
var tamerLevel: int = 3
var actions: int
var canAct: bool = false

#Sumoning Digimon
func summonDigimon(index: int) -> void:
	var data: DigimonData = DDB.getDigimonData(index)
	digimon.setStats(data)

#essa função deve ser substituída
func takeTurn() ->void:
	pass
