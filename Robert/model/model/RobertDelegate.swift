//
//  RobertDelegate.swift
//  Robert
//
//  Created by Vincent O'Sullivan on 18/06/2017.
//  Copyright © 2017 Rose Cottage Industry. All rights reserved.
//

import Foundation

protocol RobertDelegate {

    func didStartNewGame()

    func didSelect(_ deck: RobertDeck)
}
