//
//  AVPlayer+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import class AVFoundation.AVPlayer

/// Useful additions to AVPlayer
public extension AVPlayer {

    // MARK: - Public -
    // MARK: Properties

    /// Defines if the player is playing.
    public var isPlaying: Bool {

        return self.rate != 0.0
    }
}

/// Dummy struct to import AVFoundation/AVPlayer module.
public struct AVPlayerAdditions {
    
    @available (*, unavailable) private init() {
        
        fatalError("\(self) cannot be initialized.")
    }
}
