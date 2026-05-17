# Supabase MCP Server (HTTP/SSE wrapper)

Wraps the official [`@supabase/mcp-server-supabase`](https://www.npmjs.com/package/@supabase/mcp-server-supabase) (STDIO transport) with [`mcp-proxy`](https://www.npmjs.com/package/mcp-proxy) so it exposes an HTTP/SSE endpoint that **n8n's MCP Client Tool** can call.

## Deploy on Railway

1. Push this folder to a GitHub repository.
2. https://railway.app → **New Project** → **Deploy from GitHub repo** → select this repo.
3. Railway detects the Dockerfile and builds automatically.
4. Go to the service → **Variables** → add:
   - `SUPABASE_ACCESS_TOKEN` = your Supabase Personal Access Token (starts with `sbp_...`)
5. Service → **Settings** → **Networking** → **Generate Domain**.
6. Your endpoint URLs:
   - **SSE:** `https://YOUR-RAILWAY-DOMAIN/sse`
   - **Message:** `https://YOUR-RAILWAY-DOMAIN/message`
7. In n8n's **MCP Client Tool** node, use:
   - **Endpoint:** the SSE URL above
   - **Transport:** SSE

## Local test

```bash
docker build -t supabase-mcp .
docker run --rm -p 8080:8080 \
  -e SUPABASE_ACCESS_TOKEN=sbp_your_token \
  supabase-mcp
# then in another terminal:
curl http://localhost:8080/sse
```
