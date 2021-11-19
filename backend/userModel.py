from flask import Flask, request

app = Flask(__name__)

@app.route('/login', methods=['POST'])
def login_user():
    print(request.is_json)
    data = request.get_json()
    print(data)

    # TODO add database verification

    return 'JSON posted'

@app.route('/signup', methods=['PUT'])
def signup_user():
    print(request.is_json)
    data = request.get_json()
    print(data)

    # TODO insert into database
    return 'JSON put'

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000)
    