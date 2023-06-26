#include scripts\chat_commands;
#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\gametypes_zm\_hud_message;

init()
{
    CreateCommand(level.chat_commands["ports"], "setpoints", "function", ::SetPointsCommand, 3);
    CreateCommand(level.chat_commands["ports"], "addpoints", "function", ::AddPointsCommand, 3);
    CreateCommand(level.chat_commands["ports"], "takepoints", "function", ::TakePointsCommand, 3);
    CreateCommand(level.chat_commands["ports"], "giveperk", "function", ::GivePerk, 3);
}

SetPointsCommand(args)
{
    if (args.size < 2)
    {
        return NotEnoughArgsError(2);
    }

    error = SetPlayerPoints(args[0], args[1]);

    if (IsDefined(error))
    {
        return error;
    }
}

AddPointsCommand(args)
{
    if (args.size < 2)
    {
        return NotEnoughArgsError(2);
    }

    error = AddPlayerPoints(args[0], args[1]);

    if (IsDefined(error))
    {
        return error;
    }
}

TakePointsCommand(args)
{
    if (args.size < 2)
    {
        return NotEnoughArgsError(2);
    }

    error = TakePlayerPoints(args[0], args[1]);

    if (IsDefined(error))
    {
        return error;
    }
}


GivePerk(args)
{
    if (args.size < 2)
    {
        return NotEnoughArgsError(2);
    }

    error = GivePlayerPerk(args[0], args[1]);
}
/* Logic section */ 

SetPlayerPoints(playerName, points)
{
    player = FindPlayerByName(playerName);

    if (!IsDefined(player))
    {
        return PlayerDoesNotExistError(playerName);
    }

    player.score = int(points);
}

AddPlayerPoints(playerName, points)
{
    player = FindPlayerByName(playerName);

    if (!IsDefined(player))
    {
        return PlayerDoesNotExistError(playerName);
    }

    player.score += int(points);
}

TakePlayerPoints(playerName, points)
{
    player = FindPlayerByName(playerName);

    if (!IsDefined(player))
    {
        return PlayerDoesNotExistError(playerName);
    }

    player.score -= int(points);
}

GivePlayerPerk(playerName, perk)
{
    player = FindPlayerByName(playerName);

    if (!isDefined(player))
    {
        return PlayerDoesNotExistError(playerName);
    }

    switch (perk)
    {
        case "Juggernog":
            perkid = "specialty_armorvest";
            break;

        case "Deadshot":
            if (level.script == "zm_prison" || level.script == "zm_tomb")
            {
                perkid = "specialty_deadshot";
            } else {
                perkid = Invalidperk();
            }
            
            break;
        
        case "Stamin-up":
            if (level.script != "zm_prison")
            {
                perkid = "specialty_longersprint";
            } else {
                perkid = Invalidperk();
            }
            break;

        case "Speed_cola":
            perkid = "specialty_fastreload";
            break;
        
        case "Double_tap":
            perkid = "specialty_rof";
            break;
        
        case "Mule_kick":
            if (level.script != "zm_prison" || level.script != "zm_transit")
            {
                perkid = "specialty_additionalprimaryweapon";
            } else {
                perkid = Invalidperk();
            }
            
            break;

        case "Vulture_aid":
            if (level.script == "zm_buried")
            {
                perkid = "specialty_nomotionsensor";
                
            } else {
                perkid = Invalidperk();
            }
            break;

        case "Phd_flopper":
            if (level.script == "zm_buried" || level.script == "zm_tomb")
            {
                perkid = "specialty_flakjacket";
            } else {
                perkid = Invalidperk();
            }
            break;

        case "Who's_who":
            if (level.script == "zm_highrise")
            {
                perkid = "specialty_finalstand";
            } else {
                perkid = Invalidperk();
            }
            break;

        case "Tombstone":
            if (level.script == "zm_transit") 
            {
                perkid = "specialty_scavenger";
            } else {
                perkid = Invalidperk();
            }
            break;

        case "Electric_cherry":
            if (level.script == "zm_prison")
            {
                perkid = "specialty_grenadepulldeath";
            } else {
                perkid = Invalidperk();
            }
            break;

        default:
            Invalidperk();
            break;

    }

    if (perkid != "NULL")
    {
        self thread maps\mp\zombies\_zm_perks::wait_give_perk(perkid, 1);
    }
    
}

//Misc Section

Invalidperk()
{
    self IPrintLn("Invalid perk");
    perkid = "NULL"; 
    return perkid;
}