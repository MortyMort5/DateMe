//
//  ConnectionViewController.swift
//  DateMe
//
//  Created by Sterling Mortensen on 5/10/17.
//  Copyright © 2017 Sterling Mortensen. All rights reserved.
//

import UIKit
import Foundation

class ConnectionViewController: UIViewController, DraggableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        exampleCardLabels = ["first", "second", "third", "fourth", "last"]
        self.loadCards()
    }
    
    //==============================================================
    // MARK: - Properties
    //==============================================================
    var cardsLoadedIndex: Int = 0
    var loadedCards: [DraggableView] = []
    var allCards: [DraggableView] = []
    var exampleCardLabels: [String] = []
    let CARD_HEIGHT: CGFloat = 386
    let CARD_WIDTH: CGFloat = 290
    let MAX_BUFFER_SIZE = 2
    
    //==============================================================
    // MARK: - IBOutlets
    //==============================================================
    @IBOutlet weak var cardView: UIView!
    
    //==============================================================
    // MARK: - IBActions
    //==============================================================
    @IBAction func dontLikeButtonTapped(_ sender: Any) {
        if loadedCards.count <= 0 {
            return
        }
        let dragView: DraggableView = loadedCards[0]
        dragView.overlayView.setMode(GGOverlayViewMode.ggOverlayViewModeLeft)
        UIView.animate(withDuration: 0.2, animations: {
            () -> Void in
            dragView.overlayView.alpha = 1
        })
        dragView.leftClickAction()
    }
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        if loadedCards.count <= 0 {
            return
        }
        let dragView: DraggableView = loadedCards[0]
        dragView.overlayView.setMode(GGOverlayViewMode.ggOverlayViewModeRight)
        UIView.animate(withDuration: 0.2, animations: {
            () -> Void in
            dragView.overlayView.alpha = 1
        })
        dragView.rightClickAction()
    }
    
    @IBAction func locationButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func profileButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "toProfileSegue", sender: self)
    }
    
    //==============================================================
    // MARK: - Draggable Cards Functions
    //==============================================================
    func loadCards() -> Void {
        if exampleCardLabels.count > 0 {
            let numLoadedCardsCap = exampleCardLabels.count > MAX_BUFFER_SIZE ? MAX_BUFFER_SIZE : exampleCardLabels.count
            for i in 0 ..< exampleCardLabels.count {
                let newCard: DraggableView = self.createDraggableViewWithDataAtIndex(i)
                allCards.append(newCard)
                if i < numLoadedCardsCap {
                    loadedCards.append(newCard)
                }
            }
            
            for i in 0 ..< loadedCards.count {
                if i > 0 {
                    cardView.insertSubview(loadedCards[i], belowSubview: loadedCards[i - 1])
                } else {
                    cardView.addSubview(loadedCards[i])
                }
                cardsLoadedIndex = cardsLoadedIndex + 1
            }
        }
    }
    
    func createDraggableViewWithDataAtIndex(_ index: NSInteger) -> DraggableView {
        let draggableView = DraggableView(frame: CGRect(x: (cardView.frame.size.width - CARD_WIDTH)/2, y: (cardView.frame.size.height - CARD_HEIGHT)/2, width: CARD_WIDTH, height: CARD_HEIGHT))
        draggableView.information.text = exampleCardLabels[index]
        draggableView.delegate = self
        return draggableView
    }

    func cardSwipedLeft(_ card: UIView) -> Void {
        loadedCards.remove(at: 0)
        
        if cardsLoadedIndex < allCards.count {
            loadedCards.append(allCards[cardsLoadedIndex])
            cardsLoadedIndex = cardsLoadedIndex + 1
            cardView.insertSubview(loadedCards[MAX_BUFFER_SIZE - 1], belowSubview: loadedCards[MAX_BUFFER_SIZE - 2])
        }
    }
    
    func cardSwipedRight(_ card: UIView) -> Void {
        loadedCards.remove(at: 0)
        
        if cardsLoadedIndex < allCards.count {
            loadedCards.append(allCards[cardsLoadedIndex])
            cardsLoadedIndex = cardsLoadedIndex + 1
            cardView.insertSubview(loadedCards[MAX_BUFFER_SIZE - 1], belowSubview: loadedCards[MAX_BUFFER_SIZE - 2])
        }
    }
}







