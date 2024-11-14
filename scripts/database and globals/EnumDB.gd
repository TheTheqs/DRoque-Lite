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
	ULTIMATE,
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
	AUTO,
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
	DEBUFF,
}
#tipo de equipamentos
enum EquipmentType {
	WEAPON,
	OFFHAND,
	ARMOR,
	ACESSORY
}
#tier de equipamentos
enum EquipmentTier {
	COMMON,
	RARE,
	EPIC,
	LEGENDARY
}
#karmas
enum Karma {
	BRAVE, #Corajoso
	MERCIFUL, #Gentil
	FRIENDLY, #Amigável
	ALTRUISTIC, #Altruista
	LOYAL, #Leal
	HONORABLE, #Honrado
	COWARDLY, #Covarde
	HOSTILE, #Hostil
	CRUEL, #Cruel
	GREEDY, #Ganancioso
	RUTHLESS, #Impiedoso
	TREACHEROUS #Traiçoeiro
}
