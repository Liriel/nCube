import { InjectionToken } from "@angular/core";

// this is needed to the interface like an interface in c# - if you don't
// do this the interface symbols get lost during "compilation"
export let ILoggerToken = new InjectionToken<ILogger>("ILogger");

export interface ILogger {
  Debug(message: string): void;
  Info(message: string): void;
  Warn(message: string): void;
  Error(message: string): void;
}
