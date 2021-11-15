//
//  OnboardingPageViewController.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 15/11/21.
//

import UIKit

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

        let storyboard = UIStoryboard(name: "Onboarding", bundle: .main)
        pages = [
            storyboard.instantiateViewController(withIdentifier: "onboarding1"),
            storyboard.instantiateViewController(withIdentifier: "onboarding2"),
            storyboard.instantiateViewController(withIdentifier: "onboarding3"),
            storyboard.instantiateViewController(withIdentifier: "onboarding4")
        ]
        dataSource = self
        setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)

        let appearance = UIPageControl.appearance(whenContainedInInstancesOf: [UIPageViewController.self])
        appearance.backgroundStyle = .prominent
    }
}
