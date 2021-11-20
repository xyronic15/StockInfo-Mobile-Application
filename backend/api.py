from enum import auto
from flask import Flask, request
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///stocks-app.db'

db = SQLAlchemy(app)

class User(db.Model):
    __tablename__ = 'users'
    id = db.Column(db.Integer, nullable = False, primary_key = True)
    firstname = db.Column(db.String(200), nullable = False)
    lastname = db.Column(db.String(200), nullable = False)
    email = db.Column(db.String(200), nullable = False)
    username = db.Column(db.String(200), nullable = False)
    password = db.Column(db.String(200), nullable = False)

    def serialize(self):
        return {
            "firstname": self.first_name,
            "lastname": self.last_name,
            "email": self.email,
            "username": self.username,
            "password": self.password
        }
    
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
    
    f_name = data['firstname']
    l_name = data['lastname']
    email = data['email']
    username = data['username']
    password = data['password']

    # create new user
    new_user = User (
        firstname = f_name,
        lastname = l_name,
        email = email,
        username = username,
        password = password
    )

    # add new user to db
    try:
        db.session.add(new_user)
        db.session.commit()
        return 'New user added', 200
    except:
        return "Error adding new user", 400

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000)

