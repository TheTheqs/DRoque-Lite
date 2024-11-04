extends Tamer

class_name Player

#scene elements
@export var buttonPanel : ButtonPanel
@export var inventoyDisplay: InventoryDisplay
func _ready() -> void:
	self.tamerName = "Player"
	self.tamerLevel = Campaign.playerLevel
	#setando o damage shower
	turnFrame.visible = false
	summonDigimon(Util.random(0,5))
	#teste de habilidades ativas.
	digimon.learnSkill(BasicAtack.new())
	digimon.learnSkill(LimiterOverload.new())
	digimon.learnSkill(BackupStrike.new())
	digimon.learnSkill(OpressTheWeak.new())
	digimon.learnSkill(LimiterRemoval.new())
	#teste de habilidades passivas
	#teste de status effect
	#teste de inventário
	self.inventory.addItem(ItemDB.getUsableItem(0), 3)
	self.inventory.addItem(ItemDB.getEquipment(4), 1)
	self.inventory.addItem(ItemDB.getEquipment(7), 1)
	self.inventory.addItem(ItemDB.getEquipment(5), 1)
	#teste de equipamento
	digimon.equipItem(ItemDB.getEquipment(2))
	digimon.equipItem(ItemDB.getEquipment(3))
	digimon.equipItem(ItemDB.getEquipment(6))
	digimon.equipItem(ItemDB.getEquipment(8))
	#atualização da interface. Sempre a última coisa a se fazer!
	HUDD.updateValues()
	buttonPanel.setButtons()
	buttonPanel.updateButtons()
	judge.gettingStarted()

func onFrameAnimation(anim_name: String):
	if(anim_name == "blinkFrame"):
		self.canAct = true
		BM.showMessage(tr(StringName("BattleMessage2a")))

func actionsAnimation(anim_name: String) -> void:
	if(anim_name == "blinkActions"):
		actionsDisplay.visible = true
