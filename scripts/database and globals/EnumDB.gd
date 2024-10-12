extends Node

class_name Enums

#Tipo de Digimon
enum Type {
	VIRUS,
	DATA,
	VACCINE,
	FREE,
	SPECIAL
}
#Tier de Digimon
enum Tier {
	ROOKIE,
	CHAMPION,
	ULTIMA,
	MEGA 
}
#Elementos 
enum Element {
	NEUTRAL,
	FIRE,
	WATER,
	PLANT,
	THUNDER,
	EARTH,
	WIND,
	LIGHT,
	DARK
}

#Tipo de dano
enum DamageType {
	PHYSICAL, 
	MAGICAL,
	TRUE
}

#Subtipo de dano
enum DamageSubType {
	DIRECT,
	OVERTIME,
	DEFLECT,
	SPECIAL
}

#Fase de batalha
enum BattlePhase {
	BATTLESTART,
	TURNSTART,
	CHOICE,
	ACTION,
	POSACTION,
	TURNEND,
	BATTLEEND
}

#tipos de efeito
enum StatusType {
	BUFF,
	DEBUFF
}
