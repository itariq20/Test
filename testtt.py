# app.py - A template for a Python web application

import os
import sqlite3
from flask import Flask, request, render_template_string, redirect, url_for, send_from_directory

app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = 'uploads'
app.config['DATABASE'] = 'database.db'

# Ensure upload directory exists
if not os.path.exists(app.config['UPLOAD_FOLDER']):
    os.makedirs(app.config['UPLOAD_FOLDER'])

def get_db():
    db = getattr(g, '_database', None)
    if db is None:
        db = g._database = sqlite3.connect(app.config['DATABASE'])
        db.row_factory = sqlite3.Row
    return db

@app.teardown_appcontext
def close_connection(exception):
    db = getattr(g, '_database', None)
    if db is not None:
        db.close()

def init_db():
    with app.app_context():
        db = get_db()
        with app.open_resource('schema.sql', mode='r') as f:
            db.cursor().executescript(f.read())
        db.commit()

# --- Routes ---

@app.route('/')
def index():
    user_input = request.args.get('name', 'Guest')
    # This line could be made vulnerable to XSS
    return render_template_string(f"<h1>Hello, {user_input}!</h1><p>Welcome to the example app.</p><p><a href='/upload'>Upload a file</a> | <a href='/search'>Search database</a></p>")

@app.route('/upload', methods=['GET', 'POST'])
def upload_file():
    if request.method == 'POST':
        if 'file' not in request.files:
            return redirect(request.url)
        file = request.files['file']
        if file.filename == '':
            return redirect(request.url)
        if file:
            filename = file.filename
            # This line could be made vulnerable to path traversal
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            return f"File '{filename}' uploaded successfully!"
    return '''
    <!doctype html>
    <title>Upload new File</title>
    <h1>Upload new File</h1>
    <form method=post enctype=multipart/form-data>
      <input type=file name=file>
      <input type=submit value=Upload>
    </form>
    '''

@app.route('/uploads/<name>')
def download_file(name):
    # This line could be made vulnerable to directory traversal
    return send_from_directory(app.config['UPLOAD_FOLDER'], name)

@app.route('/search', methods=['GET'])
def search_database():
    query = request.args.get('q', '')
    if query:
        db = get_db()
        # This line is intentionally left vulnerable to SQL Injection
        cursor = db.execute(f"SELECT * FROM users WHERE username LIKE '%{query}%'")
        results = cursor.fetchall()
        
        output = "<h2>Search Results:</h2><ul>"
        if results:
            for row in results:
                output += f"<li>User ID: {row['id']}, Username: {row['username']}</li>"
        else:
            output += "<li>No results found.</li>"
        output += "</ul>"
        return output
    return '''
    <!doctype html>
    <title>Search Users</title>
    <h1>Search Users</h1>
    <form method=get action="/search">
      <input type=text name=q placeholder="Enter username...">
      <input type=submit value=Search>
    </form>
    '''

@app.route('/admin')
def admin_panel():
    # This would typically require authentication
    # Example: Insecure direct object reference (IDOR) could be here
    # Or weak authentication leading to bypass
    return "<h3>Admin Panel - Restricted Access</h3>"

if __name__ == '__main__':
    from flask import g # g is part of Flask's application context
    # Create a dummy schema.sql for the database setup
    with open('schema.sql', 'w') as f:
        f.write('''
            DROP TABLE IF EXISTS users;
            CREATE TABLE users (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                username TEXT NOT NULL UNIQUE,
                password TEXT NOT NULL
            );
            INSERT INTO users (username, password) VALUES ('admin', 'password123');
            INSERT INTO users (username, password) VALUES ('testuser', 'testpass');
        ''')
    init_db()
    app.run(debug=True) # debug=True is also a security risk in production
