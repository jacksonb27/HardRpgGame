// Push Action

if (global.pendingAddAction == true) {
    global.pendingAddAction = false;

	global.party[0].actions = AddAction(global.party[0].actions, global.actionLibrary.attack);

    show_debug_message("Action added successfully!");
}
