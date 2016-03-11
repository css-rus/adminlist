#pragma semicolon 1

#define TAG_CLOSE "\x07FF0000[CSS-RUS.RU]\x0700FFFF"

public Plugin:myinfo =
{
	name = "[CS:S] Admin list lite",
	author = "ilga80",
	description = "Простой плагин, показывающий админов в меню",
	version = "1.1",
	url = "http://css-rus.ru"
};

public OnPluginStart()
{
	RegConsoleCmd("admins", Admins_online);
}

public Action:Admins_online(client, args)
{
	if (client > 0)
	{
		decl String:admname[MAX_NAME_LENGTH];
		new Handle:menu = CreateMenu(Menu_Items);
		SetMenuTitle(menu, "Администраторы онлайн:\n \n");
		
		for (new i = 1; i <= MaxClients; i++)
		{
			if(IsClientInGame(i) && i > 0 && GetUserAdmin(i) != INVALID_ADMIN_ID)
			{
				GetClientName(i, admname, sizeof(admname));
				AddMenuItem(menu, admname, admname, ITEMDRAW_DISABLED);
			}
		}
		DisplayMenu(menu, client, 0);
	}
	return Plugin_Handled;
}

public Menu_Items(Handle:menu, MenuAction:action, client, option)
{
	if (action == MenuAction_End)
	{
		CloseHandle(menu);
		return;
	}
	if (action == MenuAction_Cancel && option == MenuCancel_Exit)
	{
		if (client > 0) PrintToChat(client, "%s Список администраторов закрыт!", TAG_CLOSE);
	}
	else if (action == MenuAction_Cancel && option != MenuCancel_Interrupted)
	{
		if (client > 0) PrintToChat(client, "%s Администраторов на сервере сейчас нет!", TAG_CLOSE);
	}
}