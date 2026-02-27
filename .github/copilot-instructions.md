<!-- Use this file to provide workspace-specific custom instructions to Copilot. For more details, visit https://code.visualstudio.com/docs/copilot/copilot-customization#_use-a-githubcopilotinstructionsmd-file -->

# OneEleven - Word Sort API

This is a production-grade Node.js/TypeScript Express API that implements clean architecture and OOP principles.

## Key Architecture

- **Controllers**: Handle HTTP requests (`SortController`)
- **Services**: Contain business logic (`SortService`)
- **Validators**: Handle input validation (`SortValidator`)
- **Middleware**: Error handling, CORS
- **Types**: TypeScript interfaces for request/response

## Code Style

- Strict TypeScript (no implicit any)
- ESLint + Prettier configured
- JSDoc comments for all public methods
- Meaningful variable and class names

## Key Features

- `POST /sort-word` - Sorts string characters alphabetically
- `GET /health` - Health check endpoint
- Input validation with detailed error messages
- CORS support
- Environment configuration via dotenv
- Global error handler

## Development Commands

- `npm run dev` - Start with ts-node
- `npm run build` - Compile to dist/
- `npm start` - Run compiled JavaScript
- `npm run lint` - Check code style
- `npm run format` - Format with Prettier

## API Response Format

All responses follow consistent JSON structure with proper HTTP status codes.

Success (200):
```json
{
  "word": ["a", "e", "e", "l", "m", "p", "x"]
}
```

Error (400/500):
```json
{
  "error": "error message",
  "statusCode": 400,
  "timestamp": "ISO timestamp"
}
```
