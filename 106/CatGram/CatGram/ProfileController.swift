//
//  ViewController.swift
//  CatGram
//
//  Created by Евгений Борисов on 13.02.2024.
//

import UIKit

class ProfileController: UIViewController {

    private lazy var profileView = ProfileView()

    override func loadView() {
        view = profileView
    }
}
