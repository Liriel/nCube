import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MatGridListModule } from '@angular/material/grid-list';
import { MatCardModule } from '@angular/material/card';
import { MatMenuModule } from '@angular/material/menu';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { MatSlideToggleModule } from '@angular/material/slide-toggle';
import { MatSelectModule } from '@angular/material/select';
import { MatSliderModule } from '@angular/material/slider';
import {MatInputModule} from '@angular/material/input';
import { ConsoleLogger } from './services/ConsoleLogger';
import { WebReqService } from './services/WebReqService';
import { IReqServiceToken } from './services/IReqService';
import { ILoggerToken } from './services/ILogger';
import { INotificationServiceToken } from './services/INotificationService';
import { SignalrNotificationService } from './services/SignalrNotificationService';

import { AppComponent } from './app.component';
import { FormsModule } from '@angular/forms';
import { LayoutModule } from '@angular/cdk/layout';
import { HttpClientModule } from '@angular/common/http';

@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule,
    BrowserAnimationsModule,
    HttpClientModule,
    FormsModule,
    MatGridListModule,
    MatCardModule,
    MatMenuModule,
    MatIconModule,
    MatButtonModule,
    MatSlideToggleModule,
    MatSliderModule,
    MatSelectModule,
    MatInputModule,
    LayoutModule

  ],
  providers: [
    { provide: ILoggerToken, useClass: ConsoleLogger },
    { provide: IReqServiceToken, useClass: WebReqService },
    { provide: INotificationServiceToken, useClass: SignalrNotificationService },
  ],

  bootstrap: [AppComponent]
})
export class AppModule { }
