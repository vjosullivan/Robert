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

    private let robert: Robert

    // MARK: - Outlets.

    @IBOutlet weak var stockPlayability: UILabel!
    @IBOutlet weak var wastePlayability: UILabel!
    
    @IBOutlet weak var stock: UIImageView!
    @IBOutlet weak var suite: UIImageView!
    @IBOutlet weak var waste: UIImageView!

    @IBOutlet weak var activeStock: UILabel!
    @IBOutlet weak var activeSuite: UILabel!
    @IBOutlet weak var activeWaste: UILabel!

    @IBOutlet weak var gameState: UILabel!

    // MARK: - Initializers.

    init(robert: Robert) {
        self.robert = robert
        super.init(nibName: nil, bundle: nil)
        self.robert.delegate = self
    }

    required init?(coder aDecoder: NSCoder) { fatalError("RobertViewControler: init(coder) not implemented.") }

    // MARK: - UIViewController functions.

    override func viewDidLoad() {
        super.viewDidLoad()

        robert.newGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Actions.

    @IBAction func stockTapped(_ sender: UIButton) {
        print("UI stock tapped.")
        robert.selectStock()
    }

    @IBAction func suiteTapped(_ sender: UIButton) {
        print("UI suite tapped.")
        robert.selectSuite()
    }

    @IBAction func wasteTapped(_ sender: UIButton) {
        print("UI waste tapped.")
        robert.selectWaste()
    }
}

extension RobertViewController: RobertDelegate {

    func robertDidStart(_ robert: Robert) {
        // TODO: Update any new game indicators.
    }

    func robert(_ robert: Robert, didSelectDeck deck: Robert.SelectedDeck) {
        switch deck {
        case .none:
            activeStock.text = "\(robert.stock.cardCount)"
            activeSuite.text = "\(robert.suite.cardCount)"
            activeWaste.text = "\(robert.waste.cardCount)"
        case .stock:
            activeStock.text = "<<< \(robert.stock.cardCount) >>>"
            activeSuite.text = "\(robert.suite.cardCount)"
            activeWaste.text = "\(robert.waste.cardCount)"
        case .waste:
            activeStock.text = "\(robert.stock.cardCount)"
            activeSuite.text = "\(robert.suite.cardCount)"
            activeWaste.text = "<<< \(robert.waste.cardCount) >>>"
        }
    }

    func robert(_ robert: Robert, didChangeState state: Robert.State) {
        switch state {
        case .firstRound:
            self.gameState.text = "First Round"
        case .firstRoundCompleted:
            self.gameState.text = "First Round Completed"
        case .secondRound:
            self.gameState.text = "Second Round"
        case .secondRoundCompleted:
            self.gameState.text = "Second Round Completed"
        case .finalRound:
            self.gameState.text = "Final Round"
        case .gameLost:
            self.gameState.text = "Game Lost"
        case .gameWon:
            self.gameState.text = "Game Won"
        }
    }

    func robertDidMoveCards(_ robert: Robert) {
        stock.image = UIImage(named: "\(robert.stockImageName)")
        suite.image = UIImage(named: "\(robert.suiteImageName)")
        waste.image = UIImage(named: "\(robert.wasteImageName)")
        activeStock.text = "\(robert.stock.cardCount)"
        activeSuite.text = "\(robert.suite.cardCount)"
        activeWaste.text = "\(robert.waste.cardCount)"
        if robert.stockPlayable {
            stockPlayability.text = "✓"
            stockPlayability.textColor = UIColor.yellow
        } else {
            stockPlayability.text = "✗"
            stockPlayability.textColor = UIColor.red
        }
        if robert.wastePlayable {
            wastePlayability.text = "✓"
            wastePlayability.textColor = UIColor.yellow
        } else {
            wastePlayability.text = "✗"
            wastePlayability.textColor = UIColor.red
        }
    }
}
