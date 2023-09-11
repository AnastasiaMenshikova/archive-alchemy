import { DollarCircleOutlined } from "@ant-design/icons";
import { RampInstantSDK } from "@ramp-network/ramp-instant-sdk";
import { Button, Divider, Modal } from "antd";
import React, { useState } from "react";

// added display of 0 if price={price} is not provided

/*
  ~ What it does? ~

  Displays current ETH price and gives options to buy ETH through Wyre/Ramp/Coinbase
                            or get through Rinkeby/Ropsten/Kovan/Goerli

  ~ How can I use? ~

  <Ramp
    price={price}
    address={address}
  />

  ~ Features ~

  - Ramp opens directly in the application, component uses RampInstantSDK
  - Provide price={price} and current ETH price will be displayed
  - Provide address={address} and your address will be pasted into Wyre/Ramp instantly
*/

export default function Ramp(props) {
  const [modalUp, setModalUp] = useState("down");

  const type = "default";

  const allFaucets = [];
  for (const n in props.networks) {
    if (props.networks[n].chainId !== 31337 && props.networks[n].chainId !== 1) {
      allFaucets.push(
        <p key={props.networks[n].chainId}>
          <Button
            style={{ color: props.networks[n].color }}
            type={type}
            size="large"
            shape="round"
            onClick={() => {
              window.open(props.networks[n].faucet);
            }}
          >
            {props.networks[n].name}
          </Button>
        </p>,
      );
    }
  }

  return (
    <div>
      <Button
        size="large"
        shape="round"
        onClick={() => {
          setModalUp("up");
        }}
      >
        <DollarCircleOutlined style={{ color: "#52c41a" }} />{" "}
        {typeof props.price === "undefined" ? 0 : props.price.toFixed(2)}
      </Button>
      <Modal
        title="Testnet ETH"
        visible={modalUp === "up"}
        onCancel={() => {
          setModalUp("down");
        }}
        footer={[
          <Button
            key="back"
            onClick={() => {
              setModalUp("down");
            }}
          >
            cancel
          </Button>,
        ]}
      >

        {allFaucets}
      </Modal>
    </div>
  );
}