import { delay } from './utils';
import { config } from '../../config.js';

class Main {
    public esx: any;

    constructor() {
        this.esx = global.exports['es_extended'].getSharedObject()
    }

    public async createNPC() {
        const model = GetHashKey(config.npc.model);

        RequestModel(model);
        while (!HasModelLoaded(model)) {
            await delay(1);
        }

        const location = { x: config.npc.position.x, y: config.npc.position.y, z: config.npc.position.z - 1, w: config.npc.position.w };

        const ped = CreatePed(4, model, location.x, location.y, location.z, location.w, false, true);

        SetEntityInvincible(ped, true);
        SetEntityHasGravity(ped, false);
        FreezeEntityPosition(ped, true);
        SetPedAlertness(ped, 0);
        SetPedCanRagdoll(ped, false);
        SetPedCanBeTargetted(ped, false);
        SetPedFleeAttributes(ped, 0, false);
        SetPedDropsWeaponsWhenDead(ped, false);
        SetPedCombatAttributes(ped, 46, false);
        SetPedIsDrunk(ped, true);

        SetModelAsNoLongerNeeded(model);
    }
}

