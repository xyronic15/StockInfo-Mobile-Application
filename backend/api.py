from enum import auto
from flask import Flask, request
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.orm import backref
# from werkzeug.datastructures import T
import json
import datetime as dt
import yfinance as yf


app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///stocks-app.db'

db = SQLAlchemy(app)

### User operations
class User(db.Model):
    __tablename__ = 'users'
    id = db.Column(db.Integer, nullable = False, primary_key = True)
    firstname = db.Column(db.String(200), nullable = False)
    lastname = db.Column(db.String(200), nullable = False)
    email = db.Column(db.String(200), nullable = False)
    username = db.Column(db.String(200), nullable = False)
    password = db.Column(db.String(200), nullable = False)
    favorites = db.relationship('Favorite', backref='users', lazy=True)

    def serialize(self):
        return {
            "firstname": self.first_name,
            "lastname": self.last_name,
            "email": self.email,
            "username": self.username,
            "password": self.password
        }

@app.route('/get_user', methods=['GET'])
def get_user():
    user_name = request.args.get('username')

    user = User.query.filter_by(username = user_name).first()
    return json.dumps({"id": user.id})
    


@app.route('/login', methods=['POST'])
def login_user():
    data = request.get_json()

    username = data['username']
    password = data['password']

    user = User.query.filter_by(username = username, password = password).first()
    if user:
        return {
            'message': "Login Successful",
            'status': 200
        }, 200
    else:
        return {
            'message': 'Login Error',
            'status': 400
            }, 400



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
        return {
            'message': 'New user added',
            'status': 200
            }, 200
    except:
        return {
            'message': 'Error adding user',
            'status': 400
            }, 400

####

#### Stock operations

class Stock(db.Model):
    __tablename__ = "stocks"
    id = db.Column(db.Integer, nullable = False, primary_key = True)
    name = db.Column(db.String(200), nullable = False)
    ticker = db.Column(db.String(200), nullable = False)
    favorites = db.relationship('Favorite', backref='stocks', lazy=True)
    
@app.route('/list_all_stocks', methods=['GET'])
def list_all_stocks():

    try:
        # get all stock entries
        stocks_iter = db.session.query(Stock).all()
        stocks_list = []
        for stock in stocks_iter:
            stocks_list.append({'id': stock.id, 'name': stock.name, 'ticker': stock.ticker})
        
        # convert to json and return
        return json.dumps(stocks_list, indent=4)
    except:
        return

@app.route('/get_candle_data', methods=['GET'])
def get_candle_data():

    ticker = request.args.get('ticker')
    period = int(request.args.get('period'))
    print("period is a " + str(type(period)))
    now = dt.datetime.now().strftime("%Y-%m-%d")
    before = (dt.datetime.now() - dt.timedelta(days=period*365)).strftime("%Y-%m-%d")

    try:
        # call the load_data function
        df = load_data(ticker, now, before)

        # convert to json and return it
        result = df.to_json(orient="records")
        parsed = json.loads(result)
        return json.dumps(parsed, indent=4)
    except:
        return

# helper function to receive stock ticker data
def load_data(ticker, now, before):
    data = yf.download(ticker, before, now)
    data.reset_index(inplace=True)
    return data

####

#### Favorites operations

class Favorite(db.Model):
    __tablename__ = "favorites"
    id = db.Column(db.Integer, nullable = False, primary_key = True)
    userID = db.Column(db.Integer, db.ForeignKey('users.id', onupdate="CASCADE", ondelete="CASCADE"), nullable = False)
    stockID = db.Column(db.Integer, db.ForeignKey('stocks.id', onupdate="CASCADE", ondelete="CASCADE"), nullable = False)

@app.route('/list_fav', methods=['GET'])
def list_fav():

    id = request.args.get('id')
    try:
        # get the favourite stocks given an id
        fav_iter = db.session.execute('SELECT stocks.name, stocks.ticker, stocks.id FROM favorites INNER JOIN stocks ON favorites.stockID = stocks.id WHERE favorites.userID = ' + str(id) + ';')
    except :
        return
    
    fav_list = []
    for fav in fav_iter:
        # start = time.time()
        current = curr_price(fav.ticker)
        # elapsed_time = time.time() - start
        # print("Time taken: " + str(elapsed_time))
        fav_list.append({'name': fav.name, 'ticker': fav.ticker, 'id': fav.id, 'current': current})

    # convert to json and return
    return json.dumps(fav_list, indent=4), 200

# helper function to retrieve current price
def curr_price(ticker):
    stock_info = yf.Ticker(ticker).info['regularMarketPrice']
    # print(stock_info.keys())

    # print(stock_info['regularMarketPrice'])
    # return stock_info['regularMarketPrice']
    return stock_info

####

@app.route('/add_fav', methods=['PUT'])
def add_fav():
    print(request.is_json)
    data = request.get_json()

    uID = data['userID']
    sID = data['stockID']

    print("UserID === ", uID)
    print("StockID === ", sID)

    # check if the favorite already exists
    if Favorite.query.filter_by(userID = uID, stockID = sID).first():
        return {
            'message': 'Favorite exists',
            'status': 400
        }, 400
    
    # create a new favorite
    new_fav = Favorite (
        userID = uID,
        stockID = sID
    )

    # add the favorite to the db
    try:
        db.session.add(new_fav)
        db.session.commit()
        return {
            'message': 'New favorite added',
            'status': 200
            }, 200
    except :
        return {
            'message': 'Error adding new favorite',
            'status': 400
            }, 400

####

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000)