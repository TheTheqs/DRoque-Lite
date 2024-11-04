extends Tamer

class_name Player

#scene elements
@export var buttonPanel : ButtonPanel
@export var inventoyDisplay: InventoryDisplay
func _ready() -> void:
	Campaign.loadContent()
	var choice: int = Campaign.playerCurrentChoice
	self.tamerName = "Player"
	self.tamerLevel = Campaign.playerLevel
	#setando o damage shower
	turnFrame.visible = false
	#colcoando o mostro escolhido em cena
	summonDigimon(Campaign.playerParty[choice])
	digimon.onChanging = true
	#aplicando as habilidade ativas.
	if(Util.checkArray(Campaign.digimonActiveSkills[choice])):
		var activeSkill: Array = Campaign.digimonActiveSkills[choice]
		for skill: Skill in activeSkill:
			if(skill != null):
				self.digimon.learnSkill(skill)
	#applicação de habilidades passivas
	if(Util.checkArray(Campaign.fixedPassives[choice])):
		var passiveSkill: Array = Campaign.fixedPassives[choice]
		for skill: Skill in passiveSkill:
			if(skill != null):
				self.digimon.learnSkill(skill)
	#applicação de status effect
	if(Util.checkArray(Campaign.currentStatus[choice])):
		var statusToApply: Array = Campaign.currentStatus[choice]
		for status: StatusEffect in statusToApply:
			if(status != null):
				self.digimon.applyStatus(status)
	#aplicação de equipamento
	if(Util.checkArray(Campaign.currentEquipments[choice])):
		var equipments: Array = Campaign.currentEquipments[choice]
		for equip: Equipment in equipments:
			if(equip != null):
				self.digimon.equipItem(equip)
	if(Util.checkArray(Campaign.playerInventory)):
		var nInventory: Array = Campaign.playerInventory
		for item: Item in nInventory:
			self.inventory.addItem(item, item.quantity)
	#atualização da vida do Digimon
	self.digimon.currentHealth = Util.cap(self.digimon.maxHelth*Campaign.currentHealth[choice])
	#atualização da interface. Sempre a última coisa a se fazer!
	HUDD.updateValues()
	buttonPanel.setButtons()
	buttonPanel.updateButtons()
	digimon.onChanging = false
	judge.gettingStarted()

func onFrameAnimation(anim_name: String):
	if(anim_name == "blinkFrame"):
		self.canAct = true
		BM.showMessage(tr(StringName("BattleMessage2a")))

func actionsAnimation(anim_name: String) -> void:
	if(anim_name == "blinkActions"):
		actionsDisplay.visible = true
