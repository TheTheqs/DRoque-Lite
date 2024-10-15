extends Tamer

class_name Enemy

func _ready() -> void:
	self.tamerName = "Enemy"
	#setando o damage shower
	turnFrame.visible = false
	summonDigimon(4)
	#teste de habilidades.
	digimon.learnSkill(BasicAtack.new())
	digimon.learnSkill(NeutralNudge.new())
	#atualização da interface. Sempre a última coisa a se fazer!
	HUDD.updateValues()
	#confirma para a classe huiza que tudo está pronto para começar
	judge.gettingStarted()

func makeAChoice() -> void:
	var selectedSkill = null
	for nskill in digimon.digimonSkills:
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
