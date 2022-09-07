//
//  ImageView+setImage.swift
//  GojekAssignment
//
//  Created by Khoa Pham on 06/09/2022.
//

import UIKit

extension UIImageView {
  func setImage(with url: URL?) {
    guard let url = url else {
      image = nil
      return
    }

    DispatchQueue.global(qos: .background).async { [weak self] in
      guard let strongSelf = self else { return }
      URLSession.shared.dataTask(with: url) { data, response, error in
        var result: UIImage? = nil
        if let data = data, let newImage = UIImage(data: data) {
          result = newImage
        } else {
          print("Fetch image error: \(error?.localizedDescription ?? "n/a")")
        }
        DispatchQueue.main.async {
          strongSelf.image = result
        }
      }.resume()
    }
  }
}
