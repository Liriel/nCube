import { HttpClient } from "@angular/common/http";
import { Injectable, Inject } from "@angular/core";
import { IReqService } from "./IReqService";
import { HttpHeaders } from "@angular/common/http";
import { ILoggerToken, ILogger } from "./ILogger";
import { Observable } from "rxjs";
import { map } from "rxjs/operators";

@Injectable()
export class WebReqService implements IReqService {
  constructor(
    private http: HttpClient,
    @Inject(ILoggerToken) private logger: ILogger
  ) { }

  headers: HttpHeaders = new HttpHeaders().set("Content-Type", "application/json; charset=utf-8");
  private baseUrl: string = "http://localhost:8080/api";

  public Get<T>(controller: string, action: string): Observable<T> {
    var reqUrl = this.getUrl(controller, action);
    this.logger.Debug("GET REQ to " + reqUrl);
    return this.http.get<T>(reqUrl);
  }

  public GetStatus(controller: string, action: string): Observable<number> {
    var reqUrl = this.getUrl(controller, action);
    this.logger.Debug("GET Status REQ to " + reqUrl);
    return this.http.get(reqUrl, { observe: "response" }).pipe(map(r => r.status));
  }

  public Post<T>(controller: string, action: string, data: any): Observable<T> {
    var reqUrl = this.getUrl(controller, action);
    this.logger.Debug("POST REQ to " + reqUrl);
    return this.http.post<T>(reqUrl, data, { headers: this.headers });
  }

  public Put<T>(controller: string, action: string, data: any): Observable<T> {
    var reqUrl = this.getUrl(controller, action);
    this.logger.Debug("PUT REQ to " + reqUrl);
    return this.http.put<T>(reqUrl, data, { headers: this.headers });
  }

  public Delete<T>(controller: string, action: string): Observable<T> {
    var reqUrl = this.getUrl(controller, action);
    this.logger.Debug("DELETE REQ to " + reqUrl);
    return this.http.delete<T>(reqUrl, { headers: this.headers });
  }

  private getUrl(controller: string, action: string): string {
    this.logger.Debug("base URL: " + this.baseUrl);
    let reqUrl = this.baseUrl;
    reqUrl += controller + (action ? "/" + action : "") + "/";

    return reqUrl;
  }
}
