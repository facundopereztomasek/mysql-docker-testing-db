# Dockerized MySQL database for testing purposes

## Install docker compose

First step is to install docker-compose. You can read the official documentation here: [https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/)

Make sure you are reading the instructions corresponding to your operative system.

Docker is like a virtual machine (containers), separated in layers (images) to reuse them when they are shared between different proyects.
You will be running your mysql instance inside this container, so you can alter and break down your testing database without being worried.

## Run docker compose

Open a new terminal window. For macosx and linux you can open the terminal application. For windows you have to open the Command Prompt or PowerShell application.

Placed in **this directory** run

```sh
docker-compose build
```

It will read the docker-compose.yml file and build up the containers described in it and start them as services. There is only one container so you have only the database service running.
This docker-compose.yml file uses an image that is not hosted, it is described locally in a dockerfile named mysql.dockerfile. Docker will run this mysql.dockerfile and build the image so the docker-compose could start it as a service.
The mysql.dockerfile tells docker to download the mysql image (this is hosted on dockerhub: https://hub.docker.com/_/mysql) and creates some configuration scripts to set the corresponding permissions to the root database user to allow connections from outside the container, that is, your machine.

Once all of these finishes running you will be able to run

```sh
docker-compose up
```

This command will start the database service described in the docker-compose.yml and will listen to the 3309 port. MySQL databases listens to the 3306 port by default. I changed it to 3309 to avoid collisioning with another database services running on your host machine, either to avoid you to be playing with the wrong database.

You have to wait until the database is ready to receive incomming connections.

You are ready when you can read
```sh
database_1  | 2019-10-12T18:03:57.942659Z 0 [System] [MY-010931] [Server] /usr/sbin/mysqld: ready for connections. Version: '8.0.17'  socket: '/var/run/mysqld/mysqld.sock'  port: 3306  MySQL Community Server - GPL.
```

## Testing the connection

In order to test the connection you have configure a new connection in your preferred MySQL GUI (Graphical User Interface). You can search on the internet. A briefly list of database clients are:
- Navicat (macosx - windows - linux)
- Sequel Pro (macosx)
- Workbench (macosx - windows - linux)
- Emma (linux)

Here is the configuration you need to apply to create the connection:

| Property    | Value  | Notes  |
| - | - | - |
| Connection name    | testing-dockerized-database  | You can name it as you want, but be sure you name it with a very descriptive text   |
| Host    | 127.0.0.1  | Your machine. Do not use localhost since it will use your local sock file   |
| Port    | 3309  | The port exposed by the database dockerized service |
| Database (name)    | testing-db  | The default created database. Here you can leave it blank or put another database you have created |
| User | root | The user we will use to be connected to the database |
| Password | testing-db-password | The root mysql user's password |

That is all! Now you are able to connecto to this database and play with it!