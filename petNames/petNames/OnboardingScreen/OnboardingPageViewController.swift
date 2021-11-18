//
//  OnboardingPageViewController.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 15/11/21.
//

import UIKit

protocol OnboardingControlDelegate: AnyObject {
    func didTapBackButton(viewController: UIViewController, button: UIButton)
    func didTapNextButton(viewController: UIViewController, button: UIButton)
    func didTapSaveButton(viewController: UIViewController, button: UIButton)
    func didTapSkipButton(viewController: UIViewController, button: UIButton)
}

class OnboardingPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = pages.firstIndex(of: viewController), index != 0 {
            return pages[index - 1]
        } else {
            return nil
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = pages.firstIndex(of: viewController), index != pages.count - 1 {
            return pages[index + 1]
        } else {
            return nil
        }
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let viewController = viewControllers?.first, let index = pages.firstIndex(of: viewController) else {
            return 0
        }
        return index
    }

    var pages: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        isModalInPresentation = true

        let storyboard = UIStoryboard(name: "Onboarding", bundle: .main)
        let onboarding1 = storyboard.instantiateViewController(withIdentifier: "onboarding1") as! OnboardingViewController
        onboarding1.delegate = self
        
        let onboarding2 = storyboard.instantiateViewController(withIdentifier: "onboarding2") as! Onboarding2ViewController
        onboarding2.delegate = self

        let onboarding3 = storyboard.instantiateViewController(withIdentifier: "onboarding3") as! Onboarding3ViewController
        onboarding3.delegate = self

        let onboarding4 = storyboard.instantiateViewController(withIdentifier: "onboarding4") as! Onboarding4ViewController
        onboarding4.delegate = self

        pages = [onboarding1, onboarding2, onboarding3, onboarding4]
        dataSource = self
        setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
//        let appearance = UIPageControl.appearance(whenContainedInInstancesOf: [UIPageViewController.self])
//        appearance.backgroundStyle = .prominent
    }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let subViews = view.subviews
        var scrollView: UIScrollView?
        var pageControl: UIPageControl?

        for view in subViews {
            if view is UIScrollView {
                scrollView = view as? UIScrollView
            } else if view is UIPageControl {
                pageControl = view as? UIPageControl
            }
        }

        if scrollView != nil && pageControl != nil {
            scrollView?.frame = view.bounds
            view.bringSubviewToFront(pageControl!)
        }
    }
}

extension OnboardingPageViewController: OnboardingControlDelegate {
    func didTapSkipButton(viewController: UIViewController, button: UIButton) {
        dismiss(animated: true)
    }

    func didTapBackButton(viewController: UIViewController, button: UIButton) {
        goToPreviousPage()
    }

    func didTapNextButton(viewController: UIViewController, button: UIButton) {
        goToNextPage()
    }

    func didTapSaveButton(viewController: UIViewController, button: UIButton) {
        guard let myViewController = viewController as? Onboarding4ViewController else {
            fatalError("The last screen isn't of type \(viewController)")
        }
        let name = myViewController.onboarding4TextBoxView.text ?? ""
        print(name)
    }

}

extension UIPageViewController {

    func goToNextPage() {
        guard let currentViewController = self.viewControllers?.first else { return }
        guard let nextViewController = dataSource?.pageViewController( self, viewControllerAfter: currentViewController ) else { return }
        setViewControllers([nextViewController], direction: .forward, animated: false, completion: nil)
    }

    func goToPreviousPage() {
        guard let currentViewController = self.viewControllers?.first else { return }
        guard let previousViewController = dataSource?.pageViewController( self, viewControllerBefore: currentViewController ) else { return }
        setViewControllers([previousViewController], direction: .reverse, animated: false, completion: nil)
    }

}
