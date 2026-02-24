"""
Quick test script to verify the setup is correct.
Run this before running the main app to check for issues.
"""

import importlib.util
import os
import sqlite3

def test_dependencies():
    """Test if required packages are installed."""
    print("Testing dependencies...")
    if importlib.util.find_spec("openai") is not None:
        print("✅ OpenAI package installed")
        return True
    print("❌ OpenAI package not installed. Run: pip install -r requirements.txt")
    return False

def test_api_key():
    """Test if API key is set."""
    print("\nTesting API key...")
    api_key = os.getenv('OPENAI_API_KEY')
    if api_key:
        print(f"✅ API key found (length: {len(api_key)} characters)")
        return True
    else:
        print("❌ OPENAI_API_KEY environment variable not set!")
        print("   Set it using: export OPENAI_API_KEY='your-key-here'")
        print("   Or on Windows: set OPENAI_API_KEY=your-key-here")
        return False

def test_files():
    """Test if required files exist."""
    print("\nTesting files...")
    files = ['schema.sql', 'insert_data.sql', 'app.py']
    all_exist = True
    
    for file in files:
        if os.path.exists(file):
            print(f"✅ {file} exists")
        else:
            print(f"❌ {file} not found!")
            all_exist = False
    
    return all_exist

def test_database_creation():
    """Test if database can be created."""
    print("\nTesting database creation...")
    try:
        if os.path.exists('baliTricks.db'):
            print("⚠️  baliTricks.db already exists (will be reused)")
        else:
            conn = sqlite3.connect('baliTricks.db')
            conn.close()
            os.remove('baliTricks.db')
            print("✅ Database can be created")
        return True
    except Exception as e:
        print(f"❌ Database creation failed: {e}")
        return False

def main():
    print("=" * 60)
    print("Setup Verification")
    print("=" * 60)
    
    results = [
        test_dependencies(),
        test_api_key(),
        test_files(),
        test_database_creation()
    ]
    
    print("\n" + "=" * 60)
    if all(results):
        print("✅ All checks passed! You're ready to run app.py")
    else:
        print("❌ Some checks failed. Please fix the issues above.")
    print("=" * 60)

if __name__ == "__main__":
    main()
