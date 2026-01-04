# MCP + Database: Complete Setup Guide

> **Last Updated:** January 2026

This guide accompanies **Video 5: MCP + Database** from the [Gheware DevOps AI](https://www.youtube.com/@gheware-devops-ai) MCP Masterclass.

---

## Video Timeline

| Time | Section | Jump To |
|------|---------|---------|
| 0:00 | What we're building | [Introduction](#introduction) |
| 0:45 | Install PostgreSQL MCP server | [Step 1: Install](#step-1-install-postgresql-mcp-server-045) |
| 2:00 | Connect to sample database | [Step 2: Connect](#step-2-connect-to-database-200) |
| 3:30 | First query: "List all tables" | [Step 3: First Queries](#step-3-first-queries-330) |
| 4:30 | Real query: "Top 10 customers" | [Step 4: Real Queries](#step-4-real-queries-430) |
| 6:00 | Complex query: "Monthly revenue" | [Step 5: Complex Queries](#step-5-complex-queries-600) |
| 7:30 | Security: Read-only mode | [Security](#security-best-practices-730) |
| 8:30 | Real use case: Business reports | [Use Cases](#real-use-cases-830) |
| 9:30 | Series wrap-up | [Next Steps](#next-steps) |

---

## Introduction

"Show me top customers from last month" → AI queries your database and returns results.

This is the **MCP promise in action**. In this video, you'll connect Claude to a PostgreSQL database and ask questions in **plain English**.

**What you'll achieve:**
- Type natural language questions
- Claude generates SQL automatically
- See real database results
- No SQL expertise required

---

## Step 1: Install PostgreSQL MCP Server (0:45)

### Option A: Using Claude Desktop

Add to your Claude Desktop config:

**macOS:** `~/Library/Application Support/Claude/claude_desktop_config.json`
**Windows:** `%APPDATA%\Claude\claude_desktop_config.json`
**Linux:** `~/.config/Claude/claude_desktop_config.json`

```json
{
  "mcpServers": {
    "postgres": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-postgres",
        "postgresql://ai_reader:demo123@localhost:5432/ecommerce"
      ]
    }
  }
}
```

### Option B: Using Claude Code CLI

```bash
claude mcp add postgres -- npx -y @modelcontextprotocol/server-postgres "postgresql://ai_reader:demo123@localhost:5432/ecommerce"
```

**Verify connection:**

```bash
claude mcp list
```

Expected output:
```
postgres: npx -y @modelcontextprotocol/server-postgres postgresql://... - Connected
```

---

## Step 2: Connect to Database (2:00)

### Start the Sample Database

```bash
# Clone this repo
git clone https://github.com/brainupgrade-in/mcp-postgres-demo.git
cd mcp-postgres-demo

# Start PostgreSQL with sample data
docker-compose up -d

# Verify it's running
docker ps
```

### Connection String Breakdown

```
postgresql://ai_reader:demo123@localhost:5432/ecommerce
            └────┬────┘└──┬──┘ └───┬───┘ └─┬─┘ └───┬───┘
            username  password   host   port  database
```

| Component | Value | Description |
|-----------|-------|-------------|
| Username | `ai_reader` | Read-only user |
| Password | `demo123` | Demo password |
| Host | `localhost` | Database server |
| Port | `5432` | PostgreSQL default |
| Database | `ecommerce` | Sample database |

---

## Step 3: First Queries (3:30)

### Explore the Database

Try these prompts in Claude:

**Check connection:**
```
"Check the database connection status"
```

**List tables:**
```
"What tables are in this database?"
```

Expected result:
- categories
- products
- customers
- orders
- order_items

**Describe a table:**
```
"Show me the columns in the customers table"
```

**Count records:**
```
"How many customers do we have?"
```

---

## Step 4: Real Queries (4:30)

### Business Questions

**Top customers:**
```
"Show me the top 10 customers by total order value"
```

Claude generates:
```sql
SELECT c.name, c.email, SUM(o.total_amount) as total_spent
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.id, c.name, c.email
ORDER BY total_spent DESC
LIMIT 10;
```

**Recent orders:**
```
"What orders came in during the last month over $100?"
```

**Category performance:**
```
"What's the average order value by product category?"
```

**Low stock alert:**
```
"Which products have less than 100 items in stock?"
```

---

## Step 5: Complex Queries (6:00)

### Advanced Analytics

**Monthly revenue trend:**
```
"Show me the monthly revenue for the past 6 months"
```

Claude generates date extraction, grouping, and aggregation:
```sql
SELECT
    DATE_TRUNC('month', order_date) as month,
    SUM(total_amount) as revenue,
    COUNT(*) as order_count
FROM orders
WHERE order_date >= CURRENT_DATE - INTERVAL '6 months'
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;
```

**Customer with most recent order:**
```
"Who made the most recent purchase and what did they buy?"
```

**Product performance:**
```
"Which products generated the most revenue last quarter?"
```

---

## Security Best Practices (7:30)

### CRITICAL: Always Use Read-Only Access!

**Why read-only?**
- AI can't accidentally DELETE data
- AI can't UPDATE incorrect values
- AI can't DROP tables
- Protects against prompt injection attacks

### Create Read-Only User

```sql
-- Create user with password
CREATE USER ai_reader WITH PASSWORD 'secure_password_here';

-- Grant database connection
GRANT CONNECT ON DATABASE ecommerce TO ai_reader;

-- Grant schema access
GRANT USAGE ON SCHEMA public TO ai_reader;

-- Grant SELECT ONLY on all tables
GRANT SELECT ON ALL TABLES IN SCHEMA public TO ai_reader;

-- Apply to future tables too
ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT ON TABLES TO ai_reader;
```

### Production Checklist

| Practice | Why |
|----------|-----|
| Read-only user | Prevent accidental writes |
| Limited tables | Only expose necessary data |
| No sensitive data | Exclude PII, passwords |
| Separate database | Use analytics replica |
| Audit logging | Track all AI queries |
| Connection limits | Prevent resource exhaustion |

### Exclude Sensitive Columns

```sql
-- Create a view that hides sensitive data
CREATE VIEW safe_customers AS
SELECT id, name, city, country, created_at
FROM customers;
-- (excludes email)

-- Grant access to view only
GRANT SELECT ON safe_customers TO ai_reader;
REVOKE SELECT ON customers FROM ai_reader;
```

---

## Real Use Cases (8:30)

### Daily Operations

| Question | Business Value |
|----------|---------------|
| "Yesterday's total sales?" | Quick daily check |
| "Orders stuck in pending?" | Operations monitoring |
| "Low stock products?" | Inventory management |
| "New customers this week?" | Growth tracking |

### Ad-Hoc Analysis

**Scenario:** CEO asks "How did California perform in Q4?"

**Before MCP:**
- Write SQL query (10 min)
- Run and verify (5 min)
- Format results (5 min)
- Total: 20+ minutes

**With MCP:**
```
"Show me total revenue and order count from California customers in Q4 2025"
```
- Total: 30 seconds

### Report Generation

```
"Create a summary of this month's performance:
- Total revenue
- Number of orders
- Top 5 products
- Top 5 customers"
```

---

## Sample Queries Reference

### Easy (Beginners)

```
"List all products"
"How many orders do we have?"
"Show all customers from California"
"What's the most expensive product?"
```

### Medium (Intermediate)

```
"Top 10 customers by order count"
"Products never ordered"
"Average order value by month"
"Customers who ordered in the last 7 days"
```

### Hard (Advanced)

```
"Customer retention: who ordered more than once?"
"Month-over-month revenue growth percentage"
"Products frequently bought together"
"Customers who haven't ordered in 90 days"
```

---

## Troubleshooting

### Connection Failed

```
Error: Connection refused
```

**Fix:** Ensure PostgreSQL is running:
```bash
docker-compose up -d
docker ps  # Should show mcp-postgres-demo
```

### Authentication Failed

```
Error: Password authentication failed
```

**Fix:** Verify credentials in connection string match the database user.

### Permission Denied

```
Error: Permission denied for table
```

**Fix:** Grant SELECT permission:
```sql
GRANT SELECT ON ALL TABLES IN SCHEMA public TO ai_reader;
```

### Slow Queries

**Tip:** Add indexes for frequently queried columns:
```sql
CREATE INDEX idx_orders_date ON orders(order_date);
CREATE INDEX idx_customers_city ON customers(city);
```

---

## Next Steps

### MCP Masterclass Complete!

You've learned:
1. What MCP is and why it matters
2. MCP architecture (Host, Client, Server)
3. Installing pre-built MCP servers
4. Building your own MCP server
5. Real-world database integration

### Continue Learning

- **Explore more servers:** [github.com/modelcontextprotocol/servers](https://github.com/modelcontextprotocol/servers)
  - GitHub server
  - Slack server
  - Notion server
  - File system server

- **Build custom servers:** Use the patterns from Video 4

- **Join the community:** Follow MCP updates on GitHub

---

## Files in This Repository

| File | Purpose |
|------|---------|
| `README.md` | Quick start guide |
| `docker-compose.yml` | PostgreSQL container setup |
| `init/01-schema.sql` | Database tables |
| `init/02-sample-data.sql` | Sample e-commerce data |
| `init/03-read-only-user.sql` | Secure AI user |
| `mcp-database-guide.md` | This detailed guide |

---

## MCP Masterclass Videos

| # | Video | Link |
|---|-------|------|
| 1 | What is MCP? | [Watch](https://www.youtube.com/watch?v=sMzEGEv-6-4) |
| 2 | MCP Architecture | [Watch](https://www.youtube.com/watch?v=t7O9T6UxK5k) |
| 3 | Install MCP Server | [Watch](https://www.youtube.com/watch?v=lbLNb2eNmf8) |
| 4 | Build Your Own Server | [Watch](https://www.youtube.com/watch?v=xLASLzK3w90) |
| 5 | **MCP + Database** | YOU ARE HERE |

---

## Resources

- [PostgreSQL MCP Server](https://github.com/modelcontextprotocol/servers/tree/main/src/postgres)
- [MCP Documentation](https://modelcontextprotocol.io)
- [MCP Security Guide](https://modelcontextprotocol.io/docs/concepts/security)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)

---

Made with love by [Gheware DevOps AI](https://www.youtube.com/@gheware-devops-ai)
