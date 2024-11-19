extends EvolutionChart
#Guilmon evolution charts
class_name GuilmonEC

func _init(digimon: Digimon) -> void:
	self.trigger = GuilmonECT.new(self)
	self.setting(digimon)

func arrangeTriggers(digimon: Digimon) ->void:
	digimon.onChange.append(self.trigger)
