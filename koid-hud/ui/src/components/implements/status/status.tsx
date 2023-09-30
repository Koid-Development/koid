import React, {useState} from "react";
import {fetchNui} from "../../../utils/fetchNui";
import "./status.css";

interface ReturnData {
  status: {
    health: number;
    shield: number;
    hunger: number;
    thirst: number;
  };
  isPedOnVehicle: boolean;
}

const Status: React.FC = () => {
  const [clientData, setClientData] = useState<ReturnData | null>(null);

  fetchNui<ReturnData>("status")
      .then((data) => {
        setClientData(data);

        if (data.isPedOnVehicle) {
          $(".hud").css(
              data.isPedOnVehicle ? {left: "16vw"} : {left: "2.5vw"}
          );
        }
      })
      .catch((err) => {
        setClientData({
          status: {
            health: 100,
            shield: 50,
            hunger: 20,
            thirst: 70,
          },
          isPedOnVehicle: false,
        });
      });

  return (
      <div className="hud">
        <div className="container health">
          <div className="icon">
            <i
                className="fa-duotone fa-heart-pulse"
                style={
                  {
                    "--fa-primary-opacity": "0.4",
                    "--fa-secondary-opacity": "1",
                  } as React.CSSProperties
                }
            ></i>
          </div>
          <div className="progress">
            <div
                className="progressLevel healthLevel"
                style={{height: clientData?.status.health}}
            ></div>
          </div>
        </div>
        <div className="container shield">
          <div className="icon">
            <i className="fa-duotone fa-shield-halved"></i>
          </div>
          <div className="progress">
            <div
                className="progressLevel shieldLevel"
                style={{height: clientData?.status.shield}}
            ></div>
          </div>
        </div>
        <div className="container hunger">
          <div className="icon">
            <i className="fa-duotone fa-burger-cheese"></i>
          </div>
          <div className="progress">
            <div
                className="progressLevel hungerLevel"
                style={{height: clientData?.status.hunger}}
            ></div>
          </div>
        </div>
        <div className="container thirst">
          <div className="icon">
            <i className="fa-duotone fa-cup-straw-swoosh"></i>
          </div>
          <div className="progress">
            <div
                className="progressLevel thirstLevel"
                style={{height: clientData?.status.thirst}}
            ></div>
          </div>
        </div>
      </div>
  );
};

export default Status;
