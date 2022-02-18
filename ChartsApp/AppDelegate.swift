import UIKit
import Ably

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let ably = ARTRealtime(key: "INSERT KEY")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //create a connection to Ably
        ably.connection.on { stateChange in
            let stateChange = stateChange
            switch stateChange.current {
            case .connected:
                print("Connected to Ably!")
            case .failed:
                print("Failed to connect to Ably.")
            default:
                break
            }
        }
        return true
    }

}

