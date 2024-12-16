extends Tamer

class_name Enemy
#array com uso possível de itens
var possibleItemActions: Array[Skill]
var newerChoice: int

func _ready() -> void:
	EnemyGen.loadContent()
	self.tamerReference = EnemyGen
	EnemyGen.currentTamer = self
	var choice: int = EnemyGen.playerCurrentChoice
	self.tamerName = "Enemy"
	self.tamerLevel = EnemyGen.playerLevel
	self.tamerKarma = EnemyGen.playerKarma
	#setando o damage shower
	turnFrame.visible = false
	#colcoando o mostro escolhido em cena
	self.digimon.setStats(choice)
	#adicionando inventário
	if(Util.checkArray(EnemyGen.playerInventory)):
		for item: Item in EnemyGen.playerInventory:
			self.inventory.addItem(item, item.quantity)
	#atualização da interface. Sempre a última coisa a se fazer!
	HUDD.updateValues()
	#confirma para a classe juiza que tudo está pronto para começar
	judge.gettingStarted()

func makeAChoice() -> void:
	buildItemArray()
	var selectedSkill = null
	var possibleActios: Array[Skill] = self.digimon.digimonSkills.duplicate()
	possibleActios.append_array(possibleItemActions)
	for nskill in possibleActios:
		if(nskill != null):
			nskill.priorityCalculation(digimon)
			if(selectedSkill == null):
				selectedSkill = nskill
			else:
				if(selectedSkill.priority < nskill.priority):
					selectedSkill = nskill
				elif(selectedSkill.priority == nskill.priority):
					selectedSkill = Util.pickOne([selectedSkill, nskill])
	if(selectedSkill != null and selectedSkill.priority != 0):
		digimon.chooseAction(selectedSkill)
		BTM.choosing = false
		BTM.outAction("Enemy make a choice")
	else:
		BTM.choosing = false
		BTM.passingTurn()
	

func onFrameAnimation(anim_name: String):
	if(anim_name == "blinkFrame"):
		BM.showMessage(tr(StringName("BattleMessage2b")))
		makeAChoice()
	elif(anim_name == "blinkActions"):
		actionsDisplay.visible = true

func actionsAnimation(anim_name: String) -> void:
	if(anim_name == "blinkActions"):
		actionsDisplay.visible = true

func buildItemArray() -> void:
	self.possibleItemActions.clear()
	var allUsables: Array = self.inventory.usableItems.values()
	if(allUsables.size() > 0):
		for item: UsableItem in allUsables:
			possibleItemActions.append(ItemUser.new(item))

func saveDigimon(oDigimon: Digimon) -> void:
	var choice: int = EnemyGen.playerCurrentChoice
	EnemyGen.playerParty[choice] = oDigimon.digimonId
	EnemyGen.digimonActiveSkills[choice] = [oDigimon.digimonSkills[2], oDigimon.digimonSkills[3], oDigimon.digimonSkills[4]]
	EnemyGen.currentEquipments[choice] = oDigimon.armory
	EnemyGen.currentStatus[choice] = oDigimon.statusEffect.values()
	EnemyGen.currentHealthMana[choice] = [Util.getProportion(oDigimon.currentHealth, oDigimon.maxHelth), Util.getProportion(oDigimon.currentMana, oDigimon.maxMana)]
	#salvando o tempo de recarga das habilidades
	var coolDown: Array[int] = [0, 0, 0, 0, 0]
	for i: int in range(oDigimon.digimonSkills.size()):
		var nSkill: Skill = oDigimon.digimonSkills[i]
		if(nSkill != null):
			coolDown[i] = nSkill.currentCooldown
	EnemyGen.currentCoolDown[choice] = coolDown

#função de troca de digimon
func changeDigimon(newChoice: int) -> void:
	self.digimon.statusDisplay.stopShowing()
	self.saveDigimon(self.digimon)
	self.digimon.resetTriggers()
	self.newerChoice = newChoice
	self.digimon.skillSpawner.exchangeAnimation()

func replaceDigimon() -> void:
	self.digimon.setStats(newerChoice)
	self.digimon.digimonSprite.visible = true
	EnemyGen.playerCurrentChoice = newerChoice
	#atualização da interface. Sempre a última coisa a se fazer!
	self.digimon.triggerCheck(self.digimon.onChange, "Changing")
	HUDD.updateValues()
	self.BTM.outAction("Changing")
	
