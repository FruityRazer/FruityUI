//
//  ImageCache.swift
//  AsyncImage
//
//  Created by Vadym Bulavin on 2/19/20.
//  Copyright © 2020 Vadym Bulavin. All rights reserved.
//

import AppKit

protocol ImageCache {
    subscript(_ url: URL) -> NSImage? { get set }
}

struct TemporaryImageCache: ImageCache {
    private let cache = NSCache<NSURL, NSImage>()
    
    subscript(_ key: URL) -> NSImage? {
        get { cache.object(forKey: key as NSURL) }
        set { newValue == nil ? cache.removeObject(forKey: key as NSURL) : cache.setObject(newValue!, forKey: key as NSURL) }
    }
}
