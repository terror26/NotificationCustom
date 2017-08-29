//
//  ViewController.swift
//  NotificationCustom
//
//  Created by Kanishk Verma on 29/08/17.
//  Copyright © 2017 Kanishk Verma. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //to import the user notifications
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert , .badge  , .sound ], completionHandler:{
            (granted,error ) in
            
            if granted {
                print("User Authentication Done")
            } else {
                print("Sorry the error \(String(describing: error?.localizedDescription))")
            }
            
        })
    }
    @IBAction func notifyBtnTapped (sender : UIButton) {
        scheduleNotification(inseconds: 5, completion: { success in
            
            if success {
                print("Succes it was")
            } else {
                print("sorry dude better luck next time")
            }
            
        })
    }
    
    func scheduleNotification(inseconds: TimeInterval , completion : @escaping (_ Success : Bool) -> ()) {
        
        guard let imageUrl = Bundle.main.url(forResource: "MarkRap", withExtension: "gif") else {
            completion(false)
            return
        }
        
        let attachment:UNNotificationAttachment
        attachment = try! UNNotificationAttachment(identifier: "Mynotification", url: imageUrl, options: .none)
        
        
        let notif = UNMutableNotificationContent()
        
        //JUst for the extension
        notif.categoryIdentifier = "myNotificationCategory"
        
        notif.title = "The notif title"
        notif.subtitle = "the subtitle of the notifications"
        notif.body = "this is where the notification body will dive into dude!"
        notif.attachments = [attachment]
        
        let notificationTigger = UNTimeIntervalNotificationTrigger(timeInterval: inseconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: "Mynotification", content: notif, trigger: notificationTigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: {
            error in
            if error != nil {
                completion(false)
            } else {
                completion(true)
            }
        })
        
        
    }


}

