//
//  StopWatchConverter.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/07.
//

import Foundation

struct StopWatchConverter {
  var totalSeconds: Int
  var minutes: Int { return (totalSeconds % 3600) / 60 }
  var seconds: Int { return totalSeconds % 60 }
}

extension StopWatchConverter {
  var simpleTimeString: String {
    let minutesText = timeText(from: minutes)
    let secondsText = timeText(from: seconds)
    return "\(minutesText):\(secondsText)"
  }
  
  private func timeText(from number: Int) -> String {
    return number < 10 ? "0\(number)" : "\(number)"
  }
}
