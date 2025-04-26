import UIKit
import Cloudinary
import SDWebImageSwiftUI

enum ImageServiceError: Error {
    case notJpegData
}

final class ImageService {

    static let shared = ImageService()

    let cloudName: String = "dc72tjhk3"
    var uploadPreset: String = "images"
    var cloudinary: CLDCloudinary!

    private init() {
        setCloudinary()
        Logger.Database.imageServiceInited()
    }

    private func setCloudinary() {
        let config = CLDConfiguration(cloudName: cloudName, secure: true)
        cloudinary = CLDCloudinary(configuration: config)
    }

}

extension ImageService {

    func uploadImage(_ image: UIImage) async throws -> String {
        guard let data = image.jpegData(compressionQuality: 0.8) else {
            Logger.BuildEvent.notJpegData()
            throw ImageServiceError.notJpegData
        }

        return try await withCheckedThrowingContinuation { continuation in
            cloudinary.createUploader().upload(data: data, uploadPreset: uploadPreset) { response, error in

                DispatchQueue.main.async {
                    if let url = response?.secureUrl {
                        continuation.resume(returning: url)
                        Logger.BuildEvent.imageUploadSuccess(with: url)
                    } else if let error = error {
                        Logger.printErrorDescription(error)
                        continuation.resume(throwing: error)
                    } else {
                        let unknownError = NSError(
                            domain: "ImageService",
                            code: -1,
                            userInfo: [NSLocalizedDescriptionKey: "Unknown error during image upload"]
                        )
                        Logger.printErrorDescription(unknownError)
                        continuation.resume(throwing: unknownError)
                    }
                }

            }
        }

    }

    func downloadImage(from path: String)/* -> UIImage*/ {

    }

}
