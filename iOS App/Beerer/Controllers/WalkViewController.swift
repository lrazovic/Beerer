//
//  WalkViewController.swift
//  Beerer
//
//  Created by Leonardo Razovic on 17/03/18.
//  Copyright © 2018 Leonardo Razovic. All rights reserved.
//

import UIKit
// import Auth0

class WalkViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    var pageControl = UIPageControl()
    lazy var orderedViewControllers: [UIViewController] = {
        return [UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "w1"),
                UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "w2"),
                UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "w3"),
                UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "w4"),
                UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "w5") as! SocialLoginViewController]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        self.view.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.0)

        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }

        configurePageControl()
    }

    func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 50, width: UIScreen.main.bounds.width, height: 50))
        self.pageControl.numberOfPages = orderedViewControllers.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor(red: 0.15, green: 0.27, blue: 0.34, alpha: 0.5)
        self.pageControl.currentPageIndicatorTintColor = UIColor(red: 0.15, green: 0.27, blue: 0.34, alpha: 1.0)
        self.view.addSubview(pageControl)
    }

    func newVc(viewController: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewControllers.index(of: pageContentViewController)!
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }

        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }

        guard orderedViewControllers.count > previousIndex else {
            return nil
        }

        return orderedViewControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }

        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count

        guard orderedViewControllersCount != nextIndex else {
            return nil
        }

        guard orderedViewControllersCount > nextIndex else {
            return nil
        }

        return orderedViewControllers[nextIndex]
    }

}
