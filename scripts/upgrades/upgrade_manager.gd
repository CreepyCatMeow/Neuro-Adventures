extends Node2D
class_name UpgradeManager

func _ready() -> void: 
	Globals.get_random_upgrades.connect(get_random_upgrades)
	Globals.get_all_existing_upgrades.connect(get_all_existing_upgrades)
	Globals.lvl_up.connect(lvl_up)
	Globals.map_ready.connect(_on_map_ready)
	Globals.remove_maxed_upgrades.connect(remove_maxed_upgrades)

## character specific upgrades should be merged into this array
## Upgrades in this array will be included in the game
## regardless of the characters used. Character specific upgrades
## will only be included if that specific character is used. 
## The first upgrade in a character specific upgrades database will
## be used as the default weapon. 
var upgrades_db = [
	Upgrade.new(
		"Programming Socks",
		preload("res://assets/upgrades/programming_socks_icon.png"),
		[
			"+ 5% faster speed (for both characters)",
			"+ 10% faster speed (for both characters)",
			"+ 15% faster speed (for both characters)",
			"+ 20% faster speed (for both characters)"
		],
		Globals.UpgradeType.COLLAB_PARTNER_UPGRADE, 
		4,
		0,
		preload("res://scenes/upgrades/programming_socks.tscn")
	),
	Upgrade.new(
		"Shock Magnet",
		preload("res://assets/upgrades/shock_magnet_icon.png"),
		[
			"+30% larger item collection range",
			"+40% larger item collection range",
			"+50% larger item collection range",
		],
		Globals.UpgradeType.COLLAB_PARTNER_UPGRADE, 
		3,
		0,
		preload("res://scenes/upgrades/shock_magnet.tscn")
	),
	Upgrade.new(
		"Filter",
		preload("res://assets/upgrades/filtered_icon.png"),
		[
			"AIs now do 30% less damage to collab partners",
			"AIs now do 50% less damage to collab partners",
			"AIs now do 75% less damage to collab partners",
			"AIs now do 90% less damage to collab partners"
		],
		Globals.UpgradeType.AI_UPGRADE, 
		4,
		0,
		preload("res://scenes/upgrades/filter.tscn")
	)
]

