extends EvolutionChart
#monodramon evolution charts
class_name MonodramonEC

func _init(digimon: Digimon) -> void:
	self.trigger = MonodramonECT.new(self)
	self.setting(digimon)

func arrangeTriggers(digimon: Digimon) ->void:
	digimon.onLearnSkill.append(self.trigger)

func unsetting(digimon: Digimon)-> void:
	digimon.onLearnSkill.erase(self.trigger)
