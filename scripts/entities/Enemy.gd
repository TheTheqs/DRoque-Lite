extends Tamer

class_name Enemy
#array com uso possível de itens
var possibleItemActions: Array[Skill]

func _ready() -> void:
	self.tamerName = "Enemy"
	#setando o damage shower
	turnFrame.visible = false
	summonDigimon(Util.random(0,5))
	#teste de habilidades.
	digimon.learnSkill(BasicAtack.new())
	digimon.learnSkill(CureI.new())
	digimon.learnSkill(BackupStrike.new())
	digimon.learnSkill(OpressTheWeak.new())
	digimon.learnSkill(LimiterRemoval.new())
	#teste de habilidades passivas
	digimon.learnSkill(Counting.new())
	digimon.learnSkill(EfficientCasting.new())
	digimon.learnSkill(AGlacialHeart.new())
	digimon.learnSkill(CounterMagic.new())
	digimon.learnSkill(InstinctiveEvasion.new())
	#teste de status effect
	digimon.applyStatus(IntMinus.new(2))
	#teste de inventário
	self.inventory.addItem(ItemDB.getUsableItem(0), 1)
	digimon.currentHealth = Util.cap(digimon.maxHelth/2)
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
		print("Texto do DISPLAY: " + actionsDisplay.text)

func actionsAnimation(anim_name: String) -> void:
	if(anim_name == "blinkActions"):
		actionsDisplay.visible = true

func buildItemArray() -> void:
	self.possibleItemActions.clear()
	var allUsables: Array = self.inventory.usableItems.values()
	if(allUsables.size() > 0):
		for item: UsableItem in allUsables:
			possibleItemActions.append(ItemUser.new(item))
