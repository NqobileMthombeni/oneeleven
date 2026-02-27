# Deployment Guide

## Local Development

### Prerequisites
- Node.js 16+ 
- npm or yarn

### Quick Start

```bash
# Install dependencies
npm install

# Start development server
npm run dev

# API available at http://localhost:3000
```

### Development Commands

```bash
npm run dev          # Start with hot-reload
npm run build        # Compile TypeScript
npm run start        # Run compiled code
npm run lint         # Check code style
npm run lint:fix     # Fix style issues
npm run format       # Format with Prettier
npm run type-check   # Verify TypeScript
```

## Docker

### Build Image

```dockerfile
FROM node:20-alpine

WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

COPY dist ./dist
COPY public ./public

EXPOSE 3000
ENV NODE_ENV=production
ENV PORT=3000

CMD ["node", "dist/server.js"]
```

### Build and Run

```bash
# Build project
npm run build

# Create Docker image
docker build -t word-sort-api:latest .

# Run container
docker run -p 3000:3000 \
  -e NODE_ENV=production \
  -e PORT=3000 \
  word-sort-api:latest
```

## Cloud Platforms

### Heroku

```bash
# Create app
heroku create your-app-name

# Set environment
heroku config:set NODE_ENV=production

# Build script in package.json (auto-detected)
git push heroku main

# View logs
heroku logs --tail
```

### Vercel (Serverless)

Create `vercel.json`:

```json
{
  "version": 2,
  "builds": [
    {
      "src": "dist/server.js",
      "use": "@vercel/node"
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "dist/server.js"
    }
  ],
  "env": {
    "NODE_ENV": "production"
  }
}
```

Deploy:
```bash
npm run build
vercel deploy
```

### Railway.app

```bash
# Login
railway login

# Initialize project
railway init

# Deploy
railway up
```

### Render

1. Connect GitHub repo to Render
2. Create Web Service
3. Set Build Command: `npm run build`
4. Set Start Command: `npm start`
5. Add Environment Variables: `NODE_ENV=production`

### AWS Lambda

Create handler:

```typescript
// lambda.ts
import { App } from './app';
import { config } from './config/env';

const app = new App().getApp();

export const handler = async (event: any, context: any) => {
  // Lambda handler implementation
};
```

### Google Cloud Run

```bash
# Build
npm run build

# Create Dockerfile (included above)

# Deploy
gcloud run deploy word-sort-api \
  --source . \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated
```

## Environment Configuration

### Production Variables

```env
PORT=3000
NODE_ENV=production
```

### Optional Variables

Add to `.env`:

```env
LOG_LEVEL=info
CORS_ORIGIN=*
REQUEST_LIMIT=10kb
```

## Performance Optimization

### Build Optimization

```bash
# Minify and optimize
npm run build

# Check bundle size
du -sh dist/
```

### Runtime Optimization

- Keep Node.js updated
- Use `--max-old-space-size` for memory
- Enable gzip compression
- Cache static assets (frontend)

### Nginx Reverse Proxy

```nginx
upstream api {
  server localhost:3000;
}

server {
  listen 80;
  server_name api.example.com;

  location / {
    proxy_pass http://api;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
  }

  location /sort-word {
    proxy_pass http://api;
    proxy_method POST;
    proxy_set_header Content-Type application/json;
  }
}
```

## Monitoring & Logging

### PM2 Process Manager

```bash
npm install -g pm2

# Start with PM2
pm2 start dist/server.js --name "word-sort-api"

# Logs
pm2 logs word-sort-api

# Monitor
pm2 monit
```

### Health Checks

```bash
# Check server health
curl http://localhost:3000/health

# In monitoring script
check_health() {
  curl -f http://localhost:3000/health || exit 1
}
```

## Database (If Needed)

For scaling with database:

```typescript
// Add to config/env.ts
export const dbConfig = {
  host: process.env.DB_HOST || 'localhost',
  port: parseInt(process.env.DB_PORT || '5432', 10),
  database: process.env.DB_NAME || 'sortapi',
  user: process.env.DB_USER || 'postgres',
  password: process.env.DB_PASSWORD || 'password',
};
```

## SSL/HTTPS

### Let's Encrypt with Certbot

```bash
sudo certbot certonly --standalone \
  -d api.example.com

# Update Nginx config
listen 443 ssl;
ssl_certificate /etc/letsencrypt/live/api.example.com/fullchain.pem;
ssl_certificate_key /etc/letsencrypt/live/api.example.com/privkey.pem;
```

## Scaling

### Horizontal Scaling

Use load balancer (Nginx, AWS ELB):

```bash
# Run multiple instances
PORT=3000 npm start &
PORT=3001 npm start &
PORT=3002 npm start &
```

### Clustering

Implement Node.js cluster module:

```typescript
import cluster from 'cluster';
import os from 'os';

const numCPUs = os.cpus().length;

if (cluster.isPrimary) {
  for (let i = 0; i < numCPUs; i++) {
    cluster.fork();
  }
} else {
  // Worker process - start app
}
```

## Backup & Recovery

### Source Code

```bash
git push origin main
git tag v1.0.0
git push origin v1.0.0
```

### Database Backups (if applicable)

```bash
# PostgreSQL example
pg_dump dbname > backup.sql
```

## Security Checklist

- ✅ Environment variables not in code
- ✅ HTTPS enabled in production
- ✅ Input validation on all endpoints
- ✅ CORS properly configured
- ✅ Error handling doesn't leak sensitive data
- ✅ Dependencies regularly updated
- ✅ Logging doesn't contain secrets
- ✅ Rate limiting enabled (if needed)

## Troubleshooting Deployment

### Port in Use

```bash
# Find process
lsof -i :3000

# Kill process
kill -9 <PID>
```

### Memory Issues

```bash
# Monitor memory
node --max-old-space-size=4096 dist/server.js
```

### Dependency Issues

```bash
# Clear cache and reinstall
rm -rf node_modules package-lock.json
npm install
npm run build
```

### Logs Not Showing

```bash
# Check logs with stderr redirect
npm start 2>&1 | tee app.log
```

## Performance Benchmarking

```bash
# Using Apache Bench
ab -n 1000 -c 10 http://localhost:3000/health

# Using wrk
wrk -t12 -c400 -d30s http://localhost:3000/health
```

## Rollback Procedure

```bash
# Git rollback
git revert <commit-hash>
git push origin main

# Rebuild and restart
npm run build
npm start
```
