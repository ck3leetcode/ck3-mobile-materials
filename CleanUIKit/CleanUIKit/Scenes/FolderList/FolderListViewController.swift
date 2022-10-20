//
//  ListOrdersViewController.swift
//  CleanUIKit
//
//  Created by Chris K on 10/19/22.
//

import Foundation
import UIKit

class FolderListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var folderViewModels = [FolderListViewModels.FolderViewModel]()
    
    var interactor: FolderListViewBusinessLogic!
    var router: FolderListRouter!
    
    override
    func viewDidLoad() {
        super.viewDidLoad()
        // configure
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        setup()
        interactor.listAll()
    }
    
    func setup() {
        let worker = Workers.FileSystemWorker(
            apiDataStore: DataStore.APIDataStore(),
            cacheDataStore: DataStore.CacheDataStore())
        
        let presenter = FolderListViewPresenter()
        presenter.display = self
        
        interactor = FolderListViewInteractor(presenter: presenter, worker: worker)
        router = FolderListRouter()
        router.viewController = self
    }
}

extension FolderListViewController: FolderListViewDisplayLogic {
    func displayFolders(folderViewModels: [FolderListViewModels.FolderViewModel]) {
        print("FolderListViewController displayFolders()")
        self.folderViewModels = folderViewModels
        tableView.reloadData()
    }
    
    func displayError(errorMsg: String) {
    }
}

extension FolderListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folderViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = folderViewModels[indexPath.item].folderName
        cell.detailTextLabel?.text = "\(folderViewModels[indexPath.item].fileCounts)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router.routeToFile(fileId: folderViewModels[indexPath.item].id)
    }
}


// MARK Scenes

// Interactor
protocol FolderListViewBusinessLogic {
    var presenter: FolderListViewPresentationLogic { get }
    func listAll()
}

class FolderListViewInteractor: FolderListViewBusinessLogic{
    let presenter: FolderListViewPresentationLogic
    let worker: Workers.FileSystemWorker
   
    init(presenter: FolderListViewPresentationLogic, worker: Workers.FileSystemWorker) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func listAll() {
        print("FolderListViewInteractor listAll()")
        worker.listAll { result in
            switch result {
            case .success(let success):
                presenter.presentFolders(folders: success)
            case .failure(let failure):
                presenter.presentError(error: failure)
            }
        }
    }
}

// Presenter
struct FolderListViewModels {
    struct FolderViewModel {
        let id: String
        let folderName: String
        let fileCounts: Int
    }
}

protocol FolderListViewPresentationLogic {
    var display: FolderListViewDisplayLogic? { get }
    
    func presentFolders(folders: [Entities.Folder])
    func presentError(error: Error)
}

class FolderListViewPresenter: FolderListViewPresentationLogic {
    /// USE WEAK!
    weak var display: FolderListViewDisplayLogic?
    
    func presentFolders(folders: [Entities.Folder]) {
        let viewModels = folders.map { f in
            return FolderListViewModels.FolderViewModel(id: f.id, folderName: f.name, fileCounts: f.files.count)
        }
        print("FolderListViewPresenter presentFolders()")
        display?.displayFolders(folderViewModels: viewModels)
    }
    
    func presentError(error: Error) {
        display?.displayError(errorMsg: error.localizedDescription)
    }
}


// View
protocol FolderListViewDisplayLogic: AnyObject {
    func displayFolders(folderViewModels: [FolderListViewModels.FolderViewModel])
    func displayError(errorMsg: String)
}


// Router
protocol FolderListRoutingLogic {
    func routeToFile(fileId: String)
}

class FolderListRouter: FolderListRoutingLogic {
    weak var viewController: FolderListViewController?
    
    func routeToFile(fileId: String) {
        let vc = viewController?.storyboard?.instantiateViewController(withIdentifier: "FolderViewerViewController")
        viewController?.show(vc!, sender: nil)
    }
}
