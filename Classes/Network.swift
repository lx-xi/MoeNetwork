//
//  Network.swift
//  MoeNetwork
//
//  Created by Zed on 2019/8/26.
//


// MARK: 请求
extension Request {
    /// 请求报头域（请求头）
    public typealias HeadeField = [String: String]
    
    /// 请求方法
    public enum Method: String {
        case get    = "GET"
        case post   = "POST"
        case put    = "PUT"
        case delete = "DELETE"
        case head   = "HEAD"
        case patch  = "PATCH"
    }

    /// 请求参数
    public typealias Parameter = [String: Any]

    /// 参数编码
    public enum ParameterEncoding {
        case urlEncoding
        case jsonEncoding
        case xmlEncoding
    }
}


// MARK: 响应
extension Response {
    /// 序列化器
    public enum Serializer {
//        case data
//        case string
        case json
        /// 暂未测试
        case xml
        case handyJson(HandyObject.Type)
        
        public var responseType: HandyObject.Type? {
            switch self {
            case .handyJson(let type):
                return type
            default:
                return nil
            }
        }
    }
}
