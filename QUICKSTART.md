# 🚀 Quick Start Guide

## Installation & Setup (60 seconds)

```bash
cd /Users/nqobile.mthombeni/Desktop/OneEleven
npm install
npm run dev
```

API is now running at: **http://localhost:3000**

## Access Points

| URL | Purpose |
|-----|---------|
| http://localhost:3000 | Frontend UI for testing |
| http://localhost:3000/health | Health check endpoint |
| http://localhost:3000/sort-word | Sort API endpoint (POST) |

## Quick Test

### Browser
Open http://localhost:3000 - Complete UI for testing

### Command Line
```bash
# Test the API
curl -X POST http://localhost:3000/sort-word \
  -H "Content-Type: application/json" \
  -d '{"data": "example"}'
```

Expected Response:
```json
{
  "word": ["a", "e", "e", "l", "m", "p", "x"]
}
```

## Available Commands

```bash
npm run dev          # 🔧 Development (recommended for testing)
npm run build        # 📦 Build for production
npm start            # 🚀 Run compiled code
npm run lint         # 🔍 Check code quality
npm run format       # ✨ Auto-format code
```

## Project Files

| File | Purpose |
|------|---------|
| README.md | Complete documentation |
| DEPLOYMENT.md | Deploy to any platform |
| EXAMPLES.md | Code examples (JS, Python, curl, etc.) |
| PROJECT_SUMMARY.md | Project overview |
| FILE_MANIFEST.txt | File listing |

## Folder Structure

```
src/                    ← Source code
├── controllers/        ← HTTP handlers
├── services/          ← Business logic
├── validators/        ← Input validation
├── middlewares/       ← Error handling
└── types/             ← TypeScript types

public/               ← Frontend HTML
dist/                 ← Compiled JavaScript
```

## Key Features

✅ **Clean Architecture** - Separated concerns (Controller → Service → Validator)
✅ **TypeScript Strict Mode** - Type-safe production code
✅ **Error Handling** - Consistent error responses
✅ **Input Validation** - Full request validation
✅ **Frontend Included** - Beautiful test UI
✅ **Well Documented** - JSDoc + README + Examples
✅ **Production Ready** - ESLint + Prettier + Proper configs

## API Endpoint

**POST** `/sort-word`

### Request
```json
{
  "data": "example"
}
```

### Response (Success - 200)
```json
{
  "word": ["a", "e", "e", "l", "m", "p", "x"]
}
```

### Response (Error - 400)
```json
{
  "error": "Missing required field: data",
  "statusCode": 400,
  "timestamp": "2026-02-27T10:30:00.000Z"
}
```

## Validation Rules

| Rule | Requirement |
|------|-------------|
| Field required | `data` must be present |
| Type check | Must be a `string` |
| Empty check | Cannot be empty or whitespace |

## Development Workflow

1. **Start Server**: `npm run dev`
2. **Make Changes**: Edit files in `src/`
3. **Server Auto-Reloads**: ts-node watches files
4. **Test**: Open http://localhost:3000
5. **Lint**: `npm run lint`
6. **Build**: `npm run build` when ready

## VS Code Integration

Automatic task detection - press Ctrl+Shift+B (or Cmd+Shift+B on Mac) to build.

Debug configuration available in `.vscode/launch.json`

## Deployment

Ready to deploy to:
- Heroku
- Vercel
- Railway.app
- Docker
- AWS Lambda
- Google Cloud Run
- And more...

See **DEPLOYMENT.md** for detailed instructions.

## Testing

### Frontend
http://localhost:3000 - Full UI with test form

### CLI
```bash
./test.sh              # Run all tests
curl                   # Individual endpoint testing
```

### API Examples
See **EXAMPLES.md** for code in multiple languages:
- JavaScript/Node.js
- Python
- cURL
- Postman
- And more

## Troubleshooting

### Port already in use
```bash
PORT=3001 npm run dev
```

### Dependencies not installing
```bash
rm -rf node_modules package-lock.json
npm install
```

### TypeScript errors
```bash
npm run type-check    # Check what's wrong
npm run lint:fix      # Auto-fix issues
```

## Environment Variables

Edit `.env`:
```env
PORT=3000
NODE_ENV=development
```

## File Overview

```
OneEleven/
├── 📄 package.json              ← Dependencies
├── 📄 tsconfig.json             ← TypeScript config
├── 📄 .eslintrc.json            ← Linting rules
├── 📄 .prettierrc.json          ← Code formatting
│
├── 📁 src/                      ← TypeScript source
│   ├── server.ts               ← Entry point
│   ├── app.ts                  ← Express setup
│   ├── routes.ts               ← API routes
│   ├── controllers/            ← HTTP handlers
│   ├── services/               ← Business logic
│   ├── validators/             ← Validation
│   ├── middlewares/            ← Error handler
│   ├── types/                  ← TypeScript types
│   └── config/                 ← Configuration
│
├── 📁 public/
│   └── index.html              ← Frontend UI
│
├── 📁 dist/                    ← Compiled JS (auto-generated)
│
├── 📁 .vscode/
│   ├── tasks.json              ← Build tasks
│   ├── launch.json             ← Debug config
│   └── settings.json           ← Editor settings
│
├── 📄 README.md                ← Full documentation
├── 📄 DEPLOYMENT.md            ← Deploy guide
├── 📄 EXAMPLES.md              ← Code samples
└── 📄 PROJECT_SUMMARY.md       ← Project overview
```

## Next Steps

1. **Explore**: Open files in VS Code
2. **Test**: Try the API at http://localhost:3000
3. **Extend**: Add new endpoints following the pattern
4. **Deploy**: Follow DEPLOYMENT.md

## Support

- 📖 **README.md** - Complete documentation
- 🚀 **DEPLOYMENT.md** - Deployment instructions
- 💻 **EXAMPLES.md** - Code examples
- 📋 **PROJECT_SUMMARY.md** - Feature overview
- 🗂️ **FILE_MANIFEST.txt** - File listing

## Key Highlights

✨ **Production Quality Code**
- Strict TypeScript
- Clean architecture
- Error handling
- Input validation

🎨 **Modern Frontend**
- Responsive design
- Real-time testing
- Beautiful UI
- Mobile friendly

📚 **Comprehensive Docs**
- README with examples
- Deployment guide
- Code samples
- Project summary

🚀 **Ready to Deploy**
- Docker ready
- Environment configured
- Build optimized
- Production tested

---

**Happy coding! 🎉**

For more details, see the full documentation in README.md
