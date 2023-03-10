//
//  ShopPreviewDelegate.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/10.
//

import Foundation

protocol ShopPreviewDelegate: AnyObject {
    func updateSesac(sesac: SesacImageCase)

    func updateBackground(background: SesacBackgroundCase)

    func transmitPurchaseSesacProduct(sesac: SesacImageCase)

    func transmitPurchaseBackgroundProduct(background: SesacBackgroundCase)
}
