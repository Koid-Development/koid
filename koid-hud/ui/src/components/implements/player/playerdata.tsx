import React, {useState} from "react";
import {fetchNui} from "../../../utils/fetchNui";
import "./playerdata.css";

interface ReturnData {
  job: string;
  jobGrade: string;
  money: number;
  bank: number;
  blackMoney: number;
  id: number;
}

const Playerdata: React.FC = () => {
  const [playerData, setPlayerData] = useState<ReturnData | null>(null);

  fetchNui<ReturnData>("playerData")
      .then((data) => {
        setPlayerData(data);
      })
      .catch((err) => {
        setPlayerData({
          job: "Test",
          jobGrade: "Master Test",
          money: 100000,
          bank: 100000,
          blackMoney: 100000,
          id: 1
        });
      });

  let a: number = 1000000;

  return (
      <div id="playerdata">
        <div id="money">
          <div id="bank">
            <div className="as">
              <i className='fa-duotone fa-landmark-dome'></i>
            </div>
            <span>{playerData?.bank.toLocaleString()}</span>
          </div>
          <div id="cash">
            <div className="as">
              <i className='fa-duotone fa-money-bills'></i>
            </div>
            <span>{playerData?.money.toLocaleString()}</span>
          </div>
          <div id="blackMoney">
            <div className="as">
              <i className='fa-duotone fa-sack-xmark'></i>
            </div>
            <span>{playerData?.blackMoney.toLocaleString()}</span>
          </div>
          <div id="coins">
            <div className="as">
              <i className='fa-duotone fa-coin'></i>
            </div>
            <span>{a.toLocaleString()}</span>
          </div>
        </div>
      </div>
  );
};

export default Playerdata;
