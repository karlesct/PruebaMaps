//
//  WalkthroughViewController.swift
//  PruebaMapsCore
//
//  Created by Carles Cañadas Torrents on 14/09/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

// PageController: https://github.com/cjlarsen/Tutorials/blob/master/PageControllerTutorial/PageControllerTutorial/ViewController.swift

import UIKit

public final class WalkthroughViewController: UIViewController {

    // MARK: - IBoutlets

    @IBOutlet var pageControl: UIPageControl!

    // MARK: - Fields

    private let vcFake: UIViewController
    private let viewControllers: [UIViewController]

    // MARK: - Properties

    private var pageViewController: UIPageViewController?
    private var currentIndex: Int = 0

    // MARK: - init

    init(viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
        self.vcFake = UIViewController()
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    func setupUI() {

        setupPageController()

    }

    func setupPageController() {
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        guard let pageController = pageViewController else { return }
        pageController.dataSource = self
        pageController.delegate = self
        pageController.view.backgroundColor = .clear

        pageController.setViewControllers([viewControllers[0]], direction: .forward, animated: true, completion: nil)
        self.addChildViewControllerWithView(pageController)
        pageControl.numberOfPages = viewControllers.count

        self.view.bringSubviewToFront(pageControl)
    }

}

extension WalkthroughViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = self.index(of: viewController) {
            if index == 0 {
                return nil
            }
            return viewControllers[index - 1]
        }
        return nil
    }

    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = self.index(of: viewController) {
            if index + 1 >= viewControllers.count {
                return vcFake
            }
            return viewControllers[index + 1]
        }
        return nil
    }

    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

         if !completed { return }

        if let currentViewController = pageViewController.viewControllers?.first,
        let index = viewControllers.firstIndex(of: currentViewController) {
            pageControl.currentPage = index
        }
    }

    public func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
//        if pendingViewControllers.first == self.vcFake,
//            let pageController = self.pageViewController {
//            //self.removeChildViewController(pageController)
//        }
    }

    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.viewControllers.count
    }

    private func index(of viewController: UIViewController) -> Int? {
        let index = viewControllers.firstIndex(of: viewController)
        return index
    }
}

extension UIViewController {

    func addChildViewControllerWithView(_ childViewController: UIViewController, toView view: UIView? = nil) {
        let view: UIView = view ?? self.view
        childViewController.removeFromParent()
        childViewController.willMove(toParent: self)
        addChild(childViewController)
        childViewController.didMove(toParent: self)
        childViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(childViewController.view)
        view.addConstraints([
            NSLayoutConstraint(item: childViewController.view!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: -10),
            NSLayoutConstraint(item: childViewController.view!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: childViewController.view!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: childViewController.view!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        ])
        view.layoutIfNeeded()
    }

    func removeChildViewController(_ childViewController: UIViewController) {
        childViewController.removeFromParent()
        childViewController.willMove(toParent: nil)
        childViewController.removeFromParent()
        childViewController.didMove(toParent: nil)
        childViewController.view.removeFromSuperview()
        view.layoutIfNeeded()
    }

    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
