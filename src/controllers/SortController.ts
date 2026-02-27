import { Request, Response, NextFunction } from 'express';
import { SortValidator } from '../validators/SortValidator';
import { SortService } from '../services/SortService';
import { SortRequest } from '../types/sort';

export class SortController {
  static sortWord(req: Request, res: Response, next: NextFunction): void {
    try {
      const { data } = req.body as SortRequest;
      const validData = SortValidator.validate(data);
      const result = SortService.sortWord(validData);
      res.status(200).json(result);
    } catch (error) {
      next(error);
    }
  }
}
