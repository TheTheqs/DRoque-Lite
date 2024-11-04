extends Node

class_name SkillDataBase
#o id de habilidades relacionadas à ataque básico serão removidos.
var activeSkillsID: Array[int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 13, 15, 16, 17, 20, 22, 23, 27, 29]
var passiveSkillsID : Array[int] = [11, 14, 18, 19, 21, 24, 25, 26, 28, 30, 35]
#Dicionário de skills
var skills: Dictionary = {
	1 : load("res://scripts/skills/damage skills/NeutralNudge.gd"),
	2 : load("res://scripts/skills/damage skills/FieryFlicker.gd"),
	3 : load("res://scripts/skills/damage skills/DoubleDelta.gd"),
	4 : load("res://scripts/skills/damage skills/ThornyThrust.gd"),
	5 : load("res://scripts/skills/damage skills/RockyRumble.gd"),
	6 : load("res://scripts/skills/damage skills/ChargedContact.gd"),
	7 : load("res://scripts/skills/damage skills/GulibleGust.gd"),
	8 : load("res://scripts/skills/damage skills/LuminousLash.gd"),
	9 : load("res://scripts/skills/damage skills/ShadowSlice.gd"),
	10 : load("res://scripts/skills/status skills/CureI.gd"),
	11 : load("res://scripts/skills/passive skills/EmergencySupplies.gd"),
	12 : load("res://scripts/skills/status skills/ScaleOneself.gd"),
	13 : load("res://scripts/skills/status skills/LimiterRemoval.gd"),
	14 : load("res://scripts/skills/passive skills/ForceOfHabit.gd"),
	15 : load("res://scripts/skills/damage skills/OpressTheWeak.gd"),
	16 : load("res://scripts/skills/status skills/TrueVision.gd"),
	17 : load("res://scripts/skills/status skills/WillfullIgnorance.gd"),
	18 : load("res://scripts/skills/passive skills/NaturalLens.gd"),
	19 : load("res://scripts/skills/passive skills/EfficientCasting.gd"),
	20 : load("res://scripts/skills/damage skills/PoisonMaw.gd"),
	21 : load("res://scripts/skills/passive skills/SlowAntibodies.gd"),
	22 : load("res://scripts/skills/status skills/LimiterOverload.gd"),
	23 : load("res://scripts/skills/status skills/DimensionalBarrier.gd"),
	24 : load("res://scripts/skills/passive skills/InstinctiveEvasion.gd"),
	25 : load("res://scripts/skills/passive skills/MarkingDodge.gd"),
	26 : load("res://scripts/skills/passive skills/CounterMagic.gd"),
	27 : load("res://scripts/skills/damage skills/WindsOverTheIceBarrier.gd"),
	28 : load("res://scripts/skills/passive skills/AGlacialHeart.gd"),
	29 : load("res://scripts/skills/damage skills/BackupStrike.gd"),
	30 : load("res://scripts/skills/passive skills/Counting.gd"),
	35 : load("res://scripts/skills/passive skills/SupplySquad.gd")
}

func getSkill(skillId: int) -> Skill:
	if(skills.has(skillId)):
		return self.skills[skillId].new()
	else:
		print("ERROR: Invalid skill ID")
		return null
