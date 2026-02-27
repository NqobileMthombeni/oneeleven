import { Router, Request, Response } from 'express';
import { SortController } from './controllers/SortController';

const router = Router();

router.get('/health', (_req: Request, res: Response): void => {
  res.status(200).json({
    status: 'OK',
    timestamp: new Date().toISOString(),
  });
});

router.post('/sort-word', (req: Request, res: Response, next): void => {
  SortController.sortWord(req, res, next);
});

export default router;
