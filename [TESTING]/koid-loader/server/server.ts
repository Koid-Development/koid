import express, {Response} from 'express';
import fetch from "node-fetch";
import * as amqp from 'amqplib';
import axios from "axios";
import * as child_process from "child_process";

const config = require('../config.js');

const app = express();
const port = config.port;

class RabbitService {
    public connection: amqp.Connection | null = null;
    public channel: amqp.Channel | null = null;

    constructor() {
        this.connect()
            .then(() => console.log('Connected to RabbitMQ'))
            .catch((err) => console.error(err));
    }

    async connect(): Promise<void> {
        this.connection = await amqp.connect('amqp://user:contraseña@ip:puerto/');
        this.channel = await this.connection.createChannel();

        const exchangeName = 'default';
        await this.channel.assertExchange(exchangeName, 'fanout', {durable: false});
    }
}

class Loader {
    public rabbit: RabbitService;

    constructor() {
        this.rabbit = new RabbitService();

        console.log("-------------------------------------------------");
        console.log(" ")
        console.log("Koid Loader");
        console.log(" ")
    }

    public async load(): Promise<void> {
        for (const key of Object.keys(config.licenses)) {
            const value = config.licenses[key];

            try {
                const url = 'https://koid.tech/api/client';
                const licenseKey = value;
                const product = key;
                const apiKey = 'sdfin';

                const res = await axios.post(
                    url, {licenseKey, product}, {headers: {Authorization: apiKey}}
                );

                if (!res.data.status_code || !res.data.status_id) {
                    console.log(" |- Your license is invalid.")
                    console.log("-------------------------------------------------");
                    return process.exit(1)
                }

                if (res.data.status_overview !== "success") {
                    console.log(" |- Your license is invalid.")
                    console.log(" ")
                    console.log(" |- Reason: " + res.data.status_msg);
                    console.log(" |- Status Code: \x1b[31m" + res.data.status_code + "\x1b[0m");
                    console.log("-------------------------------------------------");
                    return process.exit(1);
                } else {
                    console.log(` |- License has been validated. [${res.data.clientname || '\x1b[31mUnknown\x1b[0m'}]`);
                    console.log(" ")
                    console.log(" |- Discord ID: " + res.data.discord_id);
                    console.log(" |- Status Code: \x1b[32m" + res.data.status_code + "\x1b[0m");
                    console.log(` |- Version: \x1b[33m$1.0.0\x1b[0m/\x1b[32m${res.data.version}\x1b[0m`);
                    console.log("-------------------------------------------------");

                    const message = JSON.stringify({
                        ip: "",
                        plugin: key,
                    });

                    this.rabbit.channel.publish('default', '', Buffer.from(message));

                    this.haveAccess(key).then((res) => {
                        StartResource("ka");
                    }).catch((err) => {
                        console.error(err);
                    });
                }
            } catch (error) {
                console.log("Authentication failed")
                console.log(error)
                process.exit(1)
            }
        }
    }

    getDownloadURL(plugin: string): string {
        let link = '';
        switch (plugin.toLowerCase()) {
            case 'test1':
                link = 'http://koid.tech:8165/plugins?plugin=test1';
                break;
            case 'test2':
                link = 'http://koid.tech:8165/plugins?plugin=test2';
                break;
            default:
                console.error('Plugin not found')
                console.error('Plugin not found')
                console.error('Plugin not found')
                console.error('Plugin not found')
                console.error('Plugin not found')
        }
        return link;
    }

    public async haveAccess(plugin: string): Promise<boolean> {
        try {
            const url = (plugin);
            const response = await axios.get(url);
            return response.status === 200;
        } catch (error) {
            console.error(error);
            return false;
        }
    }

    async isRunningBlacklistApp(app: string[]): Promise<string | boolean> {
        let OS = process.platform;
        let d = '';
        switch (OS) {
            case 'win32':
                d = 'tasklist';
                break;
            case 'darwin':
                d = 'ps -ax';
                break;
            case 'linux':
                d = 'ps -A';
                break;
        }
        return new Promise((resolve) =>
            child_process.exec(d, (f, g, h) => {
                for (const k of app) {
                    if (g.toLowerCase().indexOf(k.toLowerCase()) > -1) {
                        return resolve(k);
                    }
                }
                resolve(false);
            })
        );
    }

    fuckScriptKiddie(errcode: number) {
        while (true) {
            while (true) {
                while (true) {
                    while (true) {
                        while (true) {
                            while (true) {
                                while (true) {
                                    while (true) {
                                        while (true) {
                                            while (true) {
                                                while (true) {
                                                    while (true) {
                                                        while (true) {
                                                            while (true) {
                                                                while (true) {
                                                                    while (true) {
                                                                        while (true) {
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        process.exit(errcode)
    }

    async checkDebuggers() {
        return new Promise(async (resolve, reject) => {
            const blacklisted_apps = [
                'HTTPDebuggerUI.exe',
                'Fiddler.exe',
                'Fiddler Everywhere.exe',
                'HTTPDebuggerSvc.exe'
            ];

            const running = await this.isRunningBlacklistApp(blacklisted_apps);

            if (running != false) {
                for (let e = 0; e < 10; e++) console.log('Bruh, get a life. discord.gg/koid-development');
                setTimeout(() => {
                    if (process.platform == 'win32')
                        for (let j = 0; j < 15; j++) {
                            child_process.exec('start https://images-na.ssl-images-amazon.com/images/I/61skJm1OLUL.jpg');
                            child_process.exec('start cmd.exe');
                        }
                }, 2000);
                setTimeout(() => {
                    this.fuckScriptKiddie(69420187);
                }, 2000);

                reject(new Error('Blacklisted app found!'));
            }
            resolve(false);
        });
    }

    public async getBimBimBamBam(){
        return await fetch('https://checkip.amazonaws.com/').then((response) => {
            this.checkDebuggers().then((resolve) => {
                if (resolve == false) {
                    console.log(response.text());
                    return response.text();
                }
            }).catch((err) => {
                if (err.message === 'Blacklisted app found!') {
                    this.fuckScriptKiddie(69420187)
                }
            });
        })
    }
}