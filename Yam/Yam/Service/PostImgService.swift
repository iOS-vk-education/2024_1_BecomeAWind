
final class PostImgService {

    static let shared = PostImgService()

    private init() {
        Logger.Database.postImgServiceInited()
    }

}
