import React, {useState} from "react";
import {fetchNui} from "../../../utils/fetchNui";
import "./jobs.css";

interface JobsData {
  jobs: {
    ems: number;
    police: number;
    mechanic: number;
    tendero: number;
    taxi: number;
    players: number;
  };
}

interface PlayerData {
  id: number;
  name: string;
}

const Jobs: React.FC = () => {
  const [jobsData, setJobsData] = useState<JobsData | null>(null);
  const [playerData, setPlayerData] = useState<PlayerData | null>(null);

  fetchNui<JobsData>("updatePlayerJobs")
      .then((data) => {
        setJobsData(data);
      })
      .catch((err) => {
        setJobsData({
          jobs: {
            ems: 1,
            police: 1,
            mechanic: 1,
            tendero: 1,
            taxi: 1,
            players: 1,
          },
        });
      });

  fetchNui<PlayerData>("updatePlayerList")
      .then((data) => {
        setPlayerData(data);
      })
      .catch((err) => {
        setPlayerData({
          id: 1,
          name: "Test",
        });
      });

  return (
      <div id="jobs">
        <div className="id">
          <i className="fa-duotone fa-id-card"></i>
          <span id="id">{playerData?.id}</span>
        </div>
        <div className="counter">
          <i className="fa-duotone fa-user-police-tie"></i>
          <span id="policecounter">{jobsData?.jobs.police}</span>
        </div>
        <div className="counter">
          <i className="fa-duotone fa-user-nurse-hair-long"></i>
          <span id="ambulancecounter">{jobsData?.jobs.ems}</span>
        </div>
        <div className="counter">
          <i className="fa-duotone fa-screwdriver"></i>
          <span id="mechaniccounter">{jobsData?.jobs.mechanic}</span>
        </div>
        <div className="counter">
          <i className="fa-duotone fa-store"></i>
          <span id="tenderocounter">{jobsData?.jobs.tendero}</span>
        </div>
        <div className="counter">
          <i className="fa-duotone fa-taxi"></i>
          <span id="taxicounter">{jobsData?.jobs.taxi}</span>
        </div>
        <div className="counter count">
          <i className="fa-duotone fa-users"></i>
          <span id="playerscounter">{jobsData?.jobs.players}</span>
        </div>
      </div>
  );
};

export default Jobs;
