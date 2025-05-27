# Home Assistant AddOn Modbus Proxy
 
Usally one modbus server only allows a single connection and denies any more clients. 
With this Addon you can create a proxy which can handle mutiple client connections at the same time. 
Currently you can configure the Addon to establish a connection to three different Modbus Servers and provide the information to multiple clients through the respective listenport.
Additionaly you can configure filters, so supress non standard modbus pushes from servers.

The addon is only tested and compatible with hassio supervisor. 

## Installation
[![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fuk05de%2Fha-modbusproxy)
- Add This [Repository](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fuk05de%2Fha-modbusproxy) (Or click Button above)
- Install ModBusProxy from the Add-On Store

## Configuration
- Stop all Clients that currently connect to the modbus servers. The Server might need some time before another client (our proxy) can connect.
  - In case you are using solaredge-modbus in homeassistant you can change the server address here: /config/.storage/core.config_entries. 
- Before starting go to the configuration page and set the ip of your modbus server and define filters if needed. 
- Start The Add-On (This may take a while on the first start as it builds the cointainer locally)
- Configure Your Clients to connect to your HA IP and choosen listenport.

## Mentions
This addon is a fork from TCzerny which was forked from the original addon of Akulatraxas
- https://github.com/TCzerny/ha-modbusproxy
- https://github.com/Akulatraxas/ha-modbusproxy

This addon uses the modbus-proxy of tiagocoutinho:
- https://github.com/tiagocoutinho/modbus-proxy