var neuro_upgrades_db = [
	Upgrade.new(
		"Dual Strike", 
		preload("res://assets/upgrades/swords_icon.png"),
		[
			"Dual Strike",
			"Less interval between strikes ",
			"Double damage per strike",
			"Greater strike range",
			"Even Less interval between strikes"
		], 
		Globals.UpgradeType.AI_UPGRADE, 
		5, 
		0,
		preload("res://scenes/upgrades/dual_strike_scene.tscn")
	), 
	Upgrade.new(
		"Gymbag Drone",
		preload("res://assets/upgrades/gymbag_drone_icon.png"),
		[
			"A gymbag drone that will strike enemies at random. Will return to Neuro every 25 seconds."
		],
		Globals.UpgradeType.AI_UPGRADE, 
		1,
		0,
		preload("res://scenes/upgrades/gymbag_drone.tscn"),
		["unlimited"]
	),
	Upgrade.new(
		"Swarm Upgrades",
		preload("res://assets/upgrades/swarm_upgrades_icon.png"),
		[
			"Increase damage of all gymbag drones by 100% of base",
			"Increase speed of all gymbag drones by 50% of base",
			"Increase damage of all gymbag drones by 200% of base",
			"Increase speed of all gymbag drones by 100% of base"
		],
		Globals.UpgradeType.AI_UPGRADE, 
		4,
		0,
		preload("res://scenes/upgrades/swarm_upgrades.tscn")
	),
	Upgrade.new(
		"Gaslight",
		preload("res://assets/upgrades/gaslight_icon.png"),
		[
			"Gives the AI 5% chance to ignore damage and 10% chance to divert the damage to the Collab Partner",
			"Gives the AI 7% chance to ignore damage and 15% chance to divert the damage to the Collab Partner",
			"Gives the AI 10% chance to ignore damage and 20% chance to divert the damage to the Collab Partner",
			"Gives the AI 30% chance to ignore damage and 50% chance to divert the damage to the Collab Partner"
		],
		Globals.UpgradeType.AI_UPGRADE, 
		4,
		0,
		preload("res://scenes/upgrades/gaslight.tscn")
	),
	Upgrade.new(
		"Say it Back!",
		preload("res://assets/upgrades/say_it_back_icon.png"),
		[
			"Both characters have 50% increased damage. The AI will chase after you closer",
			"Both characters have 100% increased damage. The AI will chase after you even closer",
			"Both characters have 150% increased damage. The AI will chase after you like never before."
		],
		Globals.UpgradeType.AI_UPGRADE, 
		3,
		0,
		preload("res://scenes/upgrades/say_it_back.tscn")
	),
	Upgrade.new(
		"Angel Wings",
		preload("res://assets/upgrades/angel_wings_icon.png"),
		[
			"Feathers shoot out from Neuro that target enemies. MAY TARGET COLLAB PARTNER",
			"Feathers can pierce through up to three enemies",
			"Increased fire rate of feathers",
			"Increased damage of feathers",
			"Two feathers are shot at once"
		],
		Globals.UpgradeType.AI_UPGRADE, 
		5,
		0,
		preload("res://scenes/upgrades/angel_wings.tscn")
	),
	Upgrade.new(
		"iNuke6000",
		preload("res://assets/upgrades/inuke6000_icon.png"),
		[
			"iNuke6000s are dropped at a random enemy in range every 6 s dealing splash damage of 12. MAY TARGET COLLAB PARTNER",
			"Nuke launch time is reduced",
			"Two nukes are launched at a time",
			"Nuke launch time is further reduced  ",
			"Three nukes are launched at a time"
		],
		Globals.UpgradeType.AI_UPGRADE, 
		5,
		0,
		preload("res://scenes/upgrades/inuke6000.tscn")
	),
	Upgrade.new(
		"Raise the Timer!",
		preload("res://assets/upgrades/raise_the_timer_icon.png"),
		[
			"The AI will start loosing HP every 1s, but exps will now give 0.6 HP to the AI",
			"The AI will start loosing HP every 1s, but exps will now give 0.7 HP to the AI",
			"The AI will start loosing HP every 1s, but exps will now give 0.8 HP to the AI" 
		],
		Globals.UpgradeType.AI_UPGRADE, 
		3,
		0,
		preload("res://scenes/upgrades/raise_the_timer.tscn")
	),
	Upgrade.new(
		"Cookies",
		preload("res://assets/upgrades/cookies_icon.png"),
		[
			"1% chance for enemies to drop cookies (Gives 5 HP to the AI)",
			"2% chance for enemies to drop cookies ",
			"3% chance for enemies to drop cookies ",
			"5% chance for enemies to drop cookies"
		],
		Globals.UpgradeType.AI_UPGRADE, 
		4,
		0,
		preload("res://scenes/upgrades/cookies_upgrade.tscn")
	)
]

