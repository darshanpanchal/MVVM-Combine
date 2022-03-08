//
//  SceneDelegate.swift
//  MVVM
//
//  Created by Darshan on 04/03/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    var logInViewController = UIStoryboard.mainStoryBoard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
    var homeViewController = UIStoryboard.mainStoryBoard.instantiateViewController(withIdentifier: "ListViewController") as? ListViewController
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let rootWindow = UIWindow.init(windowScene: windowScene)
        var rootNavigationController:UINavigationController?
        if let isUserLoggedIn = UserDefaults.standard.value(forKey: kIsUserLoggedIn) as? Bool{
            let rootViewControllerAlreadyLogin = UINavigationController.init(rootViewController: logInViewController!)
            rootViewControllerAlreadyLogin.pushViewController(homeViewController!, animated: false)
            rootNavigationController = isUserLoggedIn ? rootViewControllerAlreadyLogin  : UINavigationController.init(rootViewController: logInViewController!)
        }else{
            rootNavigationController = UINavigationController.init(rootViewController: logInViewController!)
        }
        if let rootNavigation = rootNavigationController{
            rootWindow.rootViewController = rootNavigation
        }
        self.window = rootWindow

    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

