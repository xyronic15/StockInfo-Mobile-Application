from flask import Flask, request

app = Flask(__name__)

@app.route('/login', methods=['POST'])
def login_user():
    print(request.is_json)
    data = request.get_json()
    print(data)
    return 'JSON posted'

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000)
    