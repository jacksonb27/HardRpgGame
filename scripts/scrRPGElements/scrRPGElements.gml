// ====================================================================
//  RPG ELEMENTS MASTER SCRIPT
//  Contains enums, skill DB, weapon DB, armor DB,
//  character templates, and enemy DB.
// ====================================================================


// ####################################################################
#region ENUMS
// ####################################################################

enum SkillID {
    SLASH,
    FIRE,
    FIREBALL,
    BARRIER,
    GUARD
}

enum BattleState {
    PARTY_COMMAND,
    PARTY_ATTACK_MENU,
    PARTY_DEFEND_MENU,
    ENEMY_TURN,
    MESSAGE,
    WIN,
    LOSE
}

// ----------------------------
// WEAPONS & ARMOR
// ----------------------------
enum WeaponID {
    NONE = 0,
    COPPER_SWORD,
    IRON_SWORD,
    OAK_STAFF,
    FIRE_TOME,
    ICE_TOME
}

enum ArmorID {
    NONE = 0,
    CLOTH_ARMOR,
    LEATHER_ARMOR,
    MAGE_ROBE,
    KNIGHT_MAIL
}

#endregion
// ####################################################################



// ####################################################################
#region WEAPON DATABASE
// ####################################################################

// Allocate array with size = last enum + 1
global.weapon_db = array_create(WeaponID.ICE_TOME + 1);

// ----------------------------
// Weapon: None
// ----------------------------
global.weapon_db[WeaponID.NONE] = {
    name: "None",
    atk_bonus: 0,
    mag_bonus: 0,
    def_bonus: 0,
    skills: []
};

// ----------------------------
// Copper Sword
// ----------------------------
global.weapon_db[WeaponID.COPPER_SWORD] = {
    name: "Copper Sword",
    atk_bonus: 1,
    mag_bonus: 0,
    def_bonus: 0,
    skills: [ SkillID.SLASH ]
};

// ----------------------------
// Iron Sword
// ----------------------------
global.weapon_db[WeaponID.IRON_SWORD] = {
    name: "Iron Sword",
    atk_bonus: 1,
    mag_bonus: 0,
    def_bonus: 1,
    skills: [ SkillID.SLASH ]
};

// ----------------------------
// Oak Staff
// ----------------------------
global.weapon_db[WeaponID.OAK_STAFF] = {
    name: "Oak Staff",
    atk_bonus: 1,
    mag_bonus: 1,
    def_bonus: 0,
    skills: [ SkillID.FIREBALL ]
};

// ----------------------------
// Fire Tome
// ----------------------------
global.weapon_db[WeaponID.FIRE_TOME] = {
    name: "Fire Tome",
    atk_bonus: 0,
    mag_bonus: 1,
    def_bonus: 0,
    skills: [ SkillID.FIREBALL ]
};

// ----------------------------
// Ice Tome (new definition)
// ----------------------------
global.weapon_db[WeaponID.ICE_TOME] = {
    name: "Ice Tome",
    atk_bonus: 0,
    mag_bonus: 6,
    def_bonus: 0,
    skills: [ SkillID.FIRE ] // replace with ICE later
};

#endregion
// ####################################################################



// ####################################################################
#region ARMOR DATABASE
// ####################################################################

global.armor_db = array_create(ArmorID.KNIGHT_MAIL + 1);

global.armor_db[ArmorID.NONE] = {
    name: "None",
    def_bonus: 0,
    res_bonus: 0,
    skills: []
};

global.armor_db[ArmorID.CLOTH_ARMOR] = {
    name: "Cloth Armor",
    def_bonus: 2,
    res_bonus: 0,
    skills: []
};

global.armor_db[ArmorID.LEATHER_ARMOR] = {
    name: "Leather Armor",
    def_bonus: 4,
    res_bonus: 1,
    skills: []
};

global.armor_db[ArmorID.MAGE_ROBE] = {
    name: "Mage Robe",
    def_bonus: 1,
    res_bonus: 3,
    skills: [ SkillID.GUARD ]
};

global.armor_db[ArmorID.KNIGHT_MAIL] = {
    name: "Knight Mail",
    def_bonus: 6,
    res_bonus: 2,
    skills: [ SkillID.BARRIER ]
};

#endregion
// ####################################################################



// ####################################################################
#region SKILL DATABASE
// ####################################################################

global.skill_db = array_create(SkillID.GUARD + 1);

global.skill_db[SkillID.SLASH] = {
    name: "Slash",
    sPower: 10,
    mp_cost: 0,
    kind: "offense"
};

global.skill_db[SkillID.FIRE] = {
    name: "Fire",
    sPower: 16,
    mp_cost: 4,
    kind: "offense"
};

global.skill_db[SkillID.FIREBALL] = {
    name: "Fireball",
    sPower: 22,
    mp_cost: 8,
    kind: "offense"
};

global.skill_db[SkillID.GUARD] = {
    name: "Guard",
    sPower: 0,
    mp_cost: 0,
    kind: "defense"
};

global.skill_db[SkillID.BARRIER] = {
    name: "Barrier",
    sPower: 0,
    mp_cost: 6,
    kind: "defense"
};

#endregion
// ####################################################################



// ####################################################################
#region CHARACTER BUILDERS
// ####################################################################

function char_build_warrior() {
    return {
        name: "Luis",
        hp: 50, hp_max: 50,
        mp: 0,  mp_max: 0,

        atk: 12,
        def: 8,
        mag: 4,
        res: 5,

        weapon: WeaponID.COPPER_SWORD,
        armor:  ArmorID.CLOTH_ARMOR
    };
}

function char_build_mage() {
    return {
        name: "Esther",
        hp: 35, hp_max: 35,
        mp: 25, mp_max: 25,

        atk: 10,
        def: 3,
        mag: 12,
        res: 11,

        weapon: WeaponID.OAK_STAFF,
        armor:  ArmorID.MAGE_ROBE
    };
}

function char_build_thief() {
    return {
        name: "James",
        hp: 25, hp_max: 25,
        mp: 10, mp_max: 10,

        atk: 4,
        def: 3,
        mag: 12,
        res: 11,

        weapon: WeaponID.COPPER_SWORD,
        armor:  ArmorID.LEATHER_ARMOR
    };
}

 #endregion
// ####################################################################



// ####################################################################
 #region ENEMY DATABASE
// ####################################################################

global.enemy_mossSpawn = {
    name: "Moss Spawn",
    hp_max: 20,
    atk: 5,
    def: 5,
    sprite: sprMossSpawnBattle
};

 #endregion
// ####################################################################



// ####################################################################
 #region FLAGS
// ####################################################################

global.rpg_initialized = true;

 #endregion
// ####################################################################