var evil_upgrades_db = [
	Upgrade.new(
		"Knife", 
		preload("res://assets/upgrades/knife_icon.png"),
		[
			"Knife",
			"Less interval between strikes",
			"More damage per strike",
			"Increased range",
			"Even less interval between strikes",
			"Increased range. Warning, this range equals Evil's default distance from the collab partner."
		], 
		Globals.UpgradeType.AI_UPGRADE, 
		6, 
		0,
		preload("res://scenes/upgrades/knife_scene.tscn")
	),
	Upgrade.new(
		"Summon Circle", 
		preload("res://assets/upgrades/summon_circle_icon.png"),
		[
			"Summon circle. Will slow all enemies within range by 20%",
			"Will slow all enemies within range by 30% ",
			"Will slow all enemies within range by 40%",
			"Increase range of summon circle",
			"Will slow all enemies within range by 50%",
			"Will slow all enemies within range by 60%"
		], 
		Globals.UpgradeType.AI_UPGRADE, 
		6, 
		0,
		preload("res://scenes/upgrades/summon_circle.tscn")
	),
	Upgrade.new(
		"Soul Stealer",
		preload("res://assets/upgrades/soul_stealer_circle_icon.png"),
		[
			"Everytime Evil deals damage, she will gain 1% of the damage dealt as HP",
			"Everytime Evil deals damage, she will gain 2% of the damage dealt as HP",
			"Everytime Evil deals damage, she will gain 3% of the damage dealt as HP",
			"Everytime Evil deals damage, she will gain 5% of the damage dealt as HP"
		],
		Globals.UpgradeType.AI_UPGRADE,
		4,
		0,
		preload("res://scenes/upgrades/soul_stealer.tscn")
	),
	Upgrade.new(
		"Forgotten Child",
		preload("res://assets/upgrades/forgotten_child_icon.png"),
		[
			"Both characters have + 50% of base damage. Evil will stay further away from you",
			"Both characters have + 100% of base damage. Evil will stay even further away from you",
			"Both characters have + 200% of base damage. ReallyGunPull turtle ReallyGunPull turtle"
		],
		Globals.UpgradeType.AI_UPGRADE,
		3,
		0,
		preload("res://scenes/upgrades/forgotten_child.tscn")
	),
	Upgrade.new(
		"Pizza",
		preload("res://assets/upgrades/pizza_icon.png"),
		[
			"A pineapple pizza will target enemies closest to Evil."
		],
		Globals.UpgradeType.AI_UPGRADE, 
		1,
		0,
		preload("res://scenes/upgrades/pizza.tscn"),
		["unlimited"]
	),
	Upgrade.new(
		"Viva La Pizza Revolution!",
		preload("res://assets/upgrades/viva_la_pizza_revolution_icon.png"),
		[
			"Increase speed of all pizza by 30% of base",
			"Increase damage of all pizza by 50% of base",
			"Increase speed of all pizza by 50% of base",
			"Increase damage of all pizza by 150% of base"
		],
		Globals.UpgradeType.AI_UPGRADE, 
		4,
		0,
		preload("res://scenes/upgrades/viva_la_pizza_rev.tscn")
	),
	Upgrade.new(
		"Fireball",
		preload("res://assets/upgrades/fireball_icon.png"),
		[
			"Evil fires a fireball in 4 directions every 2s that can pierce up to 2 enemies",
			"Fireball fire cooldown is reduced to 1.5s",
			"Evil fires a fireball in 6 directions that can pierce up to 3 enemies",
			"Fireball damage is increased by 100%",
			"Evil fires a fireball in 8 directions that can pierce up to 4 enemies",
			"Evil becomes a 2hu character. Warning, dangerous upgrade."
		],
		Globals.UpgradeType.AI_UPGRADE,
		6,
		0,
		preload("res://scenes/upgrades/fireball_scene.tscn")
	)
]

var vedal_upgrades_db = [
	Upgrade.new(
		"Rum",
		preload("res://assets/upgrades/rum_icon.png"),
		[
			"Rum", 
			"Rum splash will stun all enemies stepping in for 1s",
			"Rum fire rate is increased",
			"Rum splash lasts longer and deals more frequent damage",
			"Rum splash will stun all enemies stepping in for 3s"
		],
		Globals.UpgradeType.COLLAB_PARTNER_UPGRADE, 
		5,
		0,
		preload("res://scenes/upgrades/rum_scene.tscn")
	),
	Upgrade.new(
		"DM Allegations",
		preload("res://assets/upgrades/dm_allegations_icon.png"),
		[
			"Press [space] for Vedal to become immune for 0.4s. Pink notif means ability is ready",
			"Cooldown is reduced to 4s",
			"Immunity duration increased to 0.6s",
			"Cooldown is reduced to 3s",
			"Cooldown is reduced to 2s"
		],
		Globals.UpgradeType.COLLAB_PARTNER_UPGRADE,
		4,
		0,
		preload("res://scenes/upgrades/dm_allegations.tscn")
	),
	Upgrade.new(
		"Creggs",
		preload("res://assets/upgrades/creggs_icon.png"),
		[
			"1% chance for enemies to drop a chicken bake (Gives 7 HP to the Collab Partner)",
			"2% chance for enemies to drop chicken bake ",
			"3% chance for enemies to drop chicken bake ",
			"5% chance for enemies to drop chicken bake"
		],
		Globals.UpgradeType.COLLAB_PARTNER_UPGRADE, 
		4,
		0,
		preload("res://scenes/upgrades/creggs_upgrade.tscn")
	)
]

