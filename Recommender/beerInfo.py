import pandas as pd


def getBeerInfo(beerId, path):
    names = pd.read_csv(path + "testBeer.csv")
    return names[names.beerId == beerId].to_json()


if __name__ == "__main__":
    path = "/Users/lrazovic/Projects/BeererServer/dataset/"
    print(getBeerInfo(10, path))
