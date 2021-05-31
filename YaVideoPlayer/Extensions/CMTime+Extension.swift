//
//  CMTime+Extension.swift
//  YaVideoPlayer
//
//  Created by Георгий Кашин on 30.05.2021.
//

import AVFoundation

extension CMTime {
    func getTimeString() -> String {
        let totalSeconds = CMTimeGetSeconds(self)
        let hours = Int(totalSeconds / 3600)
        let minutes = Int(totalSeconds / 60) % 60
        let seconds = Int(totalSeconds.truncatingRemainder(dividingBy: 60))
        
        if hours > 0 {
            return String(format: "%i:%02i:%02i", arguments: [hours, minutes, seconds])
        } else {
            return String(format: "%02i:%02i", arguments: [minutes, seconds])
        }
    }
}
