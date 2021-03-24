import UIKit

extension UIView {

    func anchor(
        top: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        right: NSLayoutXAxisAnchor? = nil,
        paddingTop: CGFloat? = 0,
        paddingLeft: CGFloat? = 0,
        paddingBottom: CGFloat? = 0,
        paddingRight: CGFloat? = 0,
        width: CGFloat? = nil,
        height: CGFloat? = nil
    ) {
        translatesAutoresizingMaskIntoConstraints = false

        if let top = top, let paddingTop = paddingTop {
            topAnchor.constraint(equalTo: top,
                                 constant: paddingTop).isActive = true
        }

        if let left = left, let paddingLeft = paddingLeft {
            leftAnchor.constraint(equalTo: left,
                                  constant: paddingLeft).isActive = true
        }

        if let bottom = bottom, let paddingBottom = paddingBottom {
            bottomAnchor.constraint(equalTo: bottom,
                                    constant: -paddingBottom).isActive = true
        }

        if let right = right, let paddingRight = paddingRight {
            rightAnchor.constraint(equalTo: right,
                                   constant: -paddingRight).isActive = true
        }

        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }

        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
