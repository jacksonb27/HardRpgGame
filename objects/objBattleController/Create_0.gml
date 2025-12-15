// =====================================================
// SAFETY CHECK
// =====================================================
if (!global.rpg_initialized) {
    show_message("ERROR: RPG system was not initialized before battle!");
    game_end();
}

// =====================================================
// LOCK PLAYER
// =====================================================
objPlayer.canMove = false;
objPlayer.xSpeed = 0;
objPlayer.ySpeed = 0;
objPlayer.image_index = 0;

// =====================================================
// PARTY SETUP
// =====================================================
party = global.party;

// =====================================================
// ENEMY SETUP (MULTI-ENEMY READY)
// =====================================================

// Enemy DATA (logic)
enemies = [];

// Push enemies here (later you’ll push multiple)
array_push(enemies, {
    name: global.enemy_mossSpawn.name,
    hp_max: global.enemy_mossSpawn.hp_max,
    hp: global.enemy_mossSpawn.hp_max,
    atk: global.enemy_mossSpawn.atk,
    def: global.enemy_mossSpawn.def,
    sprite: global.enemy_mossSpawn.sprite
});

// Enemy VISUAL INSTANCES
enemy_insts = [];

// Positioning
var base_x  = room_width * 0.5;
var base_y  = room_height * 0.35;
var spacing = 96;

// Spawn enemy visuals
for (var i = 0; i < array_length(enemies); i++)
{
    var inst = instance_create_layer(
        base_x + (i - (array_length(enemies) - 1) / 2) * spacing,
        base_y,
        "Instances",
        objBattleEnemy
    );

    // Assign data AFTER creation
    inst.enemy_data = enemies[i];

    // Initialize visuals AFTER data exists
    with (inst) {
        scrBattleEnemySetup(enemy_data);
    }

    enemy_insts[i] = inst;
}

// =====================================================
// TURN / UI STATE
// =====================================================
battle_state = BattleState.PARTY_COMMAND;

active_party_index = 0;
command_index      = 0;
attack_index       = 0;
defend_index       = 0;

commands = ["Attack", "Defend", "Item", "Flee"];

current_message = "";
state_next      = BattleState.PARTY_COMMAND;
message_shown   = false;

// Guard flags
party_guarding = array_create(array_length(party), false);
