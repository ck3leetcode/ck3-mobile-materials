//
//  ListViewController.swift
//  viper-uikit
//
//  Created by Chris K on 10/19/22.
//

import Foundation
import UIKit

class ListViewController: UIViewController {
    var presenter: ListViewPresenter!
    
    override
    func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        presenter.displayList()
    }
    
    
    private func configure() {
        let interactor = ListViewInteractor()
        presenter = ListViewPresenter(interactor: interactor, viewable: self)
    }
}

extension 




class ListViewPresenter {
    weak var viewable: ListViewable?
    let interactor: ListViewInteractor?
    
    init(interactor: ListViewInteractor, viewable: ListViewable) {
        self.interactor = interactor
        self.viewable = viewable
    }
    
    func displayList() {
        interactor?.fetchData(completion: { response in
            
            let listViewViewModel = ListViewViewModel()
            
            viewable.update(listViewViewModel: listViewViewModel)
        })
    }
    
    
}

class ListViewInteractor {
    func fetchData(completion: (HTTPURLResponse) -> ()) {
        let url = URL(string: "abc.com")
        /*URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in }
            
        )*/
    }
}




struct ListViewViewModel {
    
    
}

class Forecast: Entity {
    
}


/// VIPER

protocol ListViewable: class {}

protocol ListViewBusinessLogic {
    func fetchData(completion: (URLResponse) -> ())
}

protocol ListViewPresentationLogic {
    
    
}

protocol Router {}

protocol Entity {}

