import { InjectionToken } from "@angular/core";
import { StatusInfo } from "../models/StatusInfo";
import { Observable } from "rxjs";

// this is needed to the interface like an interface in c# - if you don't
// do this the interface symbols get lost during "compilation"
export let INotificationServiceToken = new InjectionToken<INotificationService>("INotificationService");

// sends notification message to client
export interface INotificationService {

  // raised if the status on the box has changed (i.e.: playback has stopped)
  OnStatusInfoChanged: Observable<StatusInfo>;
  // test
  OnLevelChanged: Observable<number>;
}
