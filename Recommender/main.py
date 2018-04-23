from flask import Flask
import pandas as pd
from beerRecommender import calculate_similar_beers
from userRecommender import choiceBeers
from beerInfo import getBeerInfo

app = Flask(__name__)

input = "./dataset/"
output = "./dataset/result.csv"


@app.route('/')
def hello():
    return "It's Work"


@app.route('/config')
def config():
    calculate_similar_beers(input, output, "cosine")
    return "Config"

@app.route('/user/<int:post_id>')
def user(post_id):
    return choiceBeers(str(post_id), input)

@app.route('/beer/<int:post_id>')
def beer(post_id):
    return getBeerInfo(post_id, input)


if __name__ == '__main__':
    app.run(host='127.0.0.1', port=8080, debug=True)
