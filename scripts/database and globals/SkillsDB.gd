extends Node

class_name SkillDataBase
#o id de habilidades relacionadas à ataque básico serão removidos.
var activeSkillsID: Array[int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 13, 15, 16, 17, 20, 22, 23, 27, 29]
var passiveSkillsID : Array[int] = [11, 14, 18, 19, 21, 24, 25, 26, 28, 30, 35]
#Dicionários de skills
var skills: Dictionary = {
	1 : "res://scripts/skills/damage skills/NeutralNudge.gd",
	2 : "res://scripts/skills/damage skills/FieryFlicker.gd",
	3 : "res://scripts/skills/damage skills/DoubleDelta.gd",
	4 : "res://scripts/skills/damage skills/ThornyThrust.gd",
	5 : "res://scripts/skills/damage skills/RockyRumble.gd",
	6 : "res://scripts/skills/damage skills/ChargedContact.gd",
	7 : "res://scripts/skills/damage skills/GulibleGust.gd",
	8 : "res://scripts/skills/damage skills/LuminousLash.gd",
	9 : "res://scripts/skills/damage skills/ShadowSlice.gd",
	10 : "res://scripts/skills/status skills/CureI.gd",
	11 : "res://scripts/skills/passive skills/EmergencySupplies.gd",
	12 : "res://scripts/skills/status skills/ScaleOneself.gd",
	13 : "res://scripts/skills/status skills/LimiterRemoval.gd",
	14 : "res://scripts/skills/passive skills/ForceOfHabit.gd",
	15 : "res://scripts/skills/damage skills/OpressTheWeak.gd",
	16 : "res://scripts/skills/status skills/TrueVision.gd",
	17 : "res://scripts/skills/status skills/WillfullIgnorance.gd",
	18 : "res://scripts/skills/passive skills/NaturalLens.gd",
	19 : "res://scripts/skills/passive skills/EfficientCasting.gd",
	20 : "res://scripts/skills/damage skills/PoisonMaw.gd",
	21 : "res://scripts/skills/passive skills/SlowAntibodies.gd",
	22 : "res://scripts/skills/status skills/LimiterOverload.gd",
	23 : "res://scripts/skills/status skills/DimensionalBarrier.gd",
	24 : "res://scripts/skills/passive skills/InstinctiveEvasion.gd",
	25 : "res://scripts/skills/passive skills/MarkingDodge.gd",
	26 : "res://scripts/skills/passive skills/CounterMagic.gd",
	27 : "res://scripts/skills/damage skills/WindsOverTheIceBarrier.gd",
	28 : "res://scripts/skills/passive skills/AGlacialHeart.gd",
	29 : "res://scripts/skills/damage skills/BackupStrike.gd",
	30 : "res://scripts/skills/passive skills/Counting.gd",
	35 : "res://scripts/skills/passive skills/SupplySquad.gd",
}

var nativeSkills: Dictionary = {
	0 : ["res://scripts/skills/passive skill (native)/BabyDragonRoar.gd", "res://scripts/skills/damage skills (native)/PepperBreath.gd"],
	1 : ["res://scripts/skills/passive skill (native)/AvengersPact.gd", "res://scripts/skills/damage skills (native)/KucklePunch.gd"],
	2 : ["res://scripts/skills/passive skill (native)/DragonGrumble.gd", "res://scripts/skills/damage skills (native)/VeemonHeadbutt.gd"],
	3 : ["res://scripts/skills/passive skill (native)/RelentlessAgression.gd", "res://scripts/skills/damage skills (native)/FireBall.gd"],
	4 : ["res://scripts/skills/passive skill (native)/Keen.gd", "res://scripts/skills/damage skills (native)/MetalCannon.gd"],
	5 : ["res://scripts/skills/passive skill (native)/MysticalScale.gd", "res://scripts/skills/damage skills (native)/ElectricShock.gd"],
	84: ["res://scripts/skills/passive skill (native)/DragonWrath.gd", "res://scripts/skills/damage skills (native)/VeeLaser.gd"],
	86: ["res://scripts/skills/passive skill (native)/DragonRoar.gd", "res://scripts/skills/damage skills (native)/MegaFlare.gd"],
	87: ["res://scripts/skills/passive skill (native)/RevengeUnion.gd", "res://scripts/skills/damage skills (native)/FangStrike.gd"],
	99: ["res://scripts/skills/passive skill (native)/SharpenedEdge.gd", "res://scripts/skills/damage skills (native)/PowerMetal.gd"]
}

func getSkill(skillId: int) -> Skill:
	if(skills.has(skillId)):
		return load(self.skills[skillId]).new()
	else:
		print("ERROR: Invalid skill ID")
		return null

func getNative(digimonId: int, dicIndex: int) -> Skill:
	if(self.nativeSkills.has(digimonId)):
		return load(self.nativeSkills[digimonId][dicIndex]).new()
	else:
		print("ERROR: Invalid skill ID")
		return null

func getRandomSkills(size: int) -> Array:
	var indexes = min(size - 1, 2)
	var possibleIds: Array = activeSkillsID.duplicate()
	indexes = max(0, indexes)
	var randomSkills: Array = [null, null, null]
	while(indexes >= 0):
		var newSkillId: int = Util.pickOne(activeSkillsID)
		newSkillId = Util.pickOne(possibleIds)
		possibleIds.erase(newSkillId)
		randomSkills[indexes] = getSkill(newSkillId)
		indexes -= 1
	return randomSkills

func getPassiveId(digimonId: int) -> int:
	var relativePassive: PassiveSkill = getNative(digimonId, 0)
	return relativePassive.skillId
