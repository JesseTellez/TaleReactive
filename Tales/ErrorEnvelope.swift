import Argo
import Curry
import Runes

public struct ErrorEnvelope {
    public let errorMessages: [String]
    public let ksrCode: KsrCode?
    public let httpCode: Int
    
    public init(errorMessages: [String], ksrCode: KsrCode?, httpCode: Int) {
        self.errorMessages = errorMessages
        self.ksrCode = ksrCode
        self.httpCode = httpCode
    }
    
    public enum KsrCode: String {
        // Codes defined by the server
        case AccessTokenInvalid = "access_token_invalid"
        case InvalidXauthLogin = "invalid_xauth_login"
        
        // Catch all code for when server sends code we don't know about yet
        case UnknownCode = "__internal_unknown_code"
        
        // Codes defined by the client
        case JSONParsingFailed = "json_parsing_failed"
        case ErrorEnvelopeJSONParsingFailed = "error_json_parsing_failed"
        case DecodingJSONFailed = "decoding_json_failed"
        case InvalidPaginationUrl = "invalid_pagination_url"
    }

    /**
     A general error that JSON could not be parsed.
     */
    internal static let couldNotParseJSON = ErrorEnvelope(
        errorMessages: [],
        ksrCode: .JSONParsingFailed,
        httpCode: 400
    )
    
    /**
     A general error that the error envelope JSON could not be parsed.
     */
    internal static let couldNotParseErrorEnvelopeJSON = ErrorEnvelope(
        errorMessages: ["something herere"],
        ksrCode: .ErrorEnvelopeJSONParsingFailed,
        httpCode: 400
    )
    
    /**
     A general error that some JSON could not be decoded.
     - parameter decodeError: The Argo decoding error.
     - returns: An error envelope that describes why decoding failed.
     */
    internal static func couldNotDecodeJSON(_ decodeError: DecodeError) -> ErrorEnvelope {
        return ErrorEnvelope(
            errorMessages: ["Argo decoding error: \(decodeError.description)"],
            ksrCode: .DecodingJSONFailed,
            httpCode: 400
        )
    }
    
    /**
     A error that the pagination URL is invalid.
     - parameter decodeError: The Argo decoding error.
     - returns: An error envelope that describes why decoding failed.
     */
    internal static let invalidPaginationUrl = ErrorEnvelope(
        errorMessages: [],
        ksrCode: .InvalidPaginationUrl,
        httpCode: 400
    )
}

extension ErrorEnvelope: Error {}

extension ErrorEnvelope: Decodable {
    public static func decode(_ json: JSON) -> Decoded<ErrorEnvelope> {
        let create = curry(ErrorEnvelope.init)
        
        // Typically API errors come back in this form...
        let standardErrorEnvelope = create
            <^> json <|| "error_messages"
            <*> json <|? "ksr_code"
            <*> json <| "http_code"
        
        
        return standardErrorEnvelope
    }
}

extension ErrorEnvelope.KsrCode: Decodable {
    public static func decode(_ j: JSON) -> Decoded<ErrorEnvelope.KsrCode> {
        switch j {
        case let .string(s):
            return pure(ErrorEnvelope.KsrCode(rawValue: s) ?? ErrorEnvelope.KsrCode.UnknownCode)
        default:
            return .typeMismatch(expected: "ErrorEnvelope.KsrCode", actual: j)
        }
    }
}


// Concats an array of decoded arrays into a decoded array. Ignores all failed decoded values, and so
// always returns a successfully decoded value.
private func concatSuccesses<A>(_ decodeds: [Decoded<[A]>]) -> Decoded<[A]> {
    
    return decodeds.reduce(Decoded.success([])) { accum, decoded in
        .success( (accum.value ?? []) + (decoded.value ?? []) )
    }
}
