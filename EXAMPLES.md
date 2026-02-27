# API Examples

## cURL Examples

### Health Check

```bash
curl -X GET http://localhost:3000/health
```

Response:
```json
{
  "status": "OK",
  "timestamp": "2026-02-27T10:30:00.000Z"
}
```

### Sort Word - Basic

```bash
curl -X POST http://localhost:3000/sort-word \
  -H "Content-Type: application/json" \
  -d '{"data": "example"}'
```

Response:
```json
{
  "word": ["a", "e", "e", "l", "m", "p", "x"]
}
```

### Sort Word - Long String

```bash
curl -X POST http://localhost:3000/sort-word \
  -H "Content-Type: application/json" \
  -d '{"data": "the quick brown fox jumps over the lazy dog"}'
```

Response:
```json
{
  "word": [
    " ", " ", " ", " ", " ", " ", " ", " ",
    "a", "b", "c", "d", "e", "e", "f", "g",
    "h", "h", "i", "j", "k", "l", "m", "n",
    "o", "o", "o", "p", "q", "r", "t", "t",
    "u", "u", "v", "w", "y", "z"
  ]
}
```

### Sort Word - Special Characters

```bash
curl -X POST http://localhost:3000/sort-word \
  -H "Content-Type: application/json" \
  -d '{"data": "Hello@World!"}'
```

Response:
```json
{
  "word": ["!", "@", "d", "e", "h", "l", "l", "l", "o", "o", "r", "w"]
}
```

### Sort Word - Mixed Case

```bash
curl -X POST http://localhost:3000/sort-word \
  -H "Content-Type: application/json" \
  -d '{"data": "TypeScript"}'
```

Response:
```json
{
  "word": ["a", "c", "p", "r", "s", "t", "t", "y", "y"]
}
```

### Error - Missing Field

```bash
curl -X POST http://localhost:3000/sort-word \
  -H "Content-Type: application/json" \
  -d '{}'
```

Response (400):
```json
{
  "error": "Missing required field: data",
  "statusCode": 400,
  "timestamp": "2026-02-27T10:30:00.000Z"
}
```

### Error - Empty String

```bash
curl -X POST http://localhost:3000/sort-word \
  -H "Content-Type: application/json" \
  -d '{"data": ""}'
```

Response (400):
```json
{
  "error": "Field \"data\" cannot be empty",
  "statusCode": 400,
  "timestamp": "2026-02-27T10:30:00.000Z"
}
```

### Error - Wrong Type

```bash
curl -X POST http://localhost:3000/sort-word \
  -H "Content-Type: application/json" \
  -d '{"data": 12345}'
```

Response (400):
```json
{
  "error": "Field \"data\" must be a string",
  "statusCode": 400,
  "timestamp": "2026-02-27T10:30:00.000Z"
}
```

### Error - Wrong Type (Array)

```bash
curl -X POST http://localhost:3000/sort-word \
  -H "Content-Type: application/json" \
  -d '{"data": ["a", "b", "c"]}'
```

Response (400):
```json
{
  "error": "Field \"data\" must be a string",
  "statusCode": 400,
  "timestamp": "2026-02-27T10:30:00.000Z"
}
```

## JavaScript/Fetch Examples

### Basic Request

```javascript
const response = await fetch('http://localhost:3000/sort-word', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
  },
  body: JSON.stringify({ data: 'example' }),
});

const result = await response.json();
console.log(result);
// { word: ['a', 'e', 'e', 'l', 'm', 'p', 'x'] }
```

### With Error Handling

```javascript
async function sortWord(word) {
  try {
    const response = await fetch('http://localhost:3000/sort-word', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ data: word }),
    });

    const result = await response.json();

    if (!response.ok) {
      throw new Error(result.error || 'Failed to sort');
    }

    return result.word;
  } catch (error) {
    console.error('Error:', error.message);
    throw error;
  }
}

// Usage
sortWord('example').then(console.log);
```

### With Retry Logic

```javascript
async function sortWordWithRetry(word, maxRetries = 3) {
  let lastError;

  for (let i = 0; i < maxRetries; i++) {
    try {
      const response = await fetch('http://localhost:3000/sort-word', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ data: word }),
      });

      return await response.json();
    } catch (error) {
      lastError = error;
      await new Promise((resolve) => setTimeout(resolve, 1000 * (i + 1)));
    }
  }

  throw lastError;
}
```

## TypeScript Examples

### Type-Safe Request

```typescript
import { SortRequest, SortResponse } from './types/sort';

async function sortWord(data: string): Promise<SortResponse> {
  const request: SortRequest = { data };

  const response = await fetch('http://localhost:3000/sort-word', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(request),
  });

  if (!response.ok) {
    throw new Error('Sort failed');
  }

  return response.json();
}
```

