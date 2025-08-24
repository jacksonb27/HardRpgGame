// Menu Functions
function Menu (inX, inY, inOptions, inDescription = -1, inWidth = undefined, inHeight = undefined)
{
	with (instance_create_depth(inX, inY, -999999, objMenu))
	{
		options = inOptions;	
		description = inDescription;
		var optionsCount = array_length(inOptions);
		visibleOptionsMax = optionsCount;
		
		// Setting up Size
		marginX = 14;
		marginY = 7;
		draw_set_font(fntTest2);
		heightLine = 12;
		
		// Auto width
		if (inWidth == undefined)
		{
			width = 1;
			if (description != -1) width = max(width, string_width(inDescription));
			for (var i = 0; i < optionsCount; i ++)
			{
				width = max(width, string_width(inOptions[i][0]));
			}
			widthFull = width + (marginX * 2);
		}else widthFull = inWidth;
		
		// Auto height
		if (inHeight == undefined)
		{
			height = heightLine * (optionsCount + !(description == -1));
			heightFull = height + (marginY * 2);
		}
		else
		{
			heightFull = inHeight;
			
			//scrolling (if needed)
			if (heightLine * (optionsCount + !(description == -1) > inHeight - (marginY * 2)))
			{
				scrolling = true;
				visibleOptions = (inHeight - (marginY * 2)) div heightLine;
			}
		}
	}
}

function SubMenu (inOptions)
{
	//store old options in array
	optionsAbove[subMenuLevel] = options;
	subMenuLevel ++;
	options = inOptions;
	hover = 0;
}

function MenuGoBack ()
{
	subMenuLevel --;
	options = optionsAbove[subMenuLevel];
	hover = 0;
}

function MenuSelectAction (user, action)
{
	with (objMenu) active = false;
	
	// Activate targeting cursor if needed
	with (objBattle) 
	{
		if (action.targetRequired)
		{
			with (cursor)
			{
				active = true;
				activeAction = action;
				targetAll = action.targetAll;
				if (targetAll == MODE.VARIES) targetAll = true;
				activeUser = user;
				
				// Which side to target by default
				if (action.targetEnemyByDefault) //target enemies by default
				{
					targetIndex = 0;
					targetSide = objBattle.enemyUnits;
					activeTarget = objBattle.enemyUnits[targetIndex];
				}
				else //target self/party by default
				{
					targetSide = objBattle.partyUnits;
					activeTarget = activeUser;
					var findSelf = function(element)
					{
						return (element == activeTarget)	
					}
					targetIndex = array_find_index(objBattle.partyUnits, findSelf);
				}
			}
		}
		else
		{
			//if no target needed, begin action and close menu
			BeginAction(user, action, -1);
			with (objMenu) instance_destroy();		
		}
	}
}