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
        
//        let assemblies: [Assembly] = [MainAssembly()]
//
//        assembler = Assembler(assemblies, container: SwinjectStoryboard.defaultContainer)
//
//        // Instantiate the root view controller with dependencies injected by the container.
//
//        let storyboard = SwinjectStoryboard.create(name: "BeerList", bundle: nil, container: SwinjectStoryboard.defaultContainer)
//        window.rootViewController = storyboard.instantiateInitialViewController()
        
        return true
    }
    
}
