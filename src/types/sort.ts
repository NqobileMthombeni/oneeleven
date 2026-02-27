export interface SortRequest {
  data?: unknown;
}

export interface SortResponse {
  word: string[];
}

export interface ErrorResponse {
  error: string;
  statusCode: number;
  timestamp: string;
}
