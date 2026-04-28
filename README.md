# Fly.io Worker v0.02

Small standalone Node.js worker prepared for Fly.io deployment.

## What Is In This Repo

- `worker-v0.02.js` - compiled worker
- `Dockerfile` - container image for Fly.io
- `fly.toml.example` - Fly.io config template
- `.env.example` - required environment variables

## GitHub Setup

Create a new private GitHub repository with a neutral name, for example:

- `fly-io-worker-v0.02`
- `fly-runtime-v0.02`
- `fly-scheduled-worker-v0.02`

Then push this folder:

```bash
git init
git add .
git commit -m "Add Fly.io worker v0.02"
git branch -M main
git remote add origin git@github.com:YOUR_USER/fly-io-worker-v0.02.git
git push -u origin main
```

## Fly.io Setup From GitHub

In Fly.io dashboard:

1. Open **Dashboard**.
2. Choose **Launch from GitHub** / **GitHub Install Application**.
3. Install the Fly.io GitHub app for this repository.
4. Select this repository.
5. Use Dockerfile deployment.
6. Before deploy, create a Fly volume named `worker_data` mounted to `/data`.
7. Add secrets from `.env.example`.

## Fly CLI Setup

If the GitHub path asks for existing config, create `fly.toml` from the template:

```bash
APP=your-unique-fly-app-name
cp fly.toml.example fly.toml
perl -pi -e "s/CHANGE_ME/$APP/g" fly.toml
```

Create persistent volume:

```bash
fly volumes create worker_data --size 1 --region ams --app "$APP"
```

Set secrets:

```bash
fly secrets set --app "$APP" \
  SFL_FARM_ID="YOUR_FARM_ID" \
  SFL_FARM_NAME="YOUR_FARM_NAME" \
  SFL_API_KEY="YOUR_FARM_API_KEY" \
  SFL_MARKET_AUTH_TOKEN="YOUR_JWT_RAW_TOKEN" \
  SFL_CONFIG_SECRET="LONG_RANDOM_SECRET" \
  TELEGRAM_BOT_TOKEN="YOUR_TELEGRAM_BOT_TOKEN" \
  TELEGRAM_ADMIN_CHAT_ID="YOUR_TELEGRAM_CHAT_ID" \
  TELEGRAM_CHAT_ID="YOUR_TELEGRAM_CHAT_ID"
```

Deploy:

```bash
fly deploy --app "$APP"
```

Check logs:

```bash
fly logs --app "$APP"
```

## Telegram Commands

- `/setfarm <farmId> [name]`
- `/setapikey <apiKey>`
- `/settoken <jwt>`
- `/check`
- `/status`
- `/spreads`
- `/outbids`
- `/pause`
- `/resume`

Keep the repository private. Do not commit real `.env` files or secrets.
