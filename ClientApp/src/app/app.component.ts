import { Component, Inject, OnInit } from '@angular/core';
import { map } from 'rxjs/operators';
import { Breakpoints, BreakpointObserver } from '@angular/cdk/layout';
import { MatSlideToggleChange } from '@angular/material/slide-toggle';
import { MatSliderChange } from '@angular/material/slider';
import { IReqService, IReqServiceToken } from './services/IReqService';
import { INotificationService, INotificationServiceToken } from './services/INotificationService';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  title = 'ncubeweb';

  public contentWidth: number = 285;
  public lightOn: boolean = false;
  public brightness: number = 25;
  public cols = this.breakpointObserver.observe(Breakpoints.Handset).pipe(

    map(({ matches }) => {
      if (matches) {
        return 1;
      }

      return 4;
    })
  );

  constructor(
    private breakpointObserver: BreakpointObserver,
    @Inject(IReqServiceToken) private reqService: IReqService,
    @Inject(INotificationServiceToken) private notificationService : INotificationService
  ) { 
    this.notificationService.OnLevelChanged.subscribe(level => {
      if(level > 0){
        this.brightness = level;
        this.lightOn = true;
      }
      else
        this.lightOn = false;
    });
  }

  public async onLightToggle($event: MatSlideToggleChange) {
    if ($event.checked) {
      await this.reqService.Post("/light", this.brightness.toString(), null).toPromise();
    } else {
      await this.reqService.Post("/light", "0", null).toPromise();
    }
  }

  public async onBrightnessChange($event: MatSliderChange) {
    await this.reqService.Post("/light", ($event.value).toString(), null).toPromise();
  }
}


