extends Resource
class_name EnemyData


@export var name : String
@export_range(0, 999) var baseHealth : int
@export_range(0, 99) var baseDamage : int
@export_range(0, 99) var baseBravery : int
@export_range(0,99) var deployCost : int
@export_range(0,99) var eraseCost : int


