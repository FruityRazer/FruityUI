//
//  ClosableWindow.swift
//  FruityUI
//
//  Based on https://github.com/onmyway133/blog/issues/312.
//

import AppKit

class ClosableWindow: NSWindow {
    override func close() {
        self.orderOut(NSApp)
    }
}
