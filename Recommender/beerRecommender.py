"""
Recommender System
"""

import codecs
import logging
import time
import numpy
import pandas as pd
from scipy.sparse import coo_matrix

from implicit.als import AlternatingLeastSquares
from implicit.bpr import BayesianPersonalizedRanking
from implicit.nearest_neighbours import (
    BM25Recommender,
    CosineRecommender,
    TFIDFRecommender,
    bm25_weight,
)


def read_data(path):
    """ Reads in the dataset, and filters down ratings down to positive only"""
    ratings = pd.read_csv(path + "testRecommendation.csv")
    positive = ratings[ratings.rating >= 1]
    beers = pd.read_csv(path + "testBeer.csv")
    m = coo_matrix(
        (positive["rating"].astype(numpy.int), (positive["beerId"], positive["USR"]))
    )
    m.data = numpy.ones(len(m.data))
    return ratings, beers, m


def calculate_similar_beers(input_path, output_filename, model_name="cosine"):
    # read in the input data file
    logging.debug("reading data from %s", input_path)
    start = time.time()
    ratings, beers, m = read_data(input_path)
    logging.debug("read data file in %s", time.time() - start)

    # generate a recommender model based off the input params
    if model_name == "als":
        model = AlternatingLeastSquares()
        # lets weight these models by bm25weight.
        logging.debug("weighting matrix by bm25_weight")
        m = bm25_weight(m, B=0.9) * 5

    elif model_name == "bpr":
        model = BayesianPersonalizedRanking()

    elif model_name == "tfidf":
        model = TFIDFRecommender()

    elif model_name == "cosine":
        model = CosineRecommender()

    elif model_name == "bm25":
        model = BM25Recommender(B=0.2)

    else:
        raise NotImplementedError("TODO: model %s" % model_name)

    # train the model
    m = m.tocsr()
    logging.debug("training model %s", model_name)
    start = time.time()
    model.fit(m)
    logging.debug("trained model '%s' in %s", model_name, time.time() - start)
    logging.debug("calculating top beers")

    user_count = ratings.groupby("beerId").size()
    beer_lookup = dict((i, m) for i, m in zip(beers["beerId"], beers["name"]))
    to_generate = sorted(set(beers["beerId"]), key=lambda x: -user_count.get(x, 0))

    with codecs.open(output_filename, "w", "utf8") as file:
        file.write("%s,%s,%s\n\n" % ("name1", "name2", "number"))
        for beerid in to_generate:
            beerid = numpy.int(beerid)
            beer = beer_lookup[beerid]
            for other, score in model.similar_items(beerid, 6):
                file.write("%s, %s, %s\n" % (beer, beer_lookup[other], round(score, 3)))


if __name__ == "__main__":
    logging.basicConfig(level=logging.DEBUG)
    input = "dataset/"
    output = "dataset/result.csv"
    calculate_similar_beers(input, output, "cosine")
