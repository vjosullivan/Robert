//
//  ViewController.swift
//  Robert
//
//  Created by Vincent O'Sullivan on 18/06/2017.
//  Copyright © 2017 Rose Cottage Industry. All rights reserved.
//

import UIKit

class RobertViewController: UIViewController {

    // MARK: - Local constants and variables.

    private let game: Robert

    // MARK: - Outlets.

    @IBOutlet weak var stock: UIButton!
    @IBOutlet weak var suite: UIButton!
    @IBOutlet weak var waste: UIButton!

    @IBOutlet weak var activeStock: UILabel!
    @IBOutlet weak var activeSuite: UILabel!
    @IBOutlet weak var activeWaste: UILabel!

    @IBOutlet weak var gameState: UILabel!

    // MARK: - Initializers.

    init(game: Robert) {
        self.game     = game
        super.init(nibName: nil, bundle: nil)
        game.delegate = self
    }

    required init?(coder aDecoder: NSCoder) { fatalError("RobertViewControler: init(coder) not implemented.") }

    // MARK: - UIViewController functions.

    override func viewDidLoad() {
        super.viewDidLoad()

        game.newGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Actions.

    @IBAction func stockTapped(_ sender: UIButton) {
        print("UI stock tapped.")
        game.selectStock()
    }

    @IBAction func suiteTapped(_ sender: UIButton) {
        print("UI suite tapped.")
        game.selectSuite()
    }

    @IBAction func wasteTapped(_ sender: UIButton) {
        print("UI waste tapped.")
        game.selectWaste()
    }
}

extension RobertViewController: RobertDelegate {
    func didStartNewGame() {
        // TODO: Update any new game indicators.
    }

    func didSelect(_ deck: Robert.ActiveDeck) {
        switch deck {
        case .none:
            activeStock.text = "n"
            activeSuite.text = "n"
            activeWaste.text = "n"
        case .stock:
            activeStock.text = "STOCK"
            activeSuite.text = "x"
            activeWaste.text = "x"
        case .waste:
            activeStock.text = "x"
            activeSuite.text = "x"
            activeWaste.text = "WASTE"
        }
    }

    func didChangeState(to gameState: Robert.GameState) {
        switch gameState {
        case .firstDeal:
            self.gameState.text = "First Deal"
        case .firstDealPlayedOut:
            self.gameState.text = "First Deal Played Out"
        case .secondDeal:
            self.gameState.text = "Second Deal"
        case .gameLost:
            self.gameState.text = "Game Lost"
        case .gameWon:
            self.gameState.text = "Game Won"
        }
    }

    func didMoveCards() {
        stock.setImage(UIImage(named: "\(game.stockImageName)"), for: .normal)
        suite.setImage(UIImage(named: "\(game.suiteImageName)"), for: .normal)
        waste.setImage(UIImage(named: "\(game.wasteImageName)"), for: .normal)
        activeStock.text = "\(activeStock.text ?? "") \(game.stock.cardCount)"
        activeSuite.text = "\(activeSuite.text ?? "") \(game.suite.cardCount)"
        activeWaste.text = "\(activeWaste.text ?? "") \(game.waste.cardCount)"
    }
}
