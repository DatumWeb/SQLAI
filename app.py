"""
Natural Language SQL Interface using OpenAI
This app allows users to ask questions in plain English and get answers from the database.
"""

import sqlite3
import os
import json
from openai import OpenAI
from typing import Optional, Dict, List, Tuple

# Initialize OpenAI client
# Make sure to set OPENAI_API_KEY environment variable or replace with your key
client = OpenAI(api_key=os.getenv('OPENAI_API_KEY'))

DB_PATH = 'baliTricks.db'
SCHEMA_FILE = 'schema.sql'

def get_database_schema() -> str:
    """Read and return the database schema as a string."""
    try:
        with open(SCHEMA_FILE, 'r') as f:
            return f.read()
    except FileNotFoundError:
        return ""

def get_table_schema_from_db() -> str:
    """Get the actual schema from the database by querying sqlite_master."""
    if not os.path.exists(DB_PATH):
        # If database doesn't exist, return schema from file
        return get_database_schema()
    
    try:
        conn = sqlite3.connect(DB_PATH)
        cursor = conn.cursor()
        
        # Get all table schemas
        cursor.execute("""
            SELECT sql FROM sqlite_master 
            WHERE type='table' AND name NOT LIKE 'sqlite_%'
            ORDER BY name
        """)
        
        schemas = cursor.fetchall()
        conn.close()
        
        result = '\n\n'.join([schema[0] for schema in schemas if schema[0]])
        # Fallback to file if database is empty
        return result if result else get_database_schema()
    except Exception:
        # Fallback to file schema if database read fails
        return get_database_schema()

def generate_sql_query(user_question: str, strategy: str = "zero_shot") -> Optional[str]:
    """
    Use OpenAI to generate SQL query from natural language question.
    
    Strategies:
    - zero_shot: Just provide schema and question
    - few_shot: Provide schema, question, and examples
    - chain_of_thought: Ask GPT to think step by step
    """
    schema = get_table_schema_from_db()
    
    if strategy == "zero_shot":
        prompt = f"""You are a SQL expert. Given the following database schema, write a SQLite SQL query to answer the user's question.

Database Schema:
{schema}

User Question: {user_question}

Return ONLY the SQL query, nothing else. Do not include explanations or markdown formatting."""
    
    elif strategy == "few_shot":
        prompt = f"""You are a SQL expert. Given the following database schema, write a SQLite SQL query to answer the user's question.

Database Schema:
{schema}

Examples:
Question: "How many restaurants do we have?"
SQL: SELECT COUNT(*) FROM restaurant;

Question: "What is the average price of menu items?"
SQL: SELECT AVG(price) FROM menu_item;

Question: "Show me all Italian restaurants"
SQL: SELECT * FROM restaurant WHERE cuisine_type = 'Italian';

User Question: {user_question}

Return ONLY the SQL query, nothing else. Do not include explanations or markdown formatting."""
    
    elif strategy == "chain_of_thought":
        prompt = f"""You are a SQL expert. Given the following database schema, write a SQLite SQL query to answer the user's question.

Database Schema:
{schema}

Think step by step:
1. Identify which tables are needed
2. Determine what columns to select
3. Consider any joins, filters, or aggregations needed
4. Write the SQL query

User Question: {user_question}

Return ONLY the SQL query, nothing else. Do not include explanations or markdown formatting."""
    
    else:
        prompt = f"""You are a SQL expert. Given the following database schema, write a SQLite SQL query to answer the user's question.

Database Schema:
{schema}

User Question: {user_question}

Return ONLY the SQL query, nothing else. Do not include explanations or markdown formatting."""
    
    try:
        response = client.chat.completions.create(
            model="gpt-3.5-turbo",
            messages=[
                {"role": "system", "content": "You are a SQL expert. Return only SQL queries without explanations."},
                {"role": "user", "content": prompt}
            ],
            temperature=0.1
        )
        
        sql_query = response.choices[0].message.content.strip()
        
        # Remove markdown code blocks if present
        if sql_query.startswith("```"):
            sql_query = sql_query.split("```")[1]
            if sql_query.startswith("sql"):
                sql_query = sql_query[3:]
            sql_query = sql_query.strip()
        
        return sql_query
    except Exception as e:
        print(f"Error generating SQL: {e}")
        return None

