import { Injectable } from '@angular/core';

import { environment } from '../environments/environment';

@Injectable()
export class AppInitService {

    async fetchDynamicConfig(): Promise<void> {
        if (!environment.production) {
            return;
        }

        try {
            const response = await fetch(`${window.location.origin}/appsettings.json`);
            const data = await response.json();
            for (const [key, value] of Object.entries(data)) {
                environment[key] = value;
            }
        } catch (error) {

        }
    }

}
