extends Tamer

class_name Enemy

func _ready() -> void:
	self.tamerName = "Enemy"
	#setando o damage shower
	damageShower.position = Vector2(90, 150)
	damageShower.inicitialPosition = Vector2(90, 150)
	damageShower.positionLimit = 95
	turnFrame.visible = false
	summonDigimon(Util.random(0, 5))
	#teste de habilidades.
	digimon.learnSkill(BasicAtack.new())
	#atualização da interface. Sempre a última coisa a se fazer!
	HUDD.updateValues()
	#confirma para a classe huiza que tudo está pronto para começar
	judge.gettingStarted()

func makeAChoice() -> void:
	print("Vindo aqui")
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
