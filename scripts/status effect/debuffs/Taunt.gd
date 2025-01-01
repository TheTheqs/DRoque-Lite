extends StatusEffect

class_name Taunt
#construtora
func _init(nduration: int) -> void:
	self.statusId = 4
	self.statusIcon = preload("res://assets/interface/Icons/InterfaceIcons/status effect icons/Taunt.png")
	self.setStats()
	self.statusType = Enums.StatusType.DEBUFF
	self.isExpirable = true
	self.duration = nduration
	self.statusTriggers.append(TauntTrigger.new(self))

func applyingEffect(digimon: Digimon) -> void:
	for skill: Skill in digimon.digimonSkills:
		if!(skill is DamageSkill) and skill != null:
			skill.manageUsability(1)
	if(digimon.tamer is Player):
		digimon.tamer.buttonPanel.manageSkillUtility()
	digimon.onLearnSkill.append(self.statusTriggers[0])

func unapplyingEffect(digimon: Digimon) -> void:
	for skill: Skill in digimon.digimonSkills:
		if!(skill is DamageSkill) and skill != null:
			skill.manageUsability(-1)
	if(digimon.tamer is Player):
		digimon.tamer.buttonPanel.manageSkillUtility()
	digimon.onLearnSkill.erase(self.statusTriggers[0])

func getStatus() -> StatusEffect:
	var newTaunt: Taunt = Taunt.new(self.duration)
	return newTaunt
