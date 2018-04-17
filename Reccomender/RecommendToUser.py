"""
Organize the beers liked for a user
"""

import pandas as pd

def choiceBeers(userId, path):

    # Get beerID for given userId
    recomends = pd.read_csv(path + "testRecommendation.csv")
    filtered_data = recomends[recomends.USR == int(userId)]

    # Get Beers for given beerID
    names = pd.read_csv(path + "testBeer.csv")
    beers = names[names.beerId.isin(filtered_data.beerId)]

    # Get Beers from Result
    similars = pd.read_csv(path + "result.csv")
    filtered_data = similars[(similars.name1.isin(beers.name)) & (similars.number > 0.6)]
    filtered_data = filtered_data[filtered_data.name1 != filtered_data.name2].drop_duplicates(subset="name2")
    return filtered_data[["name2","number"]]


if __name__ == "__main__":
    path = "/Users/lrazovic/Projects/Beerer/Reccomender/dataset/"
    print(choiceBeers("1", path))
