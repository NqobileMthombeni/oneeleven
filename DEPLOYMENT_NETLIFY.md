# Deployment Guide

This project has two parts that deploy separately:

## Part 1: Deploy Frontend to Netlify

Your frontend (HTML/CSS/JS) will be hosted on Netlify.

### Steps:

1. **Push to GitHub** (if not already done):
   ```bash
   git add .
   git commit -m "Add deployment config"
   git push origin main
   ```

2. **Go to Netlify**: https://netlify.com

3. **Click "New site from Git"**

4. **Connect GitHub**:
   - Authorize Netlify to access your GitHub
   - Select repository: `oneeleven`
   - Branch: `main`

5. **Build settings**:
   - Build command: Leave blank (already in netlify.toml)
   - Publish directory: `public`
   - Click **Deploy**

6. **Your frontend will be live at**:
   ```
   https://your-site-name.netlify.app
   ```

---

## Part 2: Deploy Backend API to Railway

Your API server will run on Railway.

### Steps:

1. **Go to Railway**: https://railway.app

2. **Create new project**:
   - Click "New Project"
   - Select "Deploy from GitHub repo"
   - Choose `oneeleven`
   - Select branch: `main`

3. **Configure variables**:
   - In Railway dashboard, go to **Variables**
   - Add:
     ```
     PORT=8000
     NODE_ENV=production
     ```

4. **Click Deploy**

5. **Get your live API URL**:
   - In Railway, go to **Settings** → **Domains**
   - You'll see your public URL like: `https://oneeleven-production.up.railway.app`

---

## Part 3: Connect Frontend to Backend

Update your frontend to use the live API:

1. Go to your Netlify site
2. Open browser DevTools (F12) → Console
3. In your HTML form, the default API URL is `http://127.0.0.1:8000`
4. Change it to your Railway API URL when testing

Or edit `public/index.html` line ~233:
```javascript
value="https://your-railway-api-url.up.railway.app"
```

---

## Final URLs

After deployment:
- **Frontend**: https://your-site-name.netlify.app
- **API**: https://your-railway-api-url.up.railway.app

---

## Testing

1. Open your Netlify frontend URL in browser
2. In the "API Endpoint" field, enter your Railway API URL
3. Enter a word and click "Run Sort"
4. You should see the sorted characters!

---

## Environment Variables

For production, the `.env` file is not pushed to GitHub. Railway will use the variables you set in their dashboard.

Make sure `.env` is in `.gitignore` (it already is).
