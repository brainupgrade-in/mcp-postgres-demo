-- MCP + PostgreSQL Demo - Read-Only AI User
-- Video 5: MCP Masterclass by Gheware DevOps AI

-- SECURITY: Create a read-only user for AI access
-- NEVER give AI write access to your database!

-- Create the read-only user
CREATE USER ai_reader WITH PASSWORD 'demo123';

-- Grant connect permission
GRANT CONNECT ON DATABASE ecommerce TO ai_reader;

-- Grant usage on schema
GRANT USAGE ON SCHEMA public TO ai_reader;

-- Grant SELECT only on all tables
GRANT SELECT ON ALL TABLES IN SCHEMA public TO ai_reader;

-- Grant SELECT on future tables too
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO ai_reader;

-- Verify permissions
DO $$
BEGIN
    RAISE NOTICE 'Read-only user ai_reader created successfully!';
    RAISE NOTICE 'Connection string: postgresql://ai_reader:demo123@localhost:5432/ecommerce';
END $$;
