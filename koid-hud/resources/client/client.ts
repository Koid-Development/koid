// Start coding!
const ESX: any = global.exports['es_extended'].getSharedObject();

import {delay} from './utils';

setTick(async () => {
  let hunger = 0, thirst = 0;

  while (true) {
    emit('esx_status:getStatus', 'hunger', function (hunger: { getPercent: () => any; }) {
      this.hunger = hunger.getPercent();
    });

    emit('esx_status:getStatus', 'thirst', function (thirst: { getPercent: () => any; }) {
      this.thirst = thirst.getPercent();
    });

    SendReactMessage('status', {
      status: {
        health: (GetEntityHealth(PlayerPedId()) - 100),
        shield: GetPedArmour(PlayerPedId()),
        hunger: hunger,
        thirst: thirst,
      },
      isPedOnVehicle: IsPedInAnyVehicle(PlayerPedId(), false),
    });

    DisplayRadar(IsPedInAnyVehicle(PlayerPedId(), false));
    await delay(100);
  }
})

function SendReactMessage(action: string, data: any) {
  SendNUIMessage({
    action: action,
    data: data,
  });
}

setTick(async () => {
  ESX.TriggerServerCallback('koid-hud:obtainConnectedPlayers', (connectedPlayers: any) => {
    updatePlayerTable(connectedPlayers);
  });
  await delay(2000);
});

onNet('koid-hud:updateJobs', (connectedPlayers: any) => {
  updatePlayerTable(connectedPlayers);
});

const updatePlayerTable = (connectedPlayers: any[]) => {
  const formattedPlayerList: string[] = [];
  let num = 1;
  let ems = 0, tendero = 0, police = 0, taxi = 0, mechanic = 0, players = 0;

  for (const v of connectedPlayers) {
    if (num === 1) {
      formattedPlayerList.push(`<tr><td></td><td>${v.id}</td><td></td>`);
      num = 2;
    } else if (num === 2) {
      formattedPlayerList.push(`<td></td><td>${v.id}</td><td></td></tr>`);
      num = 1;
    }
    players++;
    switch (v.job) {
      case 'ambulance':
        ems++;
        break;
      case 'police':
        police++;
        break;
      case 'taxi':
        taxi++;
        break;
      case 'tendero':
        tendero++;
        break;
      case 'mechanic':
        mechanic++;
        break;
    }
  }

  if (num === 1) {
    formattedPlayerList.push('</tr>');
  }

  SendNUIMessage({
    action: 'updatePlayerList',
    id: GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))),
    players: formattedPlayerList.join(''),
  });

  SendNUIMessage({
    action: 'updatePlayerJobs',
    jobs: {
      ems: ems,
      police: police,
      mechanic: mechanic,
      tendero: tendero,
      taxi: taxi,
      players: players,
    },
  });
}

onNet('koid-hud:obtainPlayerData', (data: any) => {
  SendReactMessage('playerData', data);
});