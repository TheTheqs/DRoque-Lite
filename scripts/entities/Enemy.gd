extends Tamer

class_name Enemy
#array com uso possível de itens
var possibleItemActions: Array[Skill]

func _ready() -> void:
	EnemyGen.loadContent()
	self.tamerReference = EnemyGen
	var choice: int = EnemyGen.playerCurrentChoice
	self.tamerName = "Enemy"
	self.tamerLevel = EnemyGen.playerLevel
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
