/// obj_battle_controller - Create

// --- Player battle stats (you can pull from obj_player later) ---
player_hp_max  = 100;
player_hp      = player_hp_max;
player_mp_max  = 20;
player_mp      = player_mp_max;
player_atk     = 10;
player_def     = 5;
player_speed   = 7;

// Example: starting with one skill and Fire
player_skills = [ SkillID.ATTACK, SkillID.FIRE ];

// Simple battle-only item: Potions
battle_potions = 3;  // how many potions you can use in this battle

// --- Enemy setup ---
e = global.enemy_db[ global.battle_enemy_id ];
enemy_name    = e.name;
enemy_hp_max  = e.hp_max;
enemy_hp      = e.hp_max;
enemy_atk     = e.atk;
enemy_def     = e.def;
enemy_speed   = e.speed;
enemy_sprite  = e.sprite;

// --- Battle state ---
state      = BattleState.PLAYER_CHOOSE;
state_next = BattleState.PLAYER_CHOOSE;

// --- Menus ---
menu_main       = [ "Fight", "Skill", "Item", "Run" ];
menu_main_index = 0;

menu_skill_index = 0;
menu_item_index  = 0; // only one item type for now (Potion)

// --- Message box ---
current_message = "";

// Random seed (optional)
randomize();
