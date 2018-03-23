import UIKit

class ViewController: UIViewController, SwipeableCardViewDataSource {

    @IBOutlet private weak var swipeableCardView: SwipeableCardViewContainer!
    @IBOutlet weak var tabBar: UITabBarItem!
    @IBOutlet weak var direction: UILabel!

    // MARK: Local Variables
    var index: Int = 0
    private var json: Any?
    private var like = 0;

    var beer = beerSetup(userId: "test", beerValue: [])

    override func viewDidLoad() {
        super.viewDidLoad()
        swipeableCardView?.dataSource = self
        let isFirstLaunch = UIApplication.isFirstLaunch()
        print(isFirstLaunch)
        if(isFirstLaunch) { }

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "firstSetup" {
            let toViewController = segue.destination as! BeerInfoViewController
            toViewController.passedBeer = sender as! Beer
        }
    }
}


// MARK: - Extension

extension ViewController {

    func numberOfCards() -> Int {
        return viewModels.count
    }

    func card(forItemAtIndex index: Int) -> SwipeableCardViewCard {
        let viewModel = viewModels[index]
        let cardView = SampleSwipeableCard()
        cardView.viewModel = viewModel
        return cardView
    }

    func viewForEmptyCards() -> UIView? {
        return nil
    }

}

extension ViewController {

    var viewModels: [SampleSwipeableCellViewModel] {

        let peroni = SampleSwipeableCellViewModel(title: "Peroni",
                                                  subtitle: "Euro Pale Lager",
                                                  image: #imageLiteral(resourceName: "0629_peroni"))

        let ceres = SampleSwipeableCellViewModel(title: "Ceres",
                                                 subtitle: "Euro Strong Lager",
                                                 image: #imageLiteral(resourceName: "0584_ceres"))

        let becks = SampleSwipeableCellViewModel(title: "Beck's",
                                                 subtitle: "German Pilsener",
                                                 image: #imageLiteral(resourceName: "0579_becks"))

        let desperados = SampleSwipeableCellViewModel(title: "Desperados",
                                                      subtitle: "American Pale Lager",
                                                      image: #imageLiteral(resourceName: "0586_desperados"))

        let franz = SampleSwipeableCellViewModel(title: "Franziskaner",
                                                 subtitle: "Hefeweizen",
                                                 image: #imageLiteral(resourceName: "0853_franz"))

        let guinness = SampleSwipeableCellViewModel(title: "Guinness",
                                                    subtitle: "Irish Dry Stout",
                                                    image: #imageLiteral(resourceName: "0593_guinnessdraught"))

        let heineken = SampleSwipeableCellViewModel(title: "Heineken",
                                                    subtitle: "Euro Pale Lager",
                                                    image: #imageLiteral(resourceName: "0597_hein"))

        let nastro = SampleSwipeableCellViewModel(title: "Nastro Azzurro",
                                                  subtitle: "Euro Pale Lager",
                                                  image: #imageLiteral(resourceName: "0621_nastro"))

        let tennent = SampleSwipeableCellViewModel(title: "Tennent’s Super",
                                                   subtitle: "Euro Strong Lager",
                                                   image: #imageLiteral(resourceName: "0641_tenn"))

        return [peroni, ceres, becks, desperados, franz, guinness, heineken, tennent, nastro]

    }

}

