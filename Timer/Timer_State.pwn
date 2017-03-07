Pkr_SetTimerValue(const gameId, const value) {
	if(Pkr_GetTimerStart(gameId) == 0)
		return;

	new tdText[128];
	format(tdText, sizeof(tdText), "%d", value);
	Pkr_SetTimerTextDrawText(gameId, tdText);
	Pkr_SetTimer(gameId, value);
	return;
}

forward Pkr_OnOneSecond();
public Pkr_OnOneSecond() {
	Pkr_ForeachGame(gameId) {
		if(!Pkr_GetIsAssigned(gameId) || Pkr_GetTimerStart(gameId) == 0)
			continue;

		new POKER_GAME_STATUS: gameStatus = Pkr_GetGameStatus(gameId);
		if(gameStatus != POKER_GAME_STATUS: LOBBY && gameStatus != POKER_GAME_STATUS: EVALUATION) {
			new currentTime = Pkr_GetTimer(gameId);

			if(currentTime <= 6 && currentTime > 0)
				Pkr_PlaySoundForPlayers(gameId, 1137);

			if(currentTime == 0) {
				Pkr_PlaySoundForPlayers(gameId, 1085);
				new playerSlot = Pkr_GetCurrentPlayerPosition(gameId);
				Pkr_SetPlayerStatusFolded(gameId, playerSlot);
				Pkr_SetNextPlayerPlaying(gameId);
				continue;
			}

			Pkr_SetTimerValue(gameId, currentTime - 1);
		}
	}

	return;
}

Pkr_PlaySoundForPlayers(const gameId, const soundId) {
	Pkr_ForeachPlayer(playerSlot) {
		PlayerPlaySound(Pkr_GetPlayerId(gameId, playerSlot), soundId, 0.0, 0.0, 0.0);
	}
}
