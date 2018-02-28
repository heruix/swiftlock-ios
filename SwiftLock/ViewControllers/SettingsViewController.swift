//
//  SettingsViewController.swift
//  SwiftLock
//
//  Created by Mohak Shah on 16/05/17.
//  Copyright © 2017 Mohak Shah. All rights reserved.
//

import UIKit
import RFAboutView_Swift

class SettingsViewController: UITableViewController
{
    struct SegueIds {
        static let ToAboutView = "Settings2About"
    }

    @IBAction func logout(_ sender: Any) {
        CurrentUser.shared.logout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        #if DEBUG
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(listFiles))
        #endif
    }
    
    #if DEBUG
    /// Hacky function to print a tree of all files in the document directory
    @objc private func listFiles() {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dirEnumerator = FileManager.default.enumerator(at: documentsURL, includingPropertiesForKeys: [.nameKey])!
        for file in dirEnumerator {
            for _ in 1..<dirEnumerator.level {
                print("\t", separator: "", terminator: "")
            }
            print((file as! URL).lastPathComponent)
        }
    }
    #endif


    @IBAction func showWalkthrough(_ sender: Any) {
        (UIApplication.shared.delegate as! AppDelegate).showWalkthrough()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIds.ToAboutView,
            let navVC = segue.destination as? UINavigationController {
                navVC.setViewControllers([aboutVC], animated: false)
        }
    }

    lazy var aboutVC: RFAboutViewController = {

        // create and setup an RFAboutVC
        let aboutVC = RFAboutViewController(appName: nil, appVersion: nil, appBuild: nil, copyrightHolderName: "Mohak Shah", contactEmail: "mohak@mohakshah.in", contactEmailTitle: "Contact Me", websiteURL: URL(string: "https://github.com/mohakshah/swiftlock-ios/issues")!, websiteURLTitle: "Report Issues", pubYear: nil)
        aboutVC.headerBackgroundColor = .black
        aboutVC.headerTextColor = .white
        aboutVC.blurStyle = .light
        aboutVC.headerBackgroundImage = #imageLiteral(resourceName: "SwiftLock New Horizontol Logo (Dark Sea Green)")

        aboutVC.addAdditionalButton("Icon Credits", content: Strings.IconCredits)
        return aboutVC
    }()

}
