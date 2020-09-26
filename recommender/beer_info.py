import pandas as pd
import json


def get_beer_info(beerId, path):
    names = pd.read_csv(path + "testBeer.csv")
    return json.loads(names[names.beerId == beerId].to_json(orient="records"))


def set_initial_setup(beerId, path, jsonfile):
    beers = pd.read_csv(path + "testBeer.csv")
    userid = jsonfile[uid]
    votedBeers = jsonfile[beer]
    for beer in votedBeers:
        if beer[vote] == 2:
            continue
        else:
            beers.append(userid, beer[vote])
    # add json to beers
    # match setup with beers in daset
    # rebuild model


if __name__ == "__main__":
    path = "dataset/"
    print(get_beer_info(10, path))
