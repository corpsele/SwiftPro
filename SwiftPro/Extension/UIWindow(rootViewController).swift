public extension UIWindow {
    
    public func topMostWindowController()->UIViewController? {
        
        var topController = rootViewController
        
        while let presentedController = topController?.presentedViewController {
            topController = presentedController
        }
        
        return topController
    }
    
    public func currentViewController()->UIViewController? {
        
        var currentViewController = topMostWindowController()
        if currentViewController is UITabBarController{
            currentViewController = (currentViewController as! UITabBarController).selectedViewController
        }
        while currentViewController != nil && currentViewController is UINavigationController && (currentViewController as! UINavigationController).topViewController != nil {
            currentViewController = (currentViewController as! UINavigationController).topViewController
        }
        
        return currentViewController
    }
    

}

extension UIDevice {
    
    static public func isX() -> Bool {
        
        if UIScreen.main.bounds.height >= 812 {
            
            return true
            
        }
        
        return false
        
    }
    
}
