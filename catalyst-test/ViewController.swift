//
//  ViewController.swift
//  catalyst-test
//
//  Created by Phil Zet on 10/31/20.
//

import UIKit

extension UIApplication {
    var currentWindow: UIWindow? {
        UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var sliderValueLabel: UILabel!
    
    func nsWindow(from window: UIWindow) -> AnyObject? {
        guard let nsWindows = NSClassFromString("NSApplication")?.value(forKeyPath: "sharedApplication.windows") as? [AnyObject] else { return nil }
        for nsWindow in nsWindows {
            let uiWindows = nsWindow.value(forKeyPath: "uiWindows") as? [UIWindow] ?? []
            if uiWindows.contains(window) {
                return nsWindow
            }
        }
        return nil
    }
    
    var akInterface: NSObject!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let uiWindow = UIApplication.shared.currentWindow else { return }
        print(uiWindow)
        guard let nsWindow = self.nsWindow(from: uiWindow) else { return }
        print(nsWindow)
        
        let path: String = Bundle.main.builtInPlugInsURL!.appendingPathComponent("AKTest.bundle").path
        let bundle = Bundle(path: path)
        if let isLoaded = bundle?.load(), isLoaded {
            let principalClass: NSObject.Type = bundle?.principalClass as! NSObject.Type
            akInterface = principalClass.init()
            akInterface.perform(Selector("setWindow:"), with: nsWindow)
            akInterface.perform(Selector("toggleFullScreen"))
            akInterface.perform(Selector("setTarget:"), with: self)
            akInterface.perform(Selector("setupSlider:"), with: "uiSliderValueChanged:")
        }
    }
    
    @objc public func uiSliderValueChanged(_ newValue: String) {
        let intValue: Int = Int((Double(newValue) ?? 0) * 100)
        sliderValueLabel.text = "\(intValue)"
    }

}
