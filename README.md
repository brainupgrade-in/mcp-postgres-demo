# MCP + PostgreSQL Demo

A sample project demonstrating how to connect Claude AI to a PostgreSQL database using MCP (Model Context Protocol).

**Tutorial companion for:** [Video 5: MCP + Database](https://www.youtube.com/@gheware-devops-ai) from [Gheware DevOps AI](https://www.youtube.com/@gheware-devops-ai) MCP Masterclass.

## What You'll Learn

- Connect Claude to a PostgreSQL database
- Ask questions in plain English
- Get SQL queries automatically generated
- See real database results

## Quick Start

### 1. Start the Sample Database

```bash
docker-compose up -d
```

This creates a PostgreSQL database with sample e-commerce data.

### 2. Configure MCP Server

Add to your Claude Desktop config:

**macOS:** `~/Library/Application Support/Claude/claude_desktop_config.json`
**Windows:** `%APPDATA%\Claude\claude_desktop_config.json`
**Linux:** `~/.config/Claude/claude_desktop_config.json`

```json
{
  "mcpServers": {
    "postgres": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres", "postgresql://ai_reader:demo123@localhost:5432/ecommerce"]
    }
  }
}
```

Or with Claude Code CLI:

```bash
claude mcp add postgres -- npx -y @modelcontextprotocol/server-postgres "postgresql://ai_reader:demo123@localhost:5432/ecommerce"
```

### 3. Restart Claude Desktop

### 4. Try These Queries

```
"What tables are in this database?"
"Show me the top 10 customers by total order value"
"What were the orders from last month over $100?"
"Show monthly revenue trend"
"Which products are running low on stock?"
```

## Sample Database Schema

| Table | Description |
|-------|-------------|
| `customers` | Customer information (name, email, city) |
| `products` | Product catalog (name, price, stock) |
| `orders` | Order headers (customer, date, total) |
| `order_items` | Order line items (product, quantity, price) |

## Example Queries Explained

| Natural Language | What Claude Generates |
|-----------------|----------------------|
| "Top 10 customers by order value" | `SELECT ... SUM() ... GROUP BY ... ORDER BY ... LIMIT 10` |
| "Orders from last month" | `SELECT ... WHERE order_date >= ...` |
| "Average order by category" | `SELECT ... AVG() ... GROUP BY category` |
| "Customer with most recent order" | `SELECT ... JOIN ... ORDER BY ... LIMIT 1` |

## Security Best Practices

**IMPORTANT:** Always use read-only credentials for AI access!

This demo includes a read-only user (`ai_reader`) with SELECT-only permissions:

```sql
CREATE USER ai_reader WITH PASSWORD 'demo123';
GRANT CONNECT ON DATABASE ecommerce TO ai_reader;
GRANT USAGE ON SCHEMA public TO ai_reader;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO ai_reader;
```

### Production Recommendations

1. **Read-only user** - Never give AI write access
2. **Limited tables** - Only expose necessary tables
3. **No sensitive data** - Exclude PII, passwords, secrets
4. **Separate database** - Use analytics replica if possible
5. **Audit logging** - Track all AI queries

## Files in This Repo

| File | Purpose |
|------|---------|
| `docker-compose.yml` | Start PostgreSQL with sample data |
| `init/01-schema.sql` | Database schema |
| `init/02-sample-data.sql` | Sample e-commerce data |
| `init/03-read-only-user.sql` | Read-only AI user setup |
| `mcp-database-guide.md` | Detailed setup guide |

## MCP Masterclass Videos

| # | Video | Status |
|---|-------|--------|
| 1 | [What is MCP?](https://www.youtube.com/watch?v=sMzEGEv-6-4) | Published |
| 2 | [MCP Architecture](https://www.youtube.com/watch?v=t7O9T6UxK5k) | Published |
| 3 | [Install MCP Server](https://www.youtube.com/watch?v=lbLNb2eNmf8) | Published |
| 4 | [Build Your Own Server](https://www.youtube.com/watch?v=xLASLzK3w90) | Published |
| 5 | **MCP + Database** | YOU ARE HERE |

## Resources

- [PostgreSQL MCP Server](https://github.com/modelcontextprotocol/servers/tree/main/src/postgres)
- [MCP Documentation](https://modelcontextprotocol.io)
- [MCP Server Examples](https://github.com/modelcontextprotocol/servers)

---

Made with love by [Gheware DevOps AI](https://www.youtube.com/@gheware-devops-ai)
