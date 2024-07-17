//
//  NotificationViewController.swift
//  imageNotification
//
//  Created by Ruchira Bandara on 2024-07-16.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        preferredContentSize.height = 300
        
        let content = notification.request.content
        if let urlImageString =  content.userInfo["urlImageString"] as? String {
            if let url = URL(string: urlImageString) {
                let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
                    if data != nil, error == nil {
                        DispatchQueue.main.async {
                            self.imageView.image = UIImage(data: data!)
                        }
                    }
                }
                dataTask.resume()
            }
        }
    }

}
