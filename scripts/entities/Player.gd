extends Tamer

class_name Player

#scene elements
@export var buttonPanel : ButtonPanel
@export var inventoyDisplay: InventoryDisplay
var newerChoice: int
func _ready() -> void:
	Campaign.loadContent() #essa é apenas uma função de testes
	#as declarações abaixo recebem dados da variável global.
	self.tamerName = "Player"
	self.tamerReference = Campaign
	self.tamerLevel = Campaign.playerLevel
	self.tamerKarma = Campaign.playerKarma
	turnFrame.visible = false
	#adicionando inventário
	if(Util.checkArray(Campaign.playerInventory)):
		for item: Item in Campaign.playerInventory:
			self.inventory.addItem(item, item.quantity)
	#coloca o digimon corrente em cena
	var choice: int = Campaign.playerCurrentChoice
	self.digimon.setStats(choice)
	#atualização da interface. Sempre a última coisa a se fazer!
	self.updateInterface()
	judge.gettingStarted()

func onFrameAnimation(anim_name: String):
	if(anim_name == "blinkFrame"):
		self.canAct = true
		BM.showMessage(tr(StringName("BattleMessage2a")))

func actionsAnimation(anim_name: String) -> void:
	if(anim_name == "blinkActions"):
		actionsDisplay.visible = true

func saveDigimon(oDigimon: Digimon) -> void:
	var choice: int = Campaign.playerCurrentChoice
	Campaign.playerParty[choice] = oDigimon.digimonId
	Campaign.digimonActiveSkills[choice] = [oDigimon.digimonSkills[2], oDigimon.digimonSkills[3], oDigimon.digimonSkills[4]]
	Campaign.currentEquipments[choice] = oDigimon.armory
	Campaign.currentStatus[choice] = oDigimon.statusEffect.values()
	Campaign.currentHealthMana[choice] = [Util.getProportion(oDigimon.currentHealth, oDigimon.maxHelth), Util.getProportion(oDigimon.currentMana, oDigimon.maxMana)]
	#salvando o tempo de recarga das habilidades
	var coolDown: Array[int] = [0, 0, 0, 0, 0]
	for i: int in range(oDigimon.digimonSkills.size()):
		var nSkill: Skill = oDigimon.digimonSkills[i]
		if(nSkill != null):
			coolDown[i] = nSkill.currentCooldown
	Campaign.currentCoolDown[choice] = coolDown

#função de troca de digimon
func changeDigimon(newChoice: int) -> void:
	self.buttonPanel.blockAllButtons()
	self.BTM.closeAllWindows()
	self.digimon.statusDisplay.stopShowing()
	self.saveDigimon(self.digimon)
	self.digimon.resetTriggers()
	self.newerChoice = newChoice
	self.digimon.skillSpawner.exchangeAnimation()

func replaceDigimon() -> void:
	self.digimon.setStats(newerChoice)
	self.digimon.digimonSprite.visible = true
	Campaign.playerCurrentChoice = newerChoice
	#atualização da interface. Sempre a última coisa a se fazer!
	self.updateInterface()
	self.buttonPanel.unBlockAllButtons()
	self.digimon.triggerCheck(self.digimon.onChange, "Changing")
	self.BTM.outAction("Changing")
	

func updateInterface() -> void:
	self.HUDD.updateValues()
	self.buttonPanel.setButtons()
	self.buttonPanel.updateButtons()