var anny_upgrades_db = [
	Upgrade.new(
		"Star",
		preload("res://assets/upgrades/star_icon.png"),
		[
			"A spinning star spawns and orbits Anny every 2.5s that deals 2 damage. Stars do double damage after 10s",
			"Interval decreases to 2.0s",
			"Damage increases to 3", 
			"Interval decreases to 1.5s",
			"Stars deal double damage after 5s",
			"Damage increases to 4" 
		],
		Globals.UpgradeType.COLLAB_PARTNER_UPGRADE, 
		6,
		0,
		preload("res://scenes/upgrades/star_upgrade.tscn")
	),
	Upgrade.new(
		"Portal",
		preload("res://assets/upgrades/portal_icon.png"),
		[
			"Press [space] for Anny to teleport to the location of the mouse cursor. Cooldown proportional to distance teleported",
			"Reduce base cooldown to 10s",
			"Reduce base cooldown to 8s",
			"Reduce base cooldown to 6s",
			"Reduce base cooldown to 5s"
		],
		Globals.UpgradeType.COLLAB_PARTNER_UPGRADE, 
		5,
		0,
		preload("res://scenes/upgrades/portal_upgrade.tscn")
	),
	Upgrade.new(
		"Orange",
		preload("res://assets/upgrades/orange_icon.png"),
		[
			"Anny has regen which is increased for 30s by collecting an orange with a 1% drop chance",
			"2% chance for enemies to drop an orange ",
			"3% chance for enemies to drop an orange ",
			"5% chance for enemies to drop an orange "
		],
		Globals.UpgradeType.COLLAB_PARTNER_UPGRADE, 
		4,
		0,
		preload("res://scenes/upgrades/orange_upgrade.tscn")
	)
]

var existing_upgrades = []

func _on_map_ready() -> void:
	match SavedOptions.settings.collab_partner_selected:
		SavedOptions.CollabPartnerSelection.VEDAL: 
			merge_character_upgrade_db(vedal_upgrades_db) 
			lvl_up(find_upgrade("Rum"))
			lvl_up(find_upgrade("Creggs"))
		SavedOptions.CollabPartnerSelection.ANNY:
			merge_character_upgrade_db(anny_upgrades_db)
			lvl_up(find_upgrade("Star"))
			lvl_up(find_upgrade("Portal"))

	match SavedOptions.settings.ai_selected: 
		SavedOptions.AISelection.NEURO: 
			merge_character_upgrade_db(neuro_upgrades_db) 
			lvl_up(find_upgrade("Dual Strike"))
			lvl_up(find_upgrade("Cookies"))
			
		SavedOptions.AISelection.EVIL: 
			merge_character_upgrade_db(evil_upgrades_db) 
			lvl_up(find_upgrade("Knife"))
			lvl_up(find_upgrade("Soul Stealer"))
			
func find_upgrade(upgrade_name: String) -> Upgrade: 
	for upgrade in upgrades_db: 
		if upgrade.upgrade_name == upgrade_name:
			return upgrade 
	push_error("UPGRADE NOT FOUND!")
	return null 

func merge_character_upgrade_db(upgrades: Array) -> void:
	for upgrade in upgrades:
		upgrades_db.append(upgrade)

func get_random_upgrades() -> void:
	remove_maxed_upgrades()
	
	var temp_upgrades_db = upgrades_db.duplicate() 
	var random_upgrades = []
	
	if temp_upgrades_db.size() < 3: 
		Globals.send_random_upgrades.emit(temp_upgrades_db)
		return
	
	for i in range(3): 
		var random_index = randi() % temp_upgrades_db.size()  
		random_upgrades.append(temp_upgrades_db[random_index])
		temp_upgrades_db.remove_at(random_index)
	
	Globals.send_random_upgrades.emit(random_upgrades)

## Ensure to emit remove maxed upgrades 
## before using this function
func get_all_existing_upgrades() -> void:
	Globals.send_all_existing_upgrades.emit(existing_upgrades)

func remove_maxed_upgrades() -> void: 
	var to_remove = [] 
	
	for upgrade in upgrades_db:
		if upgrade.max_lvl == upgrade.lvl: 
			to_remove.append(upgrade) 
	
	for upgrade in to_remove:
		existing_upgrades.erase(upgrade)
		upgrades_db.erase(upgrade)

func lvl_up(upgrade: Upgrade) -> void: 
	if upgrade.lvl == 0:
		if not existing_upgrades.has(upgrade):
			existing_upgrades.append(upgrade)
		
		upgrade.lvl = 1
		var scene = upgrade.scene_template.instantiate() 
		#WARNING: Cyclic reference. Should be allowed in godot 4.2 though 
		# adding a warning just in case 
		upgrade.scene = scene 
		scene.upgrade = upgrade
		
		if upgrade.upgrade_type == Globals.UpgradeType.AI_UPGRADE:
			Globals.add_upgrade_to_ai.emit(scene)
		elif upgrade.upgrade_type == Globals.UpgradeType.COLLAB_PARTNER_UPGRADE:
			Globals.add_upgrade_to_collab_partner.emit(scene)	

	else: 
		upgrade.lvl += 1 
		upgrade.scene.sync_level()  
