import express, { Express } from 'express';
import cors from 'cors';
import routes from './routes';
import { errorHandler } from './middlewares/errorHandler';

export class App {
  private app: Express;

  constructor() {
    this.app = express();
    this.setupMiddlewares();
    this.setupRoutes();
    this.setupErrorHandling();
  }

  private setupMiddlewares(): void {
    this.app.use(cors());
    this.app.use(express.json({ limit: '10kb' }));
    this.app.use(express.static('public'));
  }

  private setupRoutes(): void {
    this.app.use('/', routes);
  }

  private setupErrorHandling(): void {
    this.app.use(errorHandler);
  }

  getApp(): Express {
    return this.app;
  }
}
