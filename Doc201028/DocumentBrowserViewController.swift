//
//  DocumentBrowserViewController.swift
//  Doc201028
//
//  Created by leslie on 10/28/20.
//

import UIKit


class DocumentBrowserViewController: UIDocumentBrowserViewController, UIDocumentBrowserViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        allowsDocumentCreation = true
        allowsPickingMultipleItems = false
        
        // Update the style of the UIDocumentBrowserViewController
        // browserUserInterfaceStyle = .dark
        // view.tintColor = .white
        
        // Specify the allowed content types of your application via the Info.plist.
        
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: UIDocumentBrowserViewControllerDelegate
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didRequestDocumentCreationWithHandler importHandler: @escaping (URL?, UIDocumentBrowserViewController.ImportMode) -> Void) {
        
        // Letting Users Choose a Template
        let title = NSLocalizedString("Choose File Template", comment: "")
        let message = "Please choose a file."
        let cancelButtonTitle = NSLocalizedString("Cancel", comment: "")
        let defaultButtonTitle = NSLocalizedString("Basic (Default) ", comment: "Default")
        let generalButtonTitle = NSLocalizedString("(Demo)", comment: "")
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let newDocumentURL = Bundle.main.url(forResource: "Template", withExtension: nil)
        importHandler(newDocumentURL, .copy)
        
        // Create the actions.
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel) { (action) in
            importHandler(nil, .none)
        }
        let defaultButtonAction = UIAlertAction(title: defaultButtonTitle, style: .default) { (_) in
            let newDocumentURL = Bundle.main.url(forResource: "Template", withExtension: nil)
            importHandler(newDocumentURL, .copy)
        }
        
        let generalButtonAction = UIAlertAction(title: generalButtonTitle, style: .default) { (_) in
            let newDocumentURL = Bundle.main.url(forResource: "Template", withExtension: nil)
            importHandler(newDocumentURL, .copy)
        }
        
        // Add the actions.
        alertController.addAction(cancelAction)
        alertController.addAction(defaultButtonAction)
        alertController.addAction(generalButtonAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didPickDocumentsAt documentURLs: [URL]) {
        guard let sourceURL = documentURLs.first else { return }
        
        // Present the Document View Controller for the first document that was picked.
        // If you support picking multiple items, make sure you handle them all.
        presentDocument(at: sourceURL)
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didImportDocumentAt sourceURL: URL, toDestinationURL destinationURL: URL) {
        // Present the Document View Controller for the new newly created document
        presentDocument(at: destinationURL)
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, failedToImportDocumentAt documentURL: URL, error: Error?) {
        // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
    }
    
    // MARK: Document Presentation
    
    func presentDocument(at documentURL: URL) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let documentViewController = storyBoard.instantiateViewController(withIdentifier: "DocumentViewController") as! DocumentViewController
        documentViewController.document = Document(fileURL: documentURL)
        documentViewController.modalPresentationStyle = .fullScreen
        
        present(documentViewController, animated: true, completion: nil)
    }
}

