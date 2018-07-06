import UIKit
import Swinject
import SwinjectStoryboard

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var assembler: Assembler?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Instantiate a window.
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window
        
        let assemblies: [Assembly] = [MainAssembly()]
        
        assembler = Assembler(assemblies, container: SwinjectStoryboard.defaultContainer)
        
        // Instantiate the root view controller from swinject
        let storyboard = SwinjectStoryboard.create(name: "BeerList", bundle: nil, container: SwinjectStoryboard.defaultContainer)
        window.rootViewController = storyboard.instantiateInitialViewController()
        
        return true
    }
}

