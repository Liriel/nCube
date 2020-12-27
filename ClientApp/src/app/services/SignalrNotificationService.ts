import { INotificationService } from "./INotificationService";
import { StatusInfo } from "../models/StatusInfo";
import { Observable, Subject } from "rxjs";
import * as signalR from "@microsoft/signalr";

export class SignalrNotificationService implements INotificationService {
    OnStatusInfoChanged: Subject<StatusInfo> = new Subject<StatusInfo>();
    OnLevelChanged: Subject<number> = new Subject<number>();

    constructor() {
        console.log("conecting");

        // connect to the hub
        const connection = new signalR.HubConnectionBuilder()
            .withUrl("http://localhost:5000/notificationhub")
            .build();

        connection.on("StatusInfoChanged", (info: StatusInfo) => {
            console.log("messge recieved");
            this.OnStatusInfoChanged.next(info);
        });

        connection.on("LevelChanged", (level: number) => {
            console.log("level changed recieved " + level);
            this.OnLevelChanged.next(level);
        });

        connection.start().catch(err => console.error(err));
    }
}