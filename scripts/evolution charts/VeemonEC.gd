extends EvolutionChart
#Veemon evolution charts
class_name VeemonEC

func _init(digimon: Digimon) -> void:
	self.trigger = VeemonECT.new(self)
	self.setting(digimon)

func arrangeTriggers(digimon: Digimon) ->void:
	digimon.onDamageDelt.append(self.trigger)

func unsetting(digimon: Digimon)-> void:
	digimon.onDamageDelt.erase(self.trigger)
