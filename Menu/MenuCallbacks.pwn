Pkr_PlayerMenuTextDrawClick(const playerid, const Text: clickedid)
{
    new _gameId = Pkr_GetPlayerGame(playerid);

    if(_gameId == -1)
        return;

    #if defined POKER_DEBUG
        new _playerSlot = Pkr_GetCurrentPlayerPosition(_gameId);
    #else
        new _playerSlot = Pkr_GetPlayerSlot(playerid, _gameId);
    #endif

    if(_playerSlot == -1)
        return;

    if(Pkr_GetGameStatus(_gameId) == POKER_GAME_STATUS: LOBBY || Pkr_GetGameStatus(_gameId) == POKER_GAME_STATUS: EVALUATION)
    {
        SendClientMessage(playerid, COLOR_RED, "The menu cannot be used in the lobby or evaluation phase.");
        return;
    }

    if(clickedid == g_rgPokerGames[_gameId][MENU_TEXTDRAWS][0]) // ALL IN
    {
        Pkr_SetPlayerStatusAllIn(_gameId, _playerSlot);
        PlayerPlaySound(playerid, 1054, 0.0, 0.0, 0.0);
        return;
    }

    if(clickedid == g_rgPokerGames[_gameId][MENU_TEXTDRAWS][1]) // BET OR RAISE
    {
        if(Pkr_GetMenuItemOneState(_gameId) == POKER_MENU_STATES: BET)
        {
            Pkr_GameShowBetDialog(playerid);
        }
        else
        {
            Pkr_GameShowRaiseDialog(playerid, _gameId);
        }

        PlayerPlaySound(playerid, 1054, 0.0, 0.0, 0.0);
        return;
    }

    if(clickedid == g_rgPokerGames[_gameId][MENU_TEXTDRAWS][2]) // CHECK OR CALL
    {
        if(Pkr_GetMenuItemTwoState(_gameId) == POKER_MENU_STATES: CHECK)
        {
            Pkr_GameShowCheckConfirmDialog(playerid);
        }
        else
        {
            Pkr_GameShowCallConfirmDialog(playerid, _gameId);
        }

        PlayerPlaySound(playerid, 1054, 0.0, 0.0, 0.0);
        return;
    }

    if(clickedid == g_rgPokerGames[_gameId][MENU_TEXTDRAWS][3])
    {
        Pkr_SetPlayerStatusFolded(_gameId, _playerSlot);
        Pkr_SetNextPlayerPlaying(_gameId);
        PlayerPlaySound(playerid, 1054, 0.0, 0.0, 0.0);
        return;
    }

    return;
}
