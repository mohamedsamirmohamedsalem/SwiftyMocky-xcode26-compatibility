
import Foundation

// MARK: - ExpressibleByStringLiteral

#if !canImport(SwiftUI)
extension Optional:
    ExpressibleByStringLiteral,
    ExpressibleByExtendedGraphemeClusterLiteral,
    ExpressibleByUnicodeScalarLiteral
    where Wrapped: ExpressibleByStringLiteral
{
    public typealias StringLiteralType = Wrapped.StringLiteralType
    public typealias ExtendedGraphemeClusterLiteralType = Wrapped.ExtendedGraphemeClusterLiteralType
    public typealias UnicodeScalarLiteralType = Wrapped.UnicodeScalarLiteralType

    public init(stringLiteral value: StringLiteralType) {
        self = .some(Wrapped.init(stringLiteral: value))
    }

    public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self = .some(Wrapped.init(extendedGraphemeClusterLiteral: value))
    }

    public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self = .some(Wrapped.init(unicodeScalarLiteral: value))
    }
}
#endif  !canImport(SwiftUI) 

extension Parameter:
    ExpressibleByStringLiteral,
    ExpressibleByExtendedGraphemeClusterLiteral,
    ExpressibleByUnicodeScalarLiteral
    where ValueType: ExpressibleByStringLiteral
{
    public typealias StringLiteralType = ValueType.StringLiteralType
    public typealias ExtendedGraphemeClusterLiteralType = ValueType.ExtendedGraphemeClusterLiteralType
    public typealias UnicodeScalarLiteralType = ValueType.UnicodeScalarLiteralType

    public init(stringLiteral value: StringLiteralType) {
        self = .value(ValueType.init(stringLiteral: value))
    }

    public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self = .value(ValueType.init(extendedGraphemeClusterLiteral: value))
    }

    public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self = .value(ValueType.init(unicodeScalarLiteral: value))
    }
}

// MARK: - ExpressibleByNilLiteral

extension Parameter: ExpressibleByNilLiteral where ValueType: ExpressibleByNilLiteral {
    public init(nilLiteral: ()) {
        self = .value(nil)
    }
}

// MARK: - ExpressibleByIntegerLiteral

#if !canImport(SwiftUI)
extension Optional: ExpressibleByIntegerLiteral where Wrapped: ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = Wrapped.IntegerLiteralType

    public init(integerLiteral value: IntegerLiteralType) {
        self = .some(Wrapped.init(integerLiteral: value))
    }
}
#endif  !canImport(SwiftUI) 

extension Parameter: ExpressibleByIntegerLiteral where ValueType: ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = ValueType.IntegerLiteralType

    public init(integerLiteral value: ValueType.IntegerLiteralType) {
        self = .value(ValueType.init(integerLiteral: value))
    }
}

// MARK: - ExpressibleByBooleanLiteral

#if !canImport(SwiftUI)
extension Optional: ExpressibleByBooleanLiteral where Wrapped: ExpressibleByBooleanLiteral {
    public typealias BooleanLiteralType = Wrapped.BooleanLiteralType

    public init(booleanLiteral value: BooleanLiteralType) {
        self = .some(Wrapped.init(booleanLiteral: value))
    }
}
#endif  !canImport(SwiftUI) 

extension Parameter: ExpressibleByBooleanLiteral where ValueType: ExpressibleByBooleanLiteral {
    public typealias BooleanLiteralType = ValueType.BooleanLiteralType

    public init(booleanLiteral value: BooleanLiteralType) {
        self = .value(ValueType.init(booleanLiteral: value))
    }
}

// MARK: - ExpressibleByFloatLiteral

#if !canImport(SwiftUI)
extension Optional: ExpressibleByFloatLiteral where Wrapped: ExpressibleByFloatLiteral {
    public typealias FloatLiteralType = Wrapped.FloatLiteralType

    public init(floatLiteral value: FloatLiteralType) {
        self = .some(Wrapped.init(floatLiteral: value))
    }
}
#endif  !canImport(SwiftUI) 

extension Parameter: ExpressibleByFloatLiteral where ValueType: ExpressibleByFloatLiteral {
    public typealias FloatLiteralType = ValueType.FloatLiteralType

    public init(floatLiteral value: FloatLiteralType) {
        self = .value(ValueType.init(floatLiteral: value))
    }
}

// MARK: - ExpressibleByArrayLiteral

private extension ExpressibleByArrayLiteral {
    init(_ elements: [ArrayLiteralElement]) {
        let castedInit = unsafeBitCast(Self.init(arrayLiteral:), to: (([ArrayLiteralElement]) -> Self).self)
        self = castedInit(elements)  // TODO: Update once splatting is supported. https://bugs.swift.org/browse/SR-128
    }
}

private extension ExpressibleByArrayLiteral where ArrayLiteralElement: Hashable {
    init(_ elements: [ArrayLiteralElement]) {
        let castedInit = unsafeBitCast(Self.init(arrayLiteral:), to: (([ArrayLiteralElement]) -> Self).self)
        self = castedInit(elements)  // TODO: Update once splatting is supported. https://bugs.swift.org/browse/SR-128
    }
}

#if !canImport(SwiftUI)
extension Optional: ExpressibleByArrayLiteral where Wrapped: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = Wrapped.ArrayLiteralElement

    public init(arrayLiteral elements: ArrayLiteralElement...) {
        self = .some(Wrapped.init(elements))
    }
}
#endif  !canImport(SwiftUI) 

extension Parameter: ExpressibleByArrayLiteral where ValueType: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = ValueType.ArrayLiteralElement

    public init(arrayLiteral elements: ArrayLiteralElement...) {
        self = .value(ValueType.init(elements))
    }
}

// MARK: - ExpressibleByDictionaryLiteral

private extension ExpressibleByDictionaryLiteral where Key: Hashable {
    init(_ elements: [(Key, Value)]) {
        let value: [Key: Value] = Dictionary.init(uniqueKeysWithValues: elements)
        self = value as! Self  // TODO: Check if can be fixed. For some reason could not use init(arayLiteral elements: ...)
    }
}

#if !canImport(SwiftUI)
extension Optional: ExpressibleByDictionaryLiteral where Wrapped: ExpressibleByDictionaryLiteral, Wrapped.Key: Hashable, Wrapped == [Wrapped.Key: Wrapped.Value] {
    public typealias Key = Wrapped.Key
    public typealias Value = Wrapped.Value

    public init(dictionaryLiteral elements: (Key, Value)...) {
        let array = Array(elements)
        let value: [Key: Value] = Dictionary(uniqueKeysWithValues: array)
        self = .some(value)
    }
}
#endif  !canImport(SwiftUI) 

extension Parameter: ExpressibleByDictionaryLiteral where ValueType: ExpressibleByDictionaryLiteral, ValueType.Key: Hashable {
    public typealias Key = ValueType.Key
    public typealias Value = ValueType.Value

    public init(dictionaryLiteral elements: (Key, Value)...) {
        let array = Array(elements)
        let value: [Key: Value] = Dictionary(uniqueKeysWithValues: array)
        self = .value(value as! ValueType)
    }
}

