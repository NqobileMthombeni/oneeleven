import { Request, Response, NextFunction } from 'express';
import { AppError } from '../types/errors';
import { ErrorResponse } from '../types/sort';

export const errorHandler = (
  error: Error | AppError,
  _req: Request,
  res: Response,
  _next: NextFunction,
): void => {
  const statusCode =
    error instanceof AppError && error.statusCode ? error.statusCode : 500;
  const message =
    error instanceof AppError ? error.message : 'Internal server error';

  const response: ErrorResponse = {
    error: message,
    statusCode,
    timestamp: new Date().toISOString(),
  };

  res.status(statusCode).json(response);
};
