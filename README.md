# Natural Language SQL Interface Project

## Description
This project implements a natural language interface to a balisong (butterfly knife) tricks tracking database using OpenAI's GPT models. Users can ask questions in plain English and receive answers in natural language, with the system automatically generating and executing SQL queries.

## Database Purpose
The database models a balisong tricks tracking system, tracking knives, tricks, practice sessions, trick progress, and maintenance events. This allows for queries about knife collections, trick difficulty and mastery, practice session statistics, and maintenance history.

## Setup Instructions

1. **Install Python dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

2. **Set up OpenAI API Key:**
   - Get an API key from https://platform.openai.com/api-keys
   - Set it as an environment variable:
     - Windows: `set OPENAI_API_KEY=your-key-here`
     - Linux/Mac: `export OPENAI_API_KEY=your-key-here`

3. **Run the application:**
   ```bash
   python app.py
   ```

## Schema
The database includes the following tables:
- `knife` - Information about balisong knives (brand, pivot type, condition, etc.)
- `trick` - Tricks that can be performed (difficulty, category, description)
- `practice_session` - Practice sessions with date, duration, and notes
- `trick_progress` - Tracks which tricks have been learned with which knives (many-to-many)
- `session_tricks` - Tracks which tricks were practiced in which sessions (many-to-many)
- `maintenance_event` - Maintenance history for knives (cleaning, oiling, tuning)

## Prompting Strategies

The application supports three prompting strategies (as described in the paper):

1. **zero_shot** (default) - Provides only the schema and question
2. **few_shot** - Includes example question-SQL pairs
3. **chain_of_thought** - Asks GPT to think step by step

Switch strategies during runtime using: `strategy <name>`

## Example Questions

See `examples.md` for detailed examples of questions, SQL queries, and responses.

## Files

- `schema.sql` - Database schema definition
- `insert_data.sql` - Sample data
- `app.py` - Main application
- `requirements.txt` - Python dependencies
- `baliTricks.db` - SQLite database (created on first run)
