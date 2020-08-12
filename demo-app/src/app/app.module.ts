import { BrowserModule } from '@angular/platform-browser';
import { NgModule, APP_INITIALIZER } from '@angular/core';

import { AppComponent } from './app.component';
import { AppInitService } from './app-init.service';

export function initializeApp(appInitService: AppInitService): () => Promise<void> {
  return (): Promise<void> => {
    return appInitService.fetchDynamicConfig();
  };
}

@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule
  ],
  providers: [
    AppInitService,
    { provide: APP_INITIALIZER,  useFactory: initializeApp, deps: [AppInitService], multi: true}
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
