import UIKit
import Swinject
import SwinjectStoryboard

class TestAppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var assembler: Assembler?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
    
}
