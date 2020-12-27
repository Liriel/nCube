import { Injectable } from "@angular/core";
import { ILogger } from "./ILogger";

@Injectable()
export class ConsoleLogger implements ILogger {
  Debug(message: string): void {
    console.log("DEBUG: " + message);
  }
  Info(message: string): void {
    console.log("INFO: " + message);
  }
  Warn(message: string): void {
    console.log("WARN: " + message);
  }
  Error(message: string): void {
    console.log("ERROR: " + message);
  }
}
