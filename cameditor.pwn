// ============================================================
// CamEditor FilterScripts (MOBILE) com TextDraws
// Autor: Punish (ID: 968249958941741087)
// Adaptado com suporte a mover, ajustar olhar e salvar posição
// ============================================================

#include <a_samp>
#include <zcmd>

new
   bool:IsCamEditorActive[MAX_PLAYERS];
new
   bool:IsAdjustingLook[MAX_PLAYERS];

new Float:CamX[MAX_PLAYERS], Float:CamY[MAX_PLAYERS], Float:CamZ[MAX_PLAYERS];
new Float:CamLookX[MAX_PLAYERS], Float:CamLookY[MAX_PLAYERS], Float:CamLookZ[MAX_PLAYERS];
new Float:CamSpeed[MAX_PLAYERS] = 1.0;

new 
   PlayerText:Text_Arrows[MAX_PLAYERS][7];

enum {
    DIALOG_CAM_SPEED = 1
};

public OnFilterScriptInit() {
    print("[CamEditor]: Iniciado com sucesso.");
    return true;
}

public OnFilterScriptExit() {
    print("[CamEditor]: Finalizado com sucesso.");
    return true;
}

stock bool:ShowCamEditorArrows(playerid) {
	Text_Arrows[playerid][0] = CreatePlayerTextDraw(playerid, 420.000, 323.000, "LD_BEAT:cring");
	PlayerTextDrawTextSize(playerid, Text_Arrows[playerid][0], 30.000, 39.000);
	PlayerTextDrawAlignment(playerid, Text_Arrows[playerid][0], 1);
	PlayerTextDrawColor(playerid, Text_Arrows[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, Text_Arrows[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, Text_Arrows[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, Text_Arrows[playerid][0], 255);
	PlayerTextDrawFont(playerid, Text_Arrows[playerid][0], 4);
	PlayerTextDrawSetProportional(playerid, Text_Arrows[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, Text_Arrows[playerid][0], 1);
	
	Text_Arrows[playerid][1] = CreatePlayerTextDraw(playerid, 419.000, 252.000, "LD_BEAT:up");
	PlayerTextDrawTextSize(playerid, Text_Arrows[playerid][1], 30.000, 42.000);
	PlayerTextDrawAlignment(playerid, Text_Arrows[playerid][1], 1);
	PlayerTextDrawColor(playerid, Text_Arrows[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, Text_Arrows[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, Text_Arrows[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, Text_Arrows[playerid][1], 255);
	PlayerTextDrawFont(playerid, Text_Arrows[playerid][1], 4);
	PlayerTextDrawSetProportional(playerid, Text_Arrows[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, Text_Arrows[playerid][1], 1);
	
	Text_Arrows[playerid][2] = CreatePlayerTextDraw(playerid, 454.000, 287.000, "LD_BEAT:right");
	PlayerTextDrawTextSize(playerid, Text_Arrows[playerid][2], 32.000, 43.000);
	PlayerTextDrawAlignment(playerid, Text_Arrows[playerid][2], 1);
	PlayerTextDrawColor(playerid, Text_Arrows[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, Text_Arrows[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, Text_Arrows[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, Text_Arrows[playerid][2], 255);
	PlayerTextDrawFont(playerid, Text_Arrows[playerid][2], 4);
	PlayerTextDrawSetProportional(playerid, Text_Arrows[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, Text_Arrows[playerid][2], 1);
	
	Text_Arrows[playerid][3] = CreatePlayerTextDraw(playerid, 384.000, 290.000, "LD_BEAT:left");
	PlayerTextDrawTextSize(playerid, Text_Arrows[playerid][3], 30.000, 41.000);
	PlayerTextDrawAlignment(playerid, Text_Arrows[playerid][3], 1);
	PlayerTextDrawColor(playerid, Text_Arrows[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, Text_Arrows[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, Text_Arrows[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, Text_Arrows[playerid][3], 255);
	PlayerTextDrawFont(playerid, Text_Arrows[playerid][3], 4);
	PlayerTextDrawSetProportional(playerid, Text_Arrows[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, Text_Arrows[playerid][3], 1);
	
	Text_Arrows[playerid][4] = CreatePlayerTextDraw(playerid, 530.000, 124.000, "MUDAR MODO");
	PlayerTextDrawLetterSize(playerid, Text_Arrows[playerid][4], 0.290, 1.600);
	PlayerTextDrawTextSize(playerid, Text_Arrows[playerid][4], 596.000, 307.000);
	PlayerTextDrawAlignment(playerid, Text_Arrows[playerid][4], 1);
	PlayerTextDrawColor(playerid, Text_Arrows[playerid][4], -6259969);
	PlayerTextDrawSetShadow(playerid, Text_Arrows[playerid][4], 1);
	PlayerTextDrawSetOutline(playerid, Text_Arrows[playerid][4], 1);
	PlayerTextDrawBackgroundColor(playerid, Text_Arrows[playerid][4], 0);
	PlayerTextDrawFont(playerid, Text_Arrows[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, Text_Arrows[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, Text_Arrows[playerid][4], 1);
	
	Text_Arrows[playerid][5] = CreatePlayerTextDraw(playerid, 530.000, 152.000, "VELOCIDADE");
	PlayerTextDrawLetterSize(playerid, Text_Arrows[playerid][5], 0.290, 1.600);
	PlayerTextDrawTextSize(playerid, Text_Arrows[playerid][5], 587.000, 309.000);
	PlayerTextDrawAlignment(playerid, Text_Arrows[playerid][5], 1);
	PlayerTextDrawColor(playerid, Text_Arrows[playerid][5], -6259969);
	PlayerTextDrawSetShadow(playerid, Text_Arrows[playerid][5], 1);
	PlayerTextDrawSetOutline(playerid, Text_Arrows[playerid][5], 1);
	PlayerTextDrawBackgroundColor(playerid, Text_Arrows[playerid][5], 0);
	PlayerTextDrawFont(playerid, Text_Arrows[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, Text_Arrows[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, Text_Arrows[playerid][5], 1);
	
	Text_Arrows[playerid][6] = CreatePlayerTextDraw(playerid, 530.000, 178.000, "SALVAR");
	PlayerTextDrawLetterSize(playerid, Text_Arrows[playerid][6], 0.290, 1.600);
	PlayerTextDrawTextSize(playerid, Text_Arrows[playerid][6], 569.000, 288.000);
	PlayerTextDrawAlignment(playerid, Text_Arrows[playerid][6], 1);
	PlayerTextDrawColor(playerid, Text_Arrows[playerid][6], -6259969);
	PlayerTextDrawSetShadow(playerid, Text_Arrows[playerid][6], 1);
	PlayerTextDrawSetOutline(playerid, Text_Arrows[playerid][6], 1);
	PlayerTextDrawBackgroundColor(playerid, Text_Arrows[playerid][6], 0);
	PlayerTextDrawFont(playerid, Text_Arrows[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, Text_Arrows[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, Text_Arrows[playerid][6], 1);
	return true;
}

stock bool:ShowTextArrows(playerid) {
  ShowCamEditorArrows(playerid);
  for(new l; l < 7; l++) {
    PlayerTextDrawShow(playerid, Text_Arrows[playerid][l]);
  }
  return true;
}

stock bool:HideTextArrows(playerid) {
    for (new l = 0; l < 7; l++) { 
      PlayerTextDrawHide(playerid, Text_Arrows[playerid][l]);
    }
    return true;
}

CMD:cameditor(playerid) {
    IsCamEditorActive[playerid] = true;
    IsAdjustingLook[playerid] = false;

    GetPlayerCameraPos(playerid, CamX[playerid], CamY[playerid], CamZ[playerid]);
    GetPlayerCameraFrontVector(playerid, CamLookX[playerid], CamLookY[playerid], CamLookZ[playerid]);
    ShowTextArrows(playerid);
    SendClientMessage(playerid, -1, "{3CB371}CamEditor{FFFFFF}: Seja bem-vindo(a) ao cameditor!");
    return true;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid) {
    if(!IsCamEditorActive[playerid]) return 0;

    if(playertextid == Text_Arrows[playerid][4]) {
        IsAdjustingLook[playerid] = !IsAdjustingLook[playerid];
        SendClientMessage(playerid, -1, IsAdjustingLook[playerid] ?
            "{3CB371}CamEditor{FFFFFF}: Modo: Ajustar Olhar" :
            "{3CB371}CamEditor{FFFFFF}: Modo: Mover Camera");
        return true;
    }

    if(playertextid == Text_Arrows[playerid][6]) {
        SaveCamPosition(playerid);
        SendClientMessage(playerid, -1, "{3CB371}CamEditor{FFFFFF}: Posicao de camera salva!");
        return true;
    }

    if(playertextid == Text_Arrows[playerid][5]) {
        ShowPlayerDialog(playerid, DIALOG_CAM_SPEED, DIALOG_STYLE_LIST, "{3CB371}CamEditor{FFFFFF} Velocidade", 
            "0.5\n1.0\n2.0\n5.0", "Selecionar", "Cancelar");
        return true;
    }

    if(playertextid == Text_Arrows[playerid][1]) {
        if(IsAdjustingLook[playerid])
            CamLookZ[playerid] += CamSpeed[playerid];
        else
            CamZ[playerid] += CamSpeed[playerid];
    }
    else if(playertextid == Text_Arrows[playerid][0]) {
        if(IsAdjustingLook[playerid])
            CamLookZ[playerid] -= CamSpeed[playerid];
        else
            CamZ[playerid] -= CamSpeed[playerid];
    }
    else if(playertextid == Text_Arrows[playerid][2]) {
        if(IsAdjustingLook[playerid])
            CamLookX[playerid] += CamSpeed[playerid];
        else
            CamX[playerid] += CamSpeed[playerid];
    }
    else if(playertextid == Text_Arrows[playerid][3]) {
        if(IsAdjustingLook[playerid])
            CamLookX[playerid] -= CamSpeed[playerid];
        else
            CamX[playerid] -= CamSpeed[playerid];
    }

    SetPlayerCameraPos(playerid, CamX[playerid], CamY[playerid], CamZ[playerid]);
    SetPlayerCameraLookAt(playerid, CamLookX[playerid], CamLookY[playerid], CamLookZ[playerid]);
    return true;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
    if(dialogid == DIALOG_CAM_SPEED && response) {
        new Float:speeds[] = {0.5, 1.0, 2.0, 5.0};
        if(listitem >= 0 && listitem < sizeof(speeds)) {
            CamSpeed[playerid] = speeds[listitem];
            new msg[64];
            format(msg, sizeof(msg), "{3CB371}CamEditor{FFFFFF}: Velocidade ajustada para %.1f", CamSpeed[playerid]);
            SendClientMessage(playerid, -1, msg);
        }
        return true;
    }
    return 0;
}

stock SaveCamPosition(playerid) {
    new File:file = fopen("cameditor_positions.txt", io_append);
    if(file) {
        new string[256];
        format(string, sizeof(string), "SetPlayerCameraPos(playerid, %f, %f, %f);\r\nSetPlayerCameraLookAt(playerid, %f, %f, %f);\r\n\r\n",
            CamX[playerid], CamY[playerid], CamZ[playerid],
            CamLookX[playerid], CamLookY[playerid], CamLookZ[playerid]);
        fwrite(file, string);
        fclose(file);
    }
}