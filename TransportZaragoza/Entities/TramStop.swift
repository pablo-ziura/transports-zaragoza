import Foundation

struct TramStop: Codable, Identifiable {
    let id: String
    let detailURL: String
    let title: String
    let location: Coordinates
    let updateTime: String
    let destinos: [Destino]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case detailURL = "uri"
        case title = "title"
        case location = "geometry"
        case updateTime = "lastUpdated"
        case destinos = "destinos"
    }

    static var example: TramStop {
        .init(
            id: "101",
            detailURL: "http://www.zaragoza.es/ciudad/viapublica/movilidad/detalle_Tranvia?oid=101",
            title: "AVENIDA DE LA ACADEMIA",
            location: Coordinates(coordinates: [-0.884626111810379,41.68681362815634]),
            updateTime: "2023-11-13T21:27:01",
            destinos: [Destino(linea: "L1", destino: "MAGO DE OZ", minutos: 8), Destino(linea: "L1", destino: "MAGO DE OZ", minutos: 14)]
        )
    }
}

struct Coordinates: Codable {
    let coordinates: [Double]
}

struct Destino: Codable {
    let linea: String
    let destino: String
    let minutos: Int
}
