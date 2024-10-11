extends Node

class_name Tamer
#Só para identificação
var tamerName: String
#elementos de cena
@export var damageShower: DamageShower
@export var digimon : Digimon
@export var opponent: Tamer
@export var HUDD: HUDDisplay
@export var judge: BattleManager
@export var turnFrame: Sprite2D
@export var frameAnimator: AnimationPlayer
@export var BM: BattleMessenger
@export var BTM: BattleManager

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
	opponent.turnFrame.visible = false
	frameAnimator.play("blinkFrame")
