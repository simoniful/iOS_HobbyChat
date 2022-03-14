//
//  OnboardingPageViewController.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/03/14.
//

import UIKit
import Rswift

class OnboardingPageViewController: UIPageViewController {
    var innerElements: [CarouselElement] = [
        CarouselElement(image: R.image.onboarding_Img1()!, text: "위치 기반으로 빠르게\n주위 친구를 확인"),
        CarouselElement(image: R.image.onboarding_Img2()!, text: "관심사가 같은 친구를\n찾을 수 있어요"),
        CarouselElement(image: R.image.onboarding_Img3()!, text: "SeSAC Frineds")
    ]
    var pages: [UIViewController] = [UIViewController]()

    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        decoratePageControl()
        dataSource = self
        delegate = nil

        for i in 0..<innerElements.count {
            let viewController = CarouselViewController()
            switch i {
            case 0:
                viewController.carouselView.infoLabel.text = innerElements[i].text
                viewController.carouselView.infoLabel.changeTextColor(targetString: "위치 기반", color: R.color.brandcolor_green()!)
            case 1:
                viewController.carouselView.infoLabel.text = innerElements[i].text
                viewController.carouselView.infoLabel.changeTextColor(targetString: "관심사가 같은 친구", color: R.color.brandcolor_green()!)
            default:
                viewController.carouselView.infoLabel.text = innerElements[i].text
            }
            viewController.carouselView.infoImage.image = innerElements[i].image
            pages.append(viewController)
        }
        setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
    }
    
    func decoratePageControl() {
        let pageControl = UIPageControl.appearance(whenContainedInInstancesOf: [OnboardingPageViewController.self])
        pageControl.currentPageIndicatorTintColor = R.color.custom_black()
        pageControl.pageIndicatorTintColor = R.color.grayscale_gray5()
    }
}

extension OnboardingPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.lastIndex(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return nil }
        guard pages.count > previousIndex else { return nil }
        return pages[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.lastIndex(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex != pages.count else { return nil }
        guard pages.count > nextIndex else { return nil }
        return pages[nextIndex]
    }
}

extension OnboardingPageViewController: UIPageViewControllerDelegate {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstVC = pageViewController.viewControllers?.first else { return 0 }
        guard let firstVCIndex = pages.firstIndex(of: firstVC) else { return 0 }
        return firstVCIndex
    }
}
