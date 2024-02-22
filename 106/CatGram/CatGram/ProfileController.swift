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
        print("load view")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("did load")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("will appear")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("did appear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("will disapear")
    }
}
