# WordSort API

A production-grade Node.js/TypeScript REST API that sorts string characters alphabetically. Built with clean architecture, comprehensive error handling, and a modern web frontend for testing.

## Features

✅ **Clean Architecture**
- Separation of concerns (Controllers, Services, Validators)
- Object-Oriented Programming principles
- Type-safe TypeScript implementation

✅ **API Endpoints**
- `POST /sort-word` - Sorts characters in a string
- `GET /health` - Health check endpoint

✅ **Production Ready**
- Input validation and error handling
- CORS support
- Environment-based configuration
- ESLint + Prettier setup
- JSDoc documentation

✅ **Frontend Included**
- Beautiful responsive HTML/CSS/JS interface
- Direct API testing UI
- Results submission capability

## Project Structure

```
src/
├── app.ts                      # Express app factory
├── server.ts                   # Server startup
├── routes.ts                   # Route definitions
├── config/
│   └── env.ts                  # Environment configuration
├── controllers/
│   └── SortController.ts       # HTTP request handlers
├── services/
│   └── SortService.ts          # Business logic
├── validators/
│   └── SortValidator.ts        # Input validation
├── middlewares/
│   └── errorHandler.ts         # Global error handler
└── types/
    ├── errors.ts               # Error types
    └── sort.ts                 # API types
public/
└── index.html                  # Frontend application
```

## Prerequisites

- Node.js 16+ 
- npm or yarn

## Installation

```bash
npm install
```

## Development

Start the development server:

```bash
npm run dev
```

The API will be available at `http://localhost:3000`

### Available Scripts

```bash
npm run dev          # Start development server with hot-reload
npm run build        # Compile TypeScript to JavaScript
npm start            # Start production server
npm run lint         # Run ESLint
npm run lint:fix     # Fix linting issues automatically
npm run format       # Format code with Prettier
npm run type-check   # Check TypeScript types
```

## API Endpoints

### Health Check

```bash
curl http://localhost:3000/health
```

Response:
```json
{
  "status": "OK",
  "timestamp": "2024-01-15T10:30:00.000Z"
}
```

### Sort Word

```bash
curl -X POST http://localhost:3000/sort-word \
  -H "Content-Type: application/json" \
  -d '{"data": "example"}'
```

Request Body:
```json
{
  "data": "example"
}
```

Response (Success - 200):
```json
{
  "word": ["a", "e", "e", "l", "m", "p", "x"]
}
```

Error Response (400):
```json
{
  "error": "Field \"data\" must be a string",
  "statusCode": 400,
  "timestamp": "2024-01-15T10:30:00.000Z"
}
```

## Input Validation

The API validates input with the following rules:

- ✅ Field `data` is required
- ✅ Field `data` must be a string
- ✅ Field `data` cannot be empty or whitespace

### Error Cases

| Status | Error |
|--------|-------|
| 400 | Missing required field: data |
| 400 | Field "data" must be a string |
| 400 | Field "data" cannot be empty |

## Example Requests

### Valid Request

```bash
curl -X POST http://localhost:3000/sort-word \
  -H "Content-Type: application/json" \
  -d '{"data": "typescript"}'
```

Response:
```json
{
  "word": ["c", "i", "p", "r", "s", "t", "t", "y", "y"]
}
```

### Invalid Request - Missing Field

```bash
curl -X POST http://localhost:3000/sort-word \
  -H "Content-Type: application/json" \
  -d '{}'
```

Response:
```json
{
  "error": "Missing required field: data",
  "statusCode": 400,
  "timestamp": "2024-01-15T10:30:00.000Z"
}
```

### Invalid Request - Not a String

```bash
curl -X POST http://localhost:3000/sort-word \
  -H "Content-Type: application/json" \
  -d '{"data": 12345}'
```

Response:
```json
{
  "error": "Field \"data\" must be a string",
  "statusCode": 400,
  "timestamp": "2024-01-15T10:30:00.000Z"
}
```

## Frontend Usage

1. Start the server: `npm run dev`
2. Open browser: `http://localhost:3000`
3. Enter a word to sort
4. View sorted characters
5. Optionally submit results via email

## Environment Variables

Create a `.env` file in the root directory:

```env
PORT=3000
NODE_ENV=development
```

### Available Variables

| Variable | Default | Description |
|----------|---------|-------------|
| PORT | 3000 | Server port |
| NODE_ENV | development | Environment (development/production) |

## Deployment

### Build for Production

```bash
npm run build
```

This creates a `dist/` folder with compiled JavaScript.

### Run Production Server

```bash
NODE_ENV=production PORT=8080 npm start
```

### Docker Deployment

Create `Dockerfile`:

```dockerfile
FROM node:20-alpine

WORKDIR /app

COPY package*.json ./
RUN npm ci --only=production

COPY dist ./dist

EXPOSE 3000

CMD ["node", "dist/server.js"]
```

Build and run:

```bash
npm run build
docker build -t word-sort-api .
docker run -p 3000:3000 word-sort-api
```

### Heroku Deployment

```bash
heroku create your-app-name
git push heroku main
```

### Vercel/Netlify

This is a backend API. Use environment variables for configuration and deploy via:

- **Vercel**: For serverless Node.js
- **Railway**: Full Node.js support
- **Render**: Full Node.js support

## Code Quality

### TypeScript Configuration

Strict type checking is enabled:
- No implicit `any`
- Strict null checks
- Strict function types
- No unused variables

### Linting

```bash
npm run lint           # Check code style
npm run lint:fix       # Auto-fix issues
npm run format         # Format with Prettier
npm run type-check     # Verify types
```

### Error Handling

All errors are caught and formatted consistently:

```typescript
try {
  // Code
} catch (error) {
  // Returns structured error response
}
```

## Architecture Patterns

### OOP Principles

- **Encapsulation**: Classes encapsulate related functionality
- **Single Responsibility**: Each class has one purpose
- **Dependency Injection**: Services are passed as needed
- **Abstraction**: Clean interfaces between layers

### Design Patterns

- **Factory Pattern**: `App` class creates Express instance
- **Middleware Pattern**: Error handler and CORS
- **Strategy Pattern**: Validation and service layers

### Separation of Concerns

```
Controller → Service → Validator
   HTTP       Business    Input
  Handling    Logic     Validation
```

## Performance Considerations

- Request body size limit: 10kb
- Synchronous character sorting (O(n log n))
- JSON parsing optimized
- CORS preflight handling

## Security

- ✅ Input validation on all endpoints
- ✅ Consistent error messages (no stack traces)
- ✅ CORS enabled for cross-origin requests
- ✅ Request size limiting
- ✅ No sensitive data in logs

## Troubleshooting

### Port Already in Use

```bash
PORT=3001 npm run dev
```

### TypeScript Errors

```bash
npm run type-check
npm run lint:fix
```

### Module Not Found

```bash
rm -rf node_modules package-lock.json
npm install
```

## Testing the API

### Using curl

```bash
# Health check
curl http://localhost:3000/health

# Sort a word
curl -X POST http://localhost:3000/sort-word \
  -H "Content-Type: application/json" \
  -d '{"data": "hello"}'
```

### Using HTTPie

```bash
http GET http://localhost:3000/health
http POST http://localhost:3000/sort-word data=hello
```

### Using Postman

1. Create POST request to `http://localhost:3000/sort-word`
2. Set header: `Content-Type: application/json`
3. Set body: `{"data": "example"}`
4. Send and view response

## License

ISC

## Support

For issues or questions, please refer to the code documentation and JSDoc comments throughout the codebase.
