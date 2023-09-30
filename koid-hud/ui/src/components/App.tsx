import React from "react";
import "./App.css";
import {debugData} from "../utils/debugData";
import Status from "./implements/status/status";
import Jobs from "./implements/jobs/jobs";
import Playerdata from "./implements/player/playerdata";


setTimeout(() => {
  debugData([
    {
      action: "updatePlayerJobs",
      data: {
        jobs: {
          ems: 1,
          police: 1,
          mechanic: 1,
          tendero: 1,
          taxi: 1,
          players: 1,
        }
      },
    },
  ]);

  debugData([
    {
      action: "updatePlayerList",
      data: {
        id: 1,
        name: "Test",
      },
    },
  ]);

  debugData([
    {
      action: "status",
      data: {
        status: {
          health: 100,
          shield: 50,
          hunger: 20,
          thirst: 70,
        },
        isPedOnVehicle: false,
      },
    },
  ]);

  debugData([
    {
      action: "playerData",
      data: {
        job: "Test",
        jobGrade: "Master Test",
        money: 1000000,
        bank: 1000000,
        blackMoney: 1000000,
        id: 1
      }
    }
  ]);
}, 3000);



const App: React.FC = () => {
  return (
      <>
        <Status/>
        <Jobs/>
        <Playerdata/>
      </>
  );
};

export default App;
