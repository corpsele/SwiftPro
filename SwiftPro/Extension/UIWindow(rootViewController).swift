public extension UIWindow {
    func topMostWindowController() -> UIViewController? {
        var topController = rootViewController

        while let presentedController = topController?.presentedViewController {
            topController = presentedController
        }

        return topController
    }

    func currentViewController() -> UIViewController? {
        var currentViewController = topMostWindowController()
        if currentViewController is UITabBarController {
            currentViewController = (currentViewController as! UITabBarController).selectedViewController
        }
        while currentViewController != nil, currentViewController is UINavigationController, (currentViewController as! UINavigationController).topViewController != nil {
            currentViewController = (currentViewController as! UINavigationController).topViewController
        }

        return currentViewController
    }
}

extension UIDevice {
    public static func isX() -> Bool {
        if UIScreen.main.bounds.height >= 812 {
            return true
        }

        return false
    }
}
