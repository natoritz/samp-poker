PkrCMD_Destroy(const playerid, const parameters[]) {
	new gameId = INVALID_POKER_GAME_ID;

    if(sscanf(parameters, "i", gameId))
    {
        SendClientMessage(playerid, COLOR_GREY, "DEBUG USAGE: /pkr destroy [gameId]");
        return;
    }

    if(!Pkr_IsValidGameId(gameId))
    {
        SendClientMessage(playerid, COLOR_RED, "ERROR: Invalid gameId.");
        return;
    }

	if(!Pkr_GetIsAssigned(gameId)) {
		SendClientMessage(playerid, COLOR_RED, "ERROR: That game does not exist.");
		return;
	}

	Pkr_DestroyGame(gameId);

    new message[128];
    format(message, sizeof(message), "Destroyed the game with Game ID: %d", gameId);
	SendClientMessage(playerid, COLOR_RED, message);
	return;
}

PkrCMD_Start(const playerId)
{
    new _gameId = Pkr_GetPlayerGame(playerId);
    if(_gameId == -1)
    {
        SendClientMessage(playerId, COLOR_RED, "You're not playing poker.");
        return;
    }

    new _playerSlot = Pkr_GetPlayerSlot(playerId, _gameId);
    if(_playerSlot == -1)
    {
        SendClientMessage(playerId, COLOR_RED, "You're not playing poker.");
        return;
    }

    new _playerCount = Pkr_GetAmountOfPlayersOnGame(_gameId);

    if(_playerCount == 1)
    {
        SendClientMessage(playerId, COLOR_RED, "You cannot play poker alone.");
        return;
    }

    new _readyCount = Pkr_GetPlayerReadyCount(_gameId);
    if(_readyCount != _playerCount)
    {
        SendClientMessage(playerId, COLOR_RED, "All players must be ready to start playing.");
        return;
    }

    Pkr_StartGame(_gameId);
    return;
}

PkrCMD_NextHand(const playerId)
{
    new _gameId = Pkr_GetPlayerGame(playerId);
    if(_gameId == -1)
    {
        SendClientMessage(playerId, COLOR_RED, "You're not playing poker.");
        return;
    }

    new _playerSlot = Pkr_GetPlayerSlot(playerId, _gameId);
    if(_playerSlot == -1)
    {
        SendClientMessage(playerId, COLOR_RED, "You're not playing poker.");
        return;
    }

    new POKER_GAME_STATUS: _status = Pkr_GetGameStatus(_gameId);

    if(_status != POKER_GAME_STATUS: EVALUATION)
    {
        SendClientMessage(playerId, COLOR_RED, "You can only start the next hand during evaluation.");
        return;
    }

    Pkr_SetGameToLobby(_gameId);
    return;
}
