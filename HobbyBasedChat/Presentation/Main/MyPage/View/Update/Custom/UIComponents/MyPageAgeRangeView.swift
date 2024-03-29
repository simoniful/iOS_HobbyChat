//
//  MyPageCardAgeRangeView.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/09.
//

import UIKit
import DoubleSlider

final class MyPageAgeRangeView: UIView {
  private let titleLabel = BaseLabel(title: "상대방 연령대", font: .title4R14)
  private let rangeLabel = BaseLabel(title: "20: 30", font: .title3M14)
  private let doubleSlider = DoubleSlider()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupConstraints()
    setupAttributes()
  }
  
  required init(coder: NSCoder) {
    fatalError("SesacTitleView: fatal error")
  }
  
  private func setupConstraints() {
    addSubview(rangeLabel)
    addSubview(titleLabel)
    addSubview(doubleSlider)
    rangeLabel.snp.makeConstraints { make in
      make.right.top.equalToSuperview()
      make.width.equalTo(50)
      make.height.equalTo(80)
    }
    titleLabel.snp.makeConstraints { make in
      make.left.top.equalToSuperview()
      make.right.equalTo(rangeLabel.snp.left).offset(-16)
      make.centerY.equalTo(rangeLabel.snp.centerY)
    }
    doubleSlider.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(-20)
      make.left.right.equalToSuperview()
      make.height.equalTo(40)
    }
  }
  
  private func setupAttributes() {
    titleLabel.textAlignment = .left
    rangeLabel.textColor = .green
    doubleSlider.thumbTintColor = .green
    doubleSlider.trackTintColor = .gray2
    doubleSlider.trackHighlightTintColor = .green
    doubleSlider.layerInset = 10
    doubleSlider.minLabel.isHidden = true
    doubleSlider.maxLabel.isHidden = true
    doubleSlider.editingDidEndDelegate = self
    doubleSlider.numberOfSteps = 48
    doubleSlider.smoothStepping = false
    setAgeSlider(ageMin: 20, ageMax: 30)
  }
  
  func setAgeSlider(ageMin: Int, ageMax: Int) {
    doubleSlider.lowerValueStepIndex = ageMin - 18
    doubleSlider.upperValueStepIndex = ageMax - 18
    rangeLabel.text = "\(ageMin): \(ageMax)"
  }
  
  func getAgeRange() -> (Int, Int) {
    let lower = 18 + doubleSlider.lowerValueStepIndex
    let upper = 18 + doubleSlider.upperValueStepIndex
    return (lower, upper)
  }
}

extension MyPageAgeRangeView: DoubleSliderEditingDidEndDelegate {
  func editingDidEnd(for doubleSlider: DoubleSlider) {
    let lower = 18 + doubleSlider.lowerValueStepIndex
    let upper = 18 + doubleSlider.upperValueStepIndex
    rangeLabel.text = "\(lower): \(upper)"
  }
}