### With Validation

```typescript
class SortApiClient {
  private baseUrl: string;

  constructor(baseUrl: string = 'http://localhost:3000') {
    this.baseUrl = baseUrl;
  }

  async sort(word: string): Promise<string[]> {
    if (!word || typeof word !== 'string') {
      throw new Error('Word must be a non-empty string');
    }

    const response = await fetch(`${this.baseUrl}/sort-word`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ data: word }),
    });

    const result = await response.json();

    if (!response.ok) {
      throw new Error(result.error);
    }

    return result.word;
  }

  async healthCheck(): Promise<boolean> {
    try {
      const response = await fetch(`${this.baseUrl}/health`);
      return response.ok;
    } catch {
      return false;
    }
  }
}

// Usage
const client = new SortApiClient();
const sorted = await client.sort('example');
```

## Node.js Examples

### Using Axios

```javascript
const axios = require('axios');

async function sortWord(word) {
  try {
    const response = await axios.post('http://localhost:3000/sort-word', {
      data: word,
    });
    return response.data.word;
  } catch (error) {
    console.error('Error:', error.response?.data || error.message);
  }
}

sortWord('example').then(console.log);
```

### Using Node-Fetch

```javascript
const fetch = require('node-fetch');

async function sortWord(word) {
  const response = await fetch('http://localhost:3000/sort-word', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ data: word }),
  });

  return response.json();
}
```

## Python Examples

### Using Requests

```python
import requests

def sort_word(word):
    url = 'http://localhost:3000/sort-word'
    payload = {'data': word}
    response = requests.post(url, json=payload)
    response.raise_for_status()
    return response.json()['word']

result = sort_word('example')
print(result)  # ['a', 'e', 'e', 'l', 'm', 'p', 'x']
```

### Using HTTPX (Async)

```python
import httpx
import asyncio

async def sort_word(word):
    async with httpx.AsyncClient() as client:
        response = await client.post(
            'http://localhost:3000/sort-word',
            json={'data': word}
        )
        response.raise_for_status()
        return response.json()['word']

asyncio.run(sort_word('example'))
```

## HTML Form Example

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Sort Word API</title>
  </head>
  <body>
    <form id="sortForm">
      <input type="text" id="word" placeholder="Enter word" required />
      <button type="submit">Sort</button>
    </form>

    <div id="result"></div>

    <script>
      document.getElementById('sortForm').addEventListener('submit', async (e) => {
        e.preventDefault();
        const word = document.getElementById('word').value;

        try {
          const response = await fetch('/sort-word', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ data: word }),
          });

          const result = await response.json();

          if (!response.ok) {
            throw new Error(result.error);
          }

          document.getElementById('result').innerText =
            'Sorted: ' + JSON.stringify(result.word);
        } catch (error) {
          document.getElementById('result').innerText = 'Error: ' + error.message;
        }
      });
    </script>
  </body>
</html>
```

## Postman Collection

```json
{
  "info": {
    "name": "Word Sort API",
    "schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json"
  },
  "item": [
    {
      "name": "Health Check",
      "request": {
        "method": "GET",
        "url": {
          "raw": "{{baseUrl}}/health",
          "host": ["{{baseUrl}}"],
          "path": ["health"]
        }
      }
    },
    {
      "name": "Sort Word",
      "request": {
        "method": "POST",
        "header": [
          {
            "key": "Content-Type",
            "value": "application/json"
          }
        ],
        "body": {
          "mode": "raw",
          "raw": "{\"data\": \"example\"}"
        },
        "url": {
          "raw": "{{baseUrl}}/sort-word",
          "host": ["{{baseUrl}}"],
          "path": ["sort-word"]
        }
      }
    }
  ],
  "variable": [
    {
      "key": "baseUrl",
      "value": "http://localhost:3000"
    }
  ]
}
```

## Performance Testing

### Apache Bench

```bash
# 1000 requests with 10 concurrent
ab -n 1000 -c 10 http://localhost:3000/health

# With POST data
ab -n 1000 -c 10 -p data.json \
   -T application/json \
   http://localhost:3000/sort-word
```

### Wrk

```bash
# 12 threads, 400 connections, 30 seconds
wrk -t12 -c400 -d30s http://localhost:3000/health

# With custom script
wrk -t12 -c400 -d30s -s script.lua http://localhost:3000/sort-word
```

## GraphQL (If Extended)

```graphql
mutation {
  sortWord(data: "example") {
    word
  }
}
```
