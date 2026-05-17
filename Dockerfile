# Wraps the official @supabase/mcp-server-supabase (STDIO) with mcp-proxy
# to expose it as an HTTP/SSE endpoint that n8n's MCP Client Tool can call.

FROM node:20-alpine

WORKDIR /app

# Install both packages globally so we can spawn them as commands.
RUN npm install -g \
      @supabase/mcp-server-supabase@latest \
      mcp-proxy@latest

# Railway provides $PORT at runtime. Default to 8080 locally.
ENV PORT=8080
EXPOSE 8080

# mcp-proxy starts an HTTP/SSE bridge and proxies stdio to the Supabase MCP server.
# SUPABASE_ACCESS_TOKEN must be set as an env var on the Railway service.
CMD ["sh", "-c", "mcp-proxy --port ${PORT} --sse-path /sse --message-path /message -- npx -y @supabase/mcp-server-supabase --access-token ${SUPABASE_ACCESS_TOKEN}"]
