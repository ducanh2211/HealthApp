//
//  Extension.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 06/06/2023.
//

import UIKit

extension UIViewController {
    func hideKeyBoardWhenTapped() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
    }

    @objc private func hideKeyBoard() {
        view.endEditing(true)
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

extension UIColor {
    static func rgba(_ red: CGFloat, _ blue: CGFloat, _ green: CGFloat, _ alpha: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: blue/255, blue: green/255, alpha: alpha)
    }
}

extension UITextField {
    func setPaddingLeft(constant: CGFloat) {
        leftViewMode = .always
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: constant, height: bounds.height))
    }

    func setPaddingRight(constant: CGFloat) {
        rightViewMode = .always
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: constant, height: bounds.height))
    }
}

extension NSMutableAttributedString {
    func appendAttributedString(_ str: String,
                                font: UIFont? = nil,
                                color: UIColor? = nil) -> NSMutableAttributedString {

        var attributes = [NSAttributedString.Key: Any]()

        if let font = font {
            attributes[.font] = font
        }
        if let color = color {
            attributes[.foregroundColor] = color
        }

        let str = NSMutableAttributedString(string: str, attributes: attributes)
        self.append(str)
        return self
    }
}

extension UIView {
    func dropShadow(color: UIColor = .gray, opacity: Float = 0.1,
                    offSet: CGSize = .zero, radius: CGFloat = 1, scale: Bool = true) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
    }
}

extension String {
    func applyPatternOnNumbers(pattern: String, replacementCharacter: Character) -> String {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacementCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
}
