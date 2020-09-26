from flask import Flask
from flask import jsonify

# from flask import request
from beer_recommender import calculate_similar_beers
from user_recommender import choice_beers
from beer_info import get_beer_info

app = Flask(__name__)

input = "dataset/"
output = "dataset/result.csv"


@app.route("/")
def hello():
    return "It's Work"


@app.route("/config")
def config():
    calculate_similar_beers(input, output, "cosine")
    return "Ok"


@app.route("/user/<int:post_id>")
def user(post_id):
    beers = choice_beers(str(post_id), input)
    return jsonify(beers)


@app.route("/setupuser/<int:post_id>")
def setupuser(post_id):
    # request_json = request.get_json()
    beers = choice_beers(str(post_id), input)
    return jsonify(beers)


@app.route("/beer/<int:post_id>")
def beer(post_id):
    info = get_beer_info(post_id, input)
    return jsonify(info)


if __name__ == "__main__":
    app.run(host="127.0.0.1", port=8080, debug=True)
