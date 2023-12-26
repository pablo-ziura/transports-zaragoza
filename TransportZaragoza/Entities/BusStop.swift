import Foundation

struct BusStop: Codable, Identifiable {
    let id: String
    let title: String
    let location: Coordinates
    let busLine: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "title"
        case location = "geometry"
        case busLine
    }
    
    static var example: BusStop {
        .init(
            id: "tuzsa-688",
            title: "(688) P. Reyes De Aragón N.º 24 Líneas: 58, 41, 22",
            location: Coordinates(coordinates: [-0.884626111810379,41.68681362815634]),
            busLine: "22"
        )
    }
}

struct BusStopData: Decodable {
    let geometry: Geometry
    let destinos: [ArrivalBus]
}

struct BusStopDetail {
    let busStop: BusStop
    let details: BusStopData
}

struct Geometry: Decodable {
    let type: String
    let coordinates: [Double]
}

struct ArrivalBus: Decodable {
    let linea: String
    let destino: String
    let primero: String
    let segundo: String
}
