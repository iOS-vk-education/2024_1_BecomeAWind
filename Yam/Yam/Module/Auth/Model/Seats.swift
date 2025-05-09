struct Seats: Hashable, Codable {

    var busy: Int
    var all: Int

    var representation: [String: Any] {
        var res = [String: Any]()

        res["busy"] = busy
        res["all"] = all

        return res
    }

}
