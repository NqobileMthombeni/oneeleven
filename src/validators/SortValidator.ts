import { AppError } from '../types/errors';

export class SortValidator {
  static validate(data: unknown): string {
    if (!data || typeof data !== 'string' || data.trim().length === 0) {
      throw new AppError('Field "data" must be a non-empty string', 400);
    }
    return data;
  }
}
