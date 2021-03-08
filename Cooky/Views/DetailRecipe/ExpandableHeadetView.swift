//
//  ExpandableHeadetView.swift
//  Cooky
//
//  Created by Oleg Krikun on 08.03.2021.
//

import UIKit

protocol ExpandableHeadetViewDelegate {
    func toggleSection(header: ExpandableHeadetView, section: Int)
}

class ExpandableHeadetView: UITableViewHeaderFooterView {

    var delegate: ExpandableHeadetViewDelegate?
    var section: Int?
    
    func setup(withTitle title: String, section: Int, delegate: ExpandableHeadetViewDelegate) {
        self.delegate = delegate
        self.section = section
        self.textLabel?.text = title
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.textColor = .white
        contentView.backgroundColor = .black
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
         
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func selectHeaderAction(gestureRecognizer: UIGestureRecognizer) {
        let cell = gestureRecognizer.view as! ExpandableHeadetView
        guard let section = cell.section else { return }
        delegate?.toggleSection(header: self, section: section)
    }
}
