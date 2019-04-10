//
//  QuestionsCollectionViewCell.swift
//  OTGTrivia
//
//  Created by Julio Reyes on 4/8/19.
//  Copyright © 2019 Julio Reyes. All rights reserved.
//

import UIKit

class QuestionsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var answerLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.answerLabel.text = ""
    }
    
    func populateCell(with answer: String){
        answerLabel.text = answer
        answerLabel.font = UIFont.systemFont(ofSize: 18)
    }
}
