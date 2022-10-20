//
//  FolderViewerViewController.swift
//  CleanUIKit
//
//  Created by Chris K on 10/20/22.
//

import Foundation
import UIKit

class FolderViewerViewController: UIViewController {
    
    override
    func viewDidLoad() {
        super.viewDidLoad()
        let presenter = FolderViewerPresenter()
        presenter.display = self
        let interactor = FolderViewerInteractor()
        interactor.presenter = presenter
        
        let folderId = Int(Date.now.timeIntervalSince1970) % 2
        interactor.loadFolder(folderId: "\(folderId)")
    }
}

extension FolderViewerViewController: FolderViewerDisplayLogic {
    func displayFolder(viewModel: FolderViewerViewModel) {
        print("FolderViewerViewController displayFolder(viewModel:\(viewModel.formattedFolderName)")
        self.view.backgroundColor = viewModel.formattedFolderName == "1" ?  UIColor.blue : UIColor.red
    }
}


// Scene


protocol FolderViewerBusinessLogic {
    var presenter: FolderViewerPresentationLogic? { get }
    func loadFolder(folderId: String)
}

class FolderViewerInteractor: FolderViewerBusinessLogic {
    var presenter: FolderViewerPresentationLogic?
    
    func loadFolder(folderId: String) {
        let folder = Entities.Folder(id: folderId, name: folderId, files: []);
        presenter?.presentFolder(folder: folder)
    }
}

struct FolderViewerViewModel {
    let formattedFolderName: String
}

protocol FolderViewerPresentationLogic {
    var display: FolderViewerDisplayLogic? { get }
    func presentFolder(folder: Entities.Folder)
}


class FolderViewerPresenter: FolderViewerPresentationLogic {
    weak var display: FolderViewerDisplayLogic?
    func presentFolder(folder: Entities.Folder) {
        let viewModel = FolderViewerViewModel(formattedFolderName: folder.name)
        display?.displayFolder(viewModel: viewModel)
    }
}

protocol FolderViewerDisplayLogic: AnyObject {
    func displayFolder(viewModel: FolderViewerViewModel)
}

