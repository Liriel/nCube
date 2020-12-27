import { Observable } from "rxjs";
import { InjectionToken } from "@angular/core";

export let IReqServiceToken = new InjectionToken<IReqService>("IReqServiceToken");
export interface IReqService {
  Get<T>(controller: string, action: string): Observable<T>;
  Post<T>(controller: string, action: string, data: any): Observable<T>;
  Put<T>(controller: string, action: string, data: any): Observable<T>;
  Delete<T>(controller: string, action: string): Observable<T>;
}
