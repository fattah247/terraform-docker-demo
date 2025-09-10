from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "Hello from Docker on EC2 via Terraform + GitHub Actions! (2025-09-10 21:15:32)"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