def execute_query(sql_query: str) -> Tuple[List[Dict], Optional[str]]:
    """Execute SQL query and return results."""
    try:
        conn = sqlite3.connect(DB_PATH)
        conn.row_factory = sqlite3.Row  # Return rows as dictionaries
        cursor = conn.cursor()
        
        cursor.execute(sql_query)
        
        # Fetch results
        rows = cursor.fetchall()
        results = [dict(row) for row in rows]
        
        conn.close()
        return results, None
    except sqlite3.Error as e:
        return [], str(e)
    except Exception as e:
        return [], str(e)

def generate_natural_language_response(user_question: str, sql_query: str, query_results: List[Dict], error: Optional[str] = None) -> str:
    """Use OpenAI to convert query results into natural language response."""
    if error:
        return f"I encountered an error executing the query: {error}"
    
    if not query_results:
        return "The query returned no results."
    
    # Convert results to readable format
    results_str = json.dumps(query_results, indent=2)
    
    prompt = f"""The user asked: "{user_question}"

The SQL query executed was: {sql_query}

The query results are:
{results_str}

Provide a clear, natural language answer to the user's question based on these results. Be concise and friendly."""
    
    try:
        response = client.chat.completions.create(
            model="gpt-3.5-turbo",
            messages=[
                {"role": "system", "content": "You are a helpful assistant that explains database query results in natural language."},
                {"role": "user", "content": prompt}
            ],
            temperature=0.7
        )
        
        return response.choices[0].message.content.strip()
    except Exception as e:
        # Fallback to simple response if OpenAI fails
        return f"Query returned {len(query_results)} result(s). Results: {results_str}"

def initialize_database():
    """Initialize the database with schema and sample data."""
    if os.path.exists(DB_PATH):
        print(f"Database {DB_PATH} already exists.")
        return
    
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    
    # Read and execute schema
    with open(SCHEMA_FILE, 'r') as f:
        schema_sql = f.read()
        cursor.executescript(schema_sql)
    
    # Read and execute sample data
    with open('insert_data.sql', 'r') as f:
        data_sql = f.read()
        cursor.executescript(data_sql)
    
    conn.commit()
    conn.close()
    print(f"Database {DB_PATH} initialized successfully!")

def main():
    """Main interactive loop."""
    print("=" * 60)
    print("Natural Language SQL Interface - BaliTricks Database")
    print("=" * 60)
    print("\nAvailable prompting strategies:")
    print("1. zero_shot (default)")
    print("2. few_shot")
    print("3. chain_of_thought")
    print("\nType 'exit' to quit, 'strategy <name>' to change strategy")
    print("=" * 60)
    
    # Initialize database
    initialize_database()
    
    current_strategy = "zero_shot"
    
    while True:
        print(f"\n[Strategy: {current_strategy}]")
        user_input = input("\nAsk a question: ").strip()
        
        if user_input.lower() == 'exit':
            print("Goodbye!")
            break
        
        if user_input.lower().startswith('strategy '):
            new_strategy = user_input.split(' ', 1)[1].strip()
            if new_strategy in ['zero_shot', 'few_shot', 'chain_of_thought']:
                current_strategy = new_strategy
                print(f"Switched to {current_strategy} strategy.")
            else:
                print("Invalid strategy. Use: zero_shot, few_shot, or chain_of_thought")
            continue
        
        if not user_input:
            continue
        
        print("\nGenerating SQL query...")
        sql_query = generate_sql_query(user_input, current_strategy)
        
        if not sql_query:
            print("Failed to generate SQL query.")
            continue
        
        print(f"Generated SQL: {sql_query}\n")
        
        print("Executing query...")
        results, error = execute_query(sql_query)
        
        if error:
            print(f"Error: {error}")
            response = generate_natural_language_response(user_input, sql_query, results, error)
        else:
            print(f"Query returned {len(results)} result(s)")
            print("Generating natural language response...")
            response = generate_natural_language_response(user_input, sql_query, results)
        
        print("\n" + "=" * 60)
        print("Answer:")
        print(response)
        print("=" * 60)

if __name__ == "__main__":
    # Check for API key
    if not os.getenv('OPENAI_API_KEY'):
        print("ERROR: OPENAI_API_KEY environment variable not set!")
        print("Please set it using: export OPENAI_API_KEY='your-key-here'")
        print("Or on Windows: set OPENAI_API_KEY=your-key-here")
        exit(1)
    
    main()
