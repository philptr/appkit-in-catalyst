//
//  AKTest.swift
//  AKTest
//
//  Created by Phil Zet on 10/31/20.
//

import AppKit

@objc class AKTest: NSObject {
    
    private var slider = NSSlider(frame: NSRect(x: 0, y: 0, width: 500, height: 500))
    private var target: NSObject?
    private var sliderValueChangedCallback: String?
    
    private var _nsWindow: NSWindow?
    private var window: AnyObject? {
        get {
            return _nsWindow
        }
        set {
            _nsWindow = nsWindowBridge(for: newValue)
        }
    }
    
    private var contentView: NSView? {
        return _nsWindow?.contentView
    }
    
    private func nsWindowBridge(for object: AnyObject?) -> NSWindow? {
        return object as? NSWindow
    }
    
    public override init() {
        super.init()
    }
    
    @objc public func setWindow(_ window: AnyObject?) {
        self.window = window
    }
    
    @objc public func toggleFullScreen() {
        _nsWindow?.toggleFullScreen(self)
    }
    
    @objc public func setTarget(_ target: NSObject) {
        self.target = target
    }
    
    @objc public func setupSlider(_ callback: String) {
        slider.isContinuous = true
        contentView?.addSubview(slider)
        slider.target = self
        slider.action = #selector(self.sliderValueChanged(_:))
        print(callback.description)
        sliderValueChangedCallback = callback
    }
    
    @objc func sliderValueChanged(_ sender: NSSlider) {
        if let callback = sliderValueChangedCallback {
            target?.perform(Selector(callback), with: sender.stringValue)
        }
    }
    
}

