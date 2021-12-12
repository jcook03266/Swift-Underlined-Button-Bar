//  underlinedButtonBar.swift
//
//  Created by Justin Cook on 12/11/21.
//

import Foundation
import UIKit

/** A UIView that hosts an array of buttons that have an 'underline' UIView beneath them which moves from button to button when the user presses on them*/
public class underlinedButtonBar: UIView{
    var buttons: [UIButton]
    var animated: Bool
    var height: CGFloat
    var width: CGFloat
    var underline = UIView()
    var underlineTrack = UIView()
    var underlineHeight: CGFloat
    var underlineColor: UIColor
    var underlineTrackColor: UIColor
    
    /** Each button will be positioned inside of this stackview horizontally with adequate spacing in between them*/
    var stackView = UIStackView()
    
    init(buttons: [UIButton], width: CGFloat, height: CGFloat, underlineColor: UIColor, underlineTrackColor: UIColor, underlineHeight: CGFloat, backgroundColor: UIColor, animated: Bool){
        self.buttons = buttons
        self.width = width
        self.height = height
        self.underlineColor = underlineColor
        self.underlineTrackColor = underlineTrackColor
        self.underlineHeight = underlineHeight
        self.animated = animated
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        self.backgroundColor = backgroundColor
        
        constructUI()
    }
    
    func constructUI(){
        stackView = UIStackView(frame: self.frame)
        stackView.frame.size.height = stackView.frame.height - underlineHeight
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        //Note: This doesn't autoresize the views to fill the stackview, don't use it
        //stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isUserInteractionEnabled = true
        stackView.semanticContentAttribute = .forceLeftToRight
        
        for button in buttons{
            stackView.addArrangedSubview(button)
        }
  
        underlineTrack.frame = CGRect(x: 0, y: stackView.frame.maxY, width: width, height: underlineHeight)
        
        underlineTrack.backgroundColor = underlineTrackColor
        underline.backgroundColor = underlineColor
        
        /** Make the underline the size of the first button's title label and position it directly underneath that first button*/
        underline.frame.size.width = (buttons[0].titleLabel?.frame.width)!
        underline.frame.size.height = underlineHeight
        
        /** Coerce the view stored at this index in the stackview into being a UIButton because that's what's only being stored in this stackview anyways*/
        let button = stackView.arrangedSubviews[0] as! UIButton
        
        /** This is the offset from the minX of the button's frame to the title label inside of it*/
        let offSet = (button.titleLabel?.frame.minX)! + button.frame.minX
        
        underline.frame.origin = CGPoint(x: offSet, y: 0)
        
        self.addSubview(stackView)
        self.addSubview(underlineTrack)
        underlineTrack.addSubview(underline)
    }
    
    /** Moves the underline to the specified butto IF the button is in the button array*/
    func moveUnderLineTo(this passedButton: UIButton){
        for (index, button) in buttons.enumerated(){
            if passedButton == button{
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn){[self] in
                    let button = stackView.arrangedSubviews[index] as! UIButton
                    
                    let offSet = (button.titleLabel?.frame.minX)! + button.frame.minX
       
                underline.frame.size.width = (buttons[index].titleLabel?.frame.width)!
                    underline.frame.origin = CGPoint(x: offSet, y: 0)
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
