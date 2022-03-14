//
//  CarouselViewController.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/03/12.
//

import UIKit

class CarouselViewController: UIViewController {
    let carouselView = CarouselView()
    
    override func loadView() {
        super.loadView()
        self.view = carouselView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
