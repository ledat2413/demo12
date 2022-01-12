//
//  FLView.swift
//  Runner
//
//  Created by Peterrr on 12/01/2022.
//

import UIKit

class FLView: UIView {
    
    @IBOutlet weak var textLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
   func setupView(){
//        Bundle.main.loadNibNamed("FLView", owner: self, options: nil)
    }

}
