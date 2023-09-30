const ESX = global.exports['es_extended'].getSharedObject();
const connectedPlayers: { [playerId: number]: { id: number; job: string } } = {};

ESX.RegisterServerCallback('koid-hud:obtainConnectedPlayers', (source: number, cb: Function) => {
  cb(connectedPlayers);
});

on('esx:setJob', (playerId: number, job: any, lastJob: any) => {
  connectedPlayers[playerId].job = job.name;
  emit('koid-hud:updateJobs', -1, connectedPlayers);
});

on('esx:playerLoaded', (playerId: number, xPlayer: any) => {
  AddPlayerToScoreboard(xPlayer, true);
});

on('esx:playerDropped', (playerId: number) => {
  connectedPlayers[playerId] = undefined;
  emit('koid-hud:updateJobs', -1, connectedPlayers);
});

onNet('onResourceStart', (resource: string) => {
  if (resource === GetCurrentResourceName()) {
    setTimeout(() => {
      AddPlayersToScoreboard();
    }, 1000);
  }
});

function AddPlayerToScoreboard(xPlayer: any, update: boolean) {
  const playerId = xPlayer.source;
  connectedPlayers[playerId] = {
    id: playerId,
    job: xPlayer.job.name,
  };
  if (update) {
    emit('koid-hud:updateJobs', -1, connectedPlayers);
  }
  setTimeout(() => {
    emit('OnlineJobs:toggleID', playerId, false);
  }, 3000);
}

function AddPlayersToScoreboard() {
  const players = ESX.GetPlayers();
  for (const playerId of players) {
    const xPlayer = ESX.GetPlayerFromId(playerId);
    AddPlayerToScoreboard(xPlayer, false);
  }
  emit('koid-hud:updateJobs', -1, connectedPlayers);
}

on('koid-hud:playerInfo', (playerId: number) => {
  let player = ESX.GetPlayerFromId(playerId);
  if (player != null) {
    let job, blackMoney, money, bank;

    if (player.job.name === player.job.grade_label) {
      job = player.job.name;
    } else {
      job = `${player.job.name} - ${player.job.grade_label}`;
    }

    let data = {
      job: job,
      blackMoney: player.getAccount('black_money').money,
      money: player.getMoney(),
      bank: player.getAccount('bank').money,
      id: playerId
    };

    emit('koid-hud:obtainPlayerData', playerId, data);
  }
});
