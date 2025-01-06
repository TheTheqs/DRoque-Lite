extends StatusEffect

class_name Charm
#construtora
func _init(nduration: int) -> void:
	self.statusId = 24
	self.statusIcon = preload("res://assets/interface/Icons/InterfaceIcons/status effect icons/Charm.png")
	self.setStats()
	self.statusType = Enums.StatusType.DEBUFF
	self.isExpirable = true
	self.duration = nduration
	self.statusTriggers.append(CharmTrigger.new())

func applyingEffect(digimon: Digimon) -> void:
	for skill: Skill in digimon.digimonSkills:
		if(skill is DamageSkill) and skill != null:
			skill.manageUsability(1)
	if(digimon.tamer is Player):
		digimon.tamer.buttonPanel.manageSkillUtility()
	digimon.onLearnSkill.append(self.statusTriggers[0])

func unapplyingEffect(digimon: Digimon) -> void:
	for skill: Skill in digimon.digimonSkills:
		if(skill is DamageSkill) and skill != null:
			skill.manageUsability(-1)
	if(digimon.tamer is Player):
		digimon.tamer.buttonPanel.manageSkillUtility()
	digimon.onLearnSkill.erase(self.statusTriggers[0])

func getStatus() -> StatusEffect:
	return Charm.new(self.duration)
