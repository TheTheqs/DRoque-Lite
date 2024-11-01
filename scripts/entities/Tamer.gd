extends Node

class_name Tamer
#Só para identificação
var tamerName: String
#elementos de cena
@export var digimon : Digimon
@export var opponent: Tamer
@export var HUDD: HUDDisplay
@export var judge: BattleManager
@export var turnFrame: Sprite2D
@export var frameAnimator: AnimationPlayer
@export var BM: BattleMessenger
@export var BTM: BattleManager
@export var numberSpawner: NumberSpawner
@export var actionsDisplay: Label
@export var actionAnimator: AnimationPlayer

#tamer attributes
var tamerLevel: int = 3
var actions: int
var canAct: bool = false
var inventory: Inventory = Inventory.new(self)
#Sumoning Digimon
func summonDigimon(index: int) -> void:
	var data: DigimonData = DDB.getDigimonData(index)
	digimon.setStats(data)

func takeTurn() ->void:
	opponent.turnFrame.visible = false
	frameAnimator.play("blinkFrame")

func showContent(content) -> void:
	numberSpawner.spawnContent(content)

func getActions(nactions: int) -> void:
	if(actions + nactions > 5):
		actions = 5
		BM.showMessage(tr(StringName("ActionLimit")))
	else:
		actions += nactions
	actionAnimator.play("blinkActions")
	actionsDisplay.text = tr(StringName("Actions")) + str(self.actions)
	

func takeActions(nactions: int) -> void:
	self.actions -= nactions
	if(self.actions <= 0):
		self.actions = 0
	actionAnimator.play("blinkActions")
	actionsDisplay.text = tr(StringName("Actions")) + str(self.actions)
	
