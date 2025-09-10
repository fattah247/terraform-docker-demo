from flask import Flask
app = Flask(__name__)

@app.route("/")
def home():
    return "Hello from Docker (Actions deploy) on EC2 via Terraform + GitHub Actions - 2025-09-10 17:30:14!