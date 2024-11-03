extends Resource

class_name EquipmentData
#variáveis de preenchimento
@export var itemId: int
@export var itemIcon: CompressedTexture2D
@export var itemEquipmentType: Enums.EquipmentType
@export var equipmentTier: Enums.EquipmentTier
@export var buffedAttributes: Array[String]
@export var itemPassives: Array[Script]
@export var isWeapon: bool
@export var weaponTexture: CompressedTexture2D
@export var textureRange: int
