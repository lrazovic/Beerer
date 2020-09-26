import pandas as pd


def getBeerInfo(beerId, path):
    names = pd.read_csv(path + "testBeer.csv")
    return names[names.beerId == beerId].to_json(orient="records")


def setInitialSetup(beerId, path, jsonfile):
    beers = pd.read_csv(path + "testBeer.csv")
    userid = jsonfile[uid]
    votedBeers = jsonfile[beer]
    for beer in votedBeers:
        if beer[vote] == 2:
            continue
        else:
            beers.appen(userid, beer[vote])
    # add json to beers
    # match setup with beers in daset
    # rebuild model


if __name__ == "__main__":
    path = "dataset/"
    print(getBeerInfo(10, path))
