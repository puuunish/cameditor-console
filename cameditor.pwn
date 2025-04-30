// ============================================================
// CamEditor FilterScripts (MOBILE) com TextDraws
// Autor: Punish (ID: 968249958941741087)
// Compiled in: 1:19 Qua, 30/Abr - 2025
// Adaptado com suporte a mover, ajustar olhar e salvar posição
// ============================================================

#include <a_samp> /* OBRIGATÓRIO*/
#include <zcmd> /* OBRIGATÓRIO */

#define CAM_LOOK_MIN_DIFF -10.0
#define CAM_LOOK_MAX_DIFF 10.0
#define DIALOG_SAVE_NAME 2

new
   bool:IsCamEditorActive[MAX_PLAYERS];
new
   bool:IsAdjustingLook[MAX_PLAYERS];

new Float:CamX[MAX_PLAYERS], Float:CamY[MAX_PLAYERS], Float:CamZ[MAX_PLAYERS];
new Float:CamLookX[MAX_PLAYERS], Float:CamLookY[MAX_PLAYERS], Float:CamLookZ[MAX_PLAYERS];
new Float:CamSpeed[MAX_PLAYERS] = 1.0;

new 
   PlayerText:Text_Arrows[MAX_PLAYERS][10];

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
	PlayerTextDrawColor(playerid, Text_Arrows[playerid][4], 1018393087);
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
	PlayerTextDrawColor(playerid, Text_Arrows[playerid][5], 1018393087);
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
	PlayerTextDrawColor(playerid, Text_Arrows[playerid][6], 1018393087);
	PlayerTextDrawSetShadow(playerid, Text_Arrows[playerid][6], 1);
	PlayerTextDrawSetOutline(playerid, Text_Arrows[playerid][6], 1);
	PlayerTextDrawBackgroundColor(playerid, Text_Arrows[playerid][6], 0);
	PlayerTextDrawFont(playerid, Text_Arrows[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, Text_Arrows[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, Text_Arrows[playerid][6], 1);
	
	Text_Arrows[playerid][7] = CreatePlayerTextDraw(playerid, 530.000, 206.000, "FECHAR");
	PlayerTextDrawLetterSize(playerid, Text_Arrows[playerid][7], 0.290, 1.600);
	PlayerTextDrawTextSize(playerid, Text_Arrows[playerid][7], 569.000, 288.000);
	PlayerTextDrawAlignment(playerid, Text_Arrows[playerid][7], 1);
	PlayerTextDrawColor(playerid, Text_Arrows[playerid][7], 1018393087);
	PlayerTextDrawSetShadow(playerid, Text_Arrows[playerid][7], 1);
	PlayerTextDrawSetOutline(playerid, Text_Arrows[playerid][7], 1);
	PlayerTextDrawBackgroundColor(playerid, Text_Arrows[playerid][7], 0);
	PlayerTextDrawFont(playerid, Text_Arrows[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, Text_Arrows[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, Text_Arrows[playerid][7], 1);
	
	Text_Arrows[playerid][8] = CreatePlayerTextDraw(playerid, 460.000, 224.000, "LD_BEAT:upr");
	PlayerTextDrawTextSize(playerid, Text_Arrows[playerid][8], 29.000, 42.000);
	PlayerTextDrawAlignment(playerid, Text_Arrows[playerid][8], 1);
	PlayerTextDrawColor(playerid, Text_Arrows[playerid][8], -1);
	PlayerTextDrawSetShadow(playerid, Text_Arrows[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, Text_Arrows[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, Text_Arrows[playerid][8], 255);
	PlayerTextDrawFont(playerid, Text_Arrows[playerid][8], 4);
	PlayerTextDrawSetProportional(playerid, Text_Arrows[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, Text_Arrows[playerid][8], 1);
	
	Text_Arrows[playerid][9] = CreatePlayerTextDraw(playerid, 376.000, 348.000, "LD_BEAT:downl");
	PlayerTextDrawTextSize(playerid, Text_Arrows[playerid][9], 30.000, 44.000);
	PlayerTextDrawAlignment(playerid, Text_Arrows[playerid][9], 1);
	PlayerTextDrawColor(playerid, Text_Arrows[playerid][9], -1);
	PlayerTextDrawSetShadow(playerid, Text_Arrows[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, Text_Arrows[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, Text_Arrows[playerid][9], 255);
	PlayerTextDrawFont(playerid, Text_Arrows[playerid][9], 4);
	PlayerTextDrawSetProportional(playerid, Text_Arrows[playerid][9], 1);
	PlayerTextDrawSetSelectable(playerid, Text_Arrows[playerid][9], 1);
	return true;
}

stock bool:ShowTextArrows(playerid) {
  ShowCamEditorArrows(playerid);
  for(new l; l < 10; l++) {
    PlayerTextDrawShow(playerid, Text_Arrows[playerid][l]);
  }
  return true;
}

stock bool:HideTextArrows(playerid) {
    for (new l = 0; l < 10; l++) { 
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
        ShowPlayerDialog(playerid, DIALOG_SAVE_NAME, DIALOG_STYLE_INPUT, "{3CB371}CamEditor{FFFFFF}: Nome do ponto", "Digite um nome para esta posicao:", "Salvar", "Cancelar");
        return true;
    }

    if(playertextid == Text_Arrows[playerid][5]) {
        ShowPlayerDialog(playerid, DIALOG_CAM_SPEED, DIALOG_STYLE_LIST, "{3CB371}CamEditor{FFFFFF} Velocidade", 
            "0.5\n1.0\n2.0\n5.0", "Selecionar", "Cancelar");
        return true;
    }

    if(playertextid == Text_Arrows[playerid][1]) {
        if(IsAdjustingLook[playerid]) {
            if(CamLookZ[playerid] - CamZ[playerid] < CAM_LOOK_MAX_DIFF)
                CamLookZ[playerid] += CamSpeed[playerid];
        } else {
            CamZ[playerid] += CamSpeed[playerid];
        }
    } else if(playertextid == Text_Arrows[playerid][0]) {
        if(IsAdjustingLook[playerid]) {
            if(CamLookZ[playerid] - CamZ[playerid] > CAM_LOOK_MIN_DIFF)
                CamLookZ[playerid] -= CamSpeed[playerid];
        } else {
            CamZ[playerid] -= CamSpeed[playerid];
        }
    } else if(playertextid == Text_Arrows[playerid][2]) {
        if(IsAdjustingLook[playerid]) {
            CamLookX[playerid] += CamSpeed[playerid];
        } else {
            new Float:dirX, Float:dirY;
            dirX = CamLookY[playerid] - CamY[playerid];
            dirY = -(CamLookX[playerid] - CamX[playerid]);

            new Float:length = floatsqroot(dirX * dirX + dirY * dirY);
            if(length > 0.0) {
                dirX /= length;
                dirY /= length;
                CamX[playerid] += dirX * CamSpeed[playerid];
                CamY[playerid] += dirY * CamSpeed[playerid];
                CamLookX[playerid] += dirX * CamSpeed[playerid];
                CamLookY[playerid] += dirY * CamSpeed[playerid];
            }
        }
    } else if(playertextid == Text_Arrows[playerid][3]) {
        if(IsAdjustingLook[playerid]) {
            CamLookX[playerid] -= CamSpeed[playerid];
        } else {
            new Float:dirX, Float:dirY;
            dirX = CamLookY[playerid] - CamY[playerid];
            dirY = -(CamLookX[playerid] - CamX[playerid]);

            new Float:length = floatsqroot(dirX * dirX + dirY * dirY);
            if(length > 0.0) {
                dirX /= length;
                dirY /= length;
                CamX[playerid] -= dirX * CamSpeed[playerid];
                CamY[playerid] -= dirY * CamSpeed[playerid];
                CamLookX[playerid] -= dirX * CamSpeed[playerid];
                CamLookY[playerid] -= dirY * CamSpeed[playerid];
            }
        }
    } else if(playertextid == Text_Arrows[playerid][7]) {
        if(!IsCamEditorActive[playerid]) {
            SendClientMessage(playerid, -1, "{B22222}CamEditor: Voce nao esta no modo editor.");
            return true;
        }

        IsCamEditorActive[playerid] = false;
        IsAdjustingLook[playerid] = false;

        SetCameraBehindPlayer(playerid);
        HideTextArrows(playerid);
        SendClientMessage(playerid, -1, "{3CB371}CamEditor{FFFFFF}: Editor de camera encerrado.");
    } else if(playertextid == Text_Arrows[playerid][8]) {
      CamX[playerid] += CamLookX[playerid] * CamSpeed[playerid];
      CamY[playerid] += CamLookY[playerid] * CamSpeed[playerid];
      CamZ[playerid] += CamLookZ[playerid] * CamSpeed[playerid];
    } else if(playertextid == Text_Arrows[playerid][9]) {
      CamX[playerid] -= CamLookX[playerid] * CamSpeed[playerid];
      CamY[playerid] -= CamLookY[playerid] * CamSpeed[playerid];
      CamZ[playerid] -= CamLookZ[playerid] * CamSpeed[playerid];
    }

    if(IsCamEditorActive[playerid]) {
      SetPlayerCameraPos(playerid, CamX[playerid], CamY[playerid], CamZ[playerid]);
      SetPlayerCameraLookAt(playerid, CamLookX[playerid], CamLookY[playerid], CamLookZ[playerid]);
    }
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
    if(dialogid == DIALOG_SAVE_NAME && response) {
      if(strlen(inputtext) > 0) {
        SaveCamPosition(playerid, inputtext);
        new msg[96];
        format(msg, sizeof(msg), "{3CB371}CamEditor{FFFFFF}: Posicao salva como '%s'", inputtext);
        SendClientMessage(playerid, -1, msg);
      } else {
        SendClientMessage(playerid, -1, "{B22222}Erro: Nome inválido.");
      }
      return true;
    }
    return 0;
}

stock SaveCamPosition(playerid, name[]) {
    new File:file = fopen("cameditor_positions.txt", io_append);
    if(file) {
        new string[256];
        format(string, sizeof(string), "SetPlayerCameraPos(playerid, %f, %f, %f);\r\nSetPlayerCameraLookAt(playerid, %f, %f, %f); // %s\r\n\r\n",
        CamX[playerid], CamY[playerid], CamZ[playerid],
        CamLookX[playerid], CamLookY[playerid], CamLookZ[playerid], name);
        fwrite(file, string);
        fclose(file);
    }
}