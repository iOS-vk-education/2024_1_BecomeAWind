import UIKit
import Cloudinary

final class ImageService {

    static let shared = ImageService()

    let cloudName: String = "dc72tjhk3"
    var uploadPreset: String = "images"
    var cloudinary: CLDCloudinary!

    private init() {
        setCloudinary()
        Logger.Database.imageServiceInited()

        uploadImage(image: UIImage(named: "chess")!) { result in
            switch result {
            case .success(let imageUrl):
                print(imageUrl)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func setCloudinary() {
        let config = CLDConfiguration(cloudName: cloudName, secure: true)
        cloudinary = CLDCloudinary(configuration: config)
    }

}

extension ImageService {

    func uploadImage(image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        guard let data = image.pngData() else {
            completion(.failure(NSError(
                domain: "ImageConversion",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Failed to convert UIImage to PNG"]))
            )
            return
        }

        cloudinary.createUploader().upload(data: data, uploadPreset: uploadPreset) { response, error in
            DispatchQueue.main.async {
                if let url = response?.secureUrl {
                    completion(.success(url))
                } else if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(NSError(domain: "Upload", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown upload error"])))
                }
            }
        }
    }

}
