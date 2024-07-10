# Home Assistant AddOn Modbus Proxy
 
Usally one modbus server only allows a single connection and denies any more clients. 
With this Addon you can create a proxy which can handle mutiple client connections at the same time. 
Currently you can configure the Addon to establish a connection to three different Modbus Servers and provide the information to multiple clients through the respective listenport.

The addon is only tested and compatible with hassio supervisor. 

## Installation
[![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2FTCzerny%2Fha-modbusproxy)
- Add This [Repository](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2FTCzerny%2Fha-modbusproxy) (Or click Button above)
- Install ModBusProxy from the Add-On Store

## Configuration
- Stop all Clients that currently connect to the modbus servers. The Server might need some time before another client (our proxy) can connect.
  - In case you are using solaredge-modbus in homeassistant you can change the server address here: /config/.storage/core.config_entries. 
- Before starting go to the configuration page and set the ip of your modbus server. 
- Start The Add-On (This may take a while on the first start as it builds the cointainer locally)
- Configure Your Clients to connect to your HA IP and choosen listenport.

### Configuration Tab
<img width="774" alt="config" src="https://github.com/TCzerny/ha-modbusproxy/assets/13466867/2f512819-d9fd-4a90-a0ed-2a3eafcd0c4c">
<img width="778" alt="network" src="https://github.com/TCzerny/ha-modbusproxy/assets/13466867/37fb14b1-3910-401e-84e9-a9d934a8a3d4">


## Mentions
This addon is a fork from the original addon of Akulatraxas
- https://github.com/Akulatraxas/ha-modbusproxy

This addon uses the modbus-proxy of tiagocoutinho:
- https://github.com/tiagocoutinho/modbus-proxy
