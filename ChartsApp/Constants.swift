import Foundation
import Ably
import UIKit

struct Constants {
    
    static let ablyKey: ARTRealtime = ARTRealtime(key: "INSERT KEY")
    static let channel = ablyKey.channels.get("INSERT NAME")

}
