from flask import Flask
app = Flask(__name__)

@app.route("/")
def home():
    return "Hello from Docker on EC2 via Terraform + GitHub Actions!"
