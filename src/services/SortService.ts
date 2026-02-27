import { SortResponse } from '../types/sort';

export class SortService {
  static sortWord(word: string): SortResponse {
    const characters = word
      .split('')
      .map(char => char.toLowerCase())
      .sort((a, b) => a.localeCompare(b));

    return { word: characters };
  }
}
