//
//  SessionDelegate.swift
//
//  Copyright (c) 2014 Alamofire Software Foundation (http://alamofire.org/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

/// 负责处理底层`session`的所有代理回调
open class SessionDelegate: NSObject {

    // MARK: URLSessionDelegate Overrides

    /// Overrides default behavior for URLSessionDelegate method `urlSession(_:didBecomeInvalidWithError:)`.
    open var sessionDidBecomeInvalidWithError: ((URLSession, Error?) -> Void)?

    /// Overrides default behavior for URLSessionDelegate method `urlSession(_:didReceive:completionHandler:)`.
    open var sessionDidReceiveChallenge: ((URLSession, URLAuthenticationChallenge) -> (URLSession.AuthChallengeDisposition, URLCredential?))?

    /// Overrides all behavior for URLSessionDelegate method `urlSession(_:didReceive:completionHandler:)` and requires the caller to call the `completionHandler`.
    open var sessionDidReceiveChallengeWithCompletion: ((URLSession, URLAuthenticationChallenge, @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) -> Void)?

    /// Overrides default behavior for URLSessionDelegate method `urlSessionDidFinishEvents(forBackgroundURLSession:)`.
    open var sessionDidFinishEventsForBackgroundURLSession: ((URLSession) -> Void)?

    // MARK: URLSessionTaskDelegate Overrides

    /// Overrides default behavior for URLSessionTaskDelegate method `urlSession(_:task:willPerformHTTPRedirection:newRequest:completionHandler:)`.
    open var taskWillPerformHTTPRedirection: ((URLSession, URLSessionTask, HTTPURLResponse, URLRequest) -> URLRequest?)?

    /// Overrides all behavior for URLSessionTaskDelegate method `urlSession(_:task:willPerformHTTPRedirection:newRequest:completionHandler:)` and
    /// requires the caller to call the `completionHandler`.
    open var taskWillPerformHTTPRedirectionWithCompletion: ((URLSession, URLSessionTask, HTTPURLResponse, URLRequest, @escaping (URLRequest?) -> Void) -> Void)?

    /// Overrides default behavior for URLSessionTaskDelegate method `urlSession(_:task:didReceive:completionHandler:)`.
    open var taskDidReceiveChallenge: ((URLSession, URLSessionTask, URLAuthenticationChallenge) -> (URLSession.AuthChallengeDisposition, URLCredential?))?

    /// Overrides all behavior for URLSessionTaskDelegate method `urlSession(_:task:didReceive:completionHandler:)` and
    /// requires the caller to call the `completionHandler`.
    open var taskDidReceiveChallengeWithCompletion: ((URLSession, URLSessionTask, URLAuthenticationChallenge, @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) -> Void)?

    /// Overrides default behavior for URLSessionTaskDelegate method `urlSession(_:task:needNewBodyStream:)`.
    open var taskNeedNewBodyStream: ((URLSession, URLSessionTask) -> InputStream?)?

    /// Overrides all behavior for URLSessionTaskDelegate method `urlSession(_:task:needNewBodyStream:)` and
    /// requires the caller to call the `completionHandler`.
    open var taskNeedNewBodyStreamWithCompletion: ((URLSession, URLSessionTask, @escaping (InputStream?) -> Void) -> Void)?

    /// Overrides default behavior for URLSessionTaskDelegate method `urlSession(_:task:didSendBodyData:totalBytesSent:totalBytesExpectedToSend:)`.
    open var taskDidSendBodyData: ((URLSession, URLSessionTask, Int64, Int64, Int64) -> Void)?

    /// Overrides default behavior for URLSessionTaskDelegate method `urlSession(_:task:didCompleteWithError:)`.
    open var taskDidComplete: ((URLSession, URLSessionTask, Error?) -> Void)?

    // MARK: URLSessionDataDelegate Overrides

    /// Overrides default behavior for URLSessionDataDelegate method `urlSession(_:dataTask:didReceive:completionHandler:)`.
    open var dataTaskDidReceiveResponse: ((URLSession, URLSessionDataTask, URLResponse) -> URLSession.ResponseDisposition)?

    /// Overrides all behavior for URLSessionDataDelegate method `urlSession(_:dataTask:didReceive:completionHandler:)` and
    /// requires caller to call the `completionHandler`.
    open var dataTaskDidReceiveResponseWithCompletion: ((URLSession, URLSessionDataTask, URLResponse, @escaping (URLSession.ResponseDisposition) -> Void) -> Void)?

    /// Overrides default behavior for URLSessionDataDelegate method `urlSession(_:dataTask:didBecome:)`.
    open var dataTaskDidBecomeDownloadTask: ((URLSession, URLSessionDataTask, URLSessionDownloadTask) -> Void)?

    /// Overrides default behavior for URLSessionDataDelegate method `urlSession(_:dataTask:didReceive:)`.
    open var dataTaskDidReceiveData: ((URLSession, URLSessionDataTask, Data) -> Void)?

    /// Overrides default behavior for URLSessionDataDelegate method `urlSession(_:dataTask:willCacheResponse:completionHandler:)`.
    open var dataTaskWillCacheResponse: ((URLSession, URLSessionDataTask, CachedURLResponse) -> CachedURLResponse?)?

    /// Overrides all behavior for URLSessionDataDelegate method `urlSession(_:dataTask:willCacheResponse:completionHandler:)` and
    /// requires caller to call the `completionHandler`.
    open var dataTaskWillCacheResponseWithCompletion: ((URLSession, URLSessionDataTask, CachedURLResponse, @escaping (CachedURLResponse?) -> Void) -> Void)?

    // MARK: URLSessionDownloadDelegate Overrides

    /// Overrides default behavior for URLSessionDownloadDelegate method `urlSession(_:downloadTask:didFinishDownloadingTo:)`.
    open var downloadTaskDidFinishDownloadingToURL: ((URLSession, URLSessionDownloadTask, URL) -> Void)?

    /// Overrides default behavior for URLSessionDownloadDelegate method `urlSession(_:downloadTask:didWriteData:totalBytesWritten:totalBytesExpectedToWrite:)`.
    open var downloadTaskDidWriteData: ((URLSession, URLSessionDownloadTask, Int64, Int64, Int64) -> Void)?

    /// Overrides default behavior for URLSessionDownloadDelegate method `urlSession(_:downloadTask:didResumeAtOffset:expectedTotalBytes:)`.
    open var downloadTaskDidResumeAtOffset: ((URLSession, URLSessionDownloadTask, Int64, Int64) -> Void)?

    // MARK: URLSessionStreamDelegate Overrides

#if !os(watchOS)

    /// Overrides default behavior for URLSessionStreamDelegate method `urlSession(_:readClosedFor:)`.
    @available(iOS 9.0, macOS 10.11, tvOS 9.0, *)
    open var streamTaskReadClosed: ((URLSession, URLSessionStreamTask) -> Void)? {
        get {
            return _streamTaskReadClosed as? (URLSession, URLSessionStreamTask) -> Void
        }
        set {
            _streamTaskReadClosed = newValue
        }
    }

    /// Overrides default behavior for URLSessionStreamDelegate method `urlSession(_:writeClosedFor:)`.
    @available(iOS 9.0, macOS 10.11, tvOS 9.0, *)
    open var streamTaskWriteClosed: ((URLSession, URLSessionStreamTask) -> Void)? {
        get {
            return _streamTaskWriteClosed as? (URLSession, URLSessionStreamTask) -> Void
        }
        set {
            _streamTaskWriteClosed = newValue
        }
    }

    /// Overrides default behavior for URLSessionStreamDelegate method `urlSession(_:betterRouteDiscoveredFor:)`.
    @available(iOS 9.0, macOS 10.11, tvOS 9.0, *)
    open var streamTaskBetterRouteDiscovered: ((URLSession, URLSessionStreamTask) -> Void)? {
        get {
            return _streamTaskBetterRouteDiscovered as? (URLSession, URLSessionStreamTask) -> Void
        }
        set {
            _streamTaskBetterRouteDiscovered = newValue
        }
    }

    /// Overrides default behavior for URLSessionStreamDelegate method `urlSession(_:streamTask:didBecome:outputStream:)`.
    @available(iOS 9.0, macOS 10.11, tvOS 9.0, *)
    open var streamTaskDidBecomeInputAndOutputStreams: ((URLSession, URLSessionStreamTask, InputStream, OutputStream) -> Void)? {
        get {
            return _streamTaskDidBecomeInputStream as? (URLSession, URLSessionStreamTask, InputStream, OutputStream) -> Void
        }
        set {
            _streamTaskDidBecomeInputStream = newValue
        }
    }

    var _streamTaskReadClosed: Any?
    var _streamTaskWriteClosed: Any?
    var _streamTaskBetterRouteDiscovered: Any?
    var _streamTaskDidBecomeInputStream: Any?

#endif

    // MARK: Properties

    /// 负责判断请求失败是否重试
    var retrier: RequestRetrier?
    weak var sessionManager: SessionManager?

    /// 记录`sessionDelegate`所有正在处理的请求
    var requests: [Int: Request] = [:]
    /// `requests`的多线程互斥锁
    private let lock = NSLock()

    /// 使用线程安全的方式访问指定任务(`URLSessionTask`)的任务代理(`Requst->TaskDelegate`)
    open subscript(task: URLSessionTask) -> Request? {
        /**
         subscript关键字： 可以给任何类型增加下标，本质是调用具体的方法实现
         */
        get {
            lock.lock() ; defer { lock.unlock() }
            return requests[task.taskIdentifier]
        }
        set {
            lock.lock() ; defer { lock.unlock() }
            requests[task.taskIdentifier] = newValue
        }
    }

    // MARK: Lifecycle

    /// 初始化`SessionDelegate`实例
    public override init() {
        super.init()
    }

    // MARK: NSObject Overrides
    
    /// 返回`Bool`值, 表明`SessionDelegate`的实现方法或继承方法是否能响应指定的消息
    /// - Parameter selector: A selector that identifies a message.
    open override func responds(to selector: Selector) -> Bool {
        #if !os(macOS)
            if selector == #selector(URLSessionDelegate.urlSessionDidFinishEvents(forBackgroundURLSession:)) {
                return sessionDidFinishEventsForBackgroundURLSession != nil
            }
        #endif

        #if !os(watchOS)
            if #available(iOS 9.0, macOS 10.11, tvOS 9.0, *) {
                switch selector {
                case #selector(URLSessionStreamDelegate.urlSession(_:readClosedFor:)):
                    return streamTaskReadClosed != nil
                case #selector(URLSessionStreamDelegate.urlSession(_:writeClosedFor:)):
                    return streamTaskWriteClosed != nil
                case #selector(URLSessionStreamDelegate.urlSession(_:betterRouteDiscoveredFor:)):
                    return streamTaskBetterRouteDiscovered != nil
                case #selector(URLSessionStreamDelegate.urlSession(_:streamTask:didBecome:outputStream:)):
                    return streamTaskDidBecomeInputAndOutputStreams != nil
                default:
                    break
                }
            }
        #endif

        switch selector {
        case #selector(URLSessionDelegate.urlSession(_:didBecomeInvalidWithError:)):
            return sessionDidBecomeInvalidWithError != nil
        case #selector(URLSessionDelegate.urlSession(_:didReceive:completionHandler:)):
            return (sessionDidReceiveChallenge != nil  || sessionDidReceiveChallengeWithCompletion != nil)
        case #selector(URLSessionTaskDelegate.urlSession(_:task:willPerformHTTPRedirection:newRequest:completionHandler:)):
            return (taskWillPerformHTTPRedirection != nil || taskWillPerformHTTPRedirectionWithCompletion != nil)
        case #selector(URLSessionDataDelegate.urlSession(_:dataTask:didReceive:completionHandler:)):
            return (dataTaskDidReceiveResponse != nil || dataTaskDidReceiveResponseWithCompletion != nil)
        default:
            return type(of: self).instancesRespond(to: selector)
        }
    }
}

// MARK: - URLSessionDelegate

extension SessionDelegate: URLSessionDelegate {
    /// 告知代理，会话(`session`)已经失效
    /// - Parameter session: 已失效的会话
    /// - Parameter error: 导致会话失效的错误
    open func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        /**
         1. 如果调用`finishTasksAndInvalidate()`方法使会话(`session`)失效，会话将等待所有会话内
            所有任务都完成或失败后，再执行本代理方法
         2. 如果调用`invalidateAndCancel()`方法使会话失效，会话将立即调用本代理方法
         */
        sessionDidBecomeInvalidWithError?(session, error)
    }

    /// 向代理索要证书，以响应来自远程服务器的鉴权要求
    /// - Parameter session: 包含了“被要求鉴权的任务”的会话
    /// - Parameter challenge: 包含了鉴权请求的对象
    /// - Parameter completionHandler: 必须调用的闭包，传递`处理方式`和`证书`
    open func urlSession(
        _ session: URLSession,
        didReceive challenge: URLAuthenticationChallenge,
        completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void)
    {
        // 如果实现了回调的相应闭包代码(Alamofire为许多回调方法配置了相应的闭包)，则执行闭包代码
        guard sessionDidReceiveChallengeWithCompletion == nil else {
            sessionDidReceiveChallengeWithCompletion?(session, challenge, completionHandler)
            return
        }

        var disposition: URLSession.AuthChallengeDisposition = .performDefaultHandling
        var credential: URLCredential?

        if let sessionDidReceiveChallenge = sessionDidReceiveChallenge {
            (disposition, credential) = sessionDidReceiveChallenge(session, challenge)
        } else if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            let host = challenge.protectionSpace.host

            if
                let serverTrustPolicy = session.serverTrustPolicyManager?.serverTrustPolicy(forHost: host),
                let serverTrust = challenge.protectionSpace.serverTrust
            {
                if serverTrustPolicy.evaluate(serverTrust, forHost: host) {
                    disposition = .useCredential
                    credential = URLCredential(trust: serverTrust)
                } else {
                    disposition = .cancelAuthenticationChallenge
                }
            }
        }

        completionHandler(disposition, credential)
    }

#if !os(macOS)

    /// Tells the delegate that all messages enqueued for a session have been delivered.
    ///
    /// - parameter session: The session that no longer has any outstanding requests.
    open func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        sessionDidFinishEventsForBackgroundURLSession?(session)
    }

#endif
}

// MARK: - URLSessionTaskDelegate

extension SessionDelegate: URLSessionTaskDelegate {
    /// 告知代理，远程服务器请求进行HTTP重定向
    ///
    /// 只有默认(`default`)和短暂(`ephemeral`)配置的会话才会调用此方法。
    /// 后台(`background`)配置的会话会自动遵循重定向(`follow redirects`)
    /// - Parameter session: 包含任务的会话
    /// - Parameter task: 请求结果导致重定向的任务
    /// - Parameter response: 包含原始请求的服务器响应的对象
    /// - Parameter request: 填写了(重定向)新位置的URL请求对象
    /// - Parameter completionHandler: 要执行的闭包，传递请求参数值修改后的URL请求对象，或传递`NULL`拒绝重定向并直接返回响应的`body`
    open func urlSession(
        _ session: URLSession,
        task: URLSessionTask,
        willPerformHTTPRedirection response: HTTPURLResponse,
        newRequest request: URLRequest,
        completionHandler: @escaping (URLRequest?) -> Void)
    {
        guard taskWillPerformHTTPRedirectionWithCompletion == nil else {
            taskWillPerformHTTPRedirectionWithCompletion?(session, task, response, request, completionHandler)
            return
        }

        var redirectRequest: URLRequest? = request

        if let taskWillPerformHTTPRedirection = taskWillPerformHTTPRedirection {
            redirectRequest = taskWillPerformHTTPRedirection(session, task, response, request)
        }

        completionHandler(redirectRequest)
    }

    /// 向代理索要证书，以响应来自远程服务器的鉴权要求
    /// - Parameter session: 包含任务的会话
    /// - Parameter task: 要求鉴权的请求所属的任务
    /// - Parameter challenge: 包含了鉴权要求的对象
    /// - Parameter completionHandler: 要执行的闭包，其参数为`disposition`或`credential`
    open func urlSession(
        _ session: URLSession,
        task: URLSessionTask,
        didReceive challenge: URLAuthenticationChallenge,
        completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void)
    {
        guard taskDidReceiveChallengeWithCompletion == nil else {
            taskDidReceiveChallengeWithCompletion?(session, task, challenge, completionHandler)
            return
        }

        if let taskDidReceiveChallenge = taskDidReceiveChallenge {
            let result = taskDidReceiveChallenge(session, task, challenge)
            completionHandler(result.0, result.1)
        } else if let delegate = self[task]?.delegate {
            delegate.urlSession(
                session,
                task: task,
                didReceive: challenge,
                completionHandler: completionHandler
            )
        } else {
            urlSession(session, didReceive: challenge, completionHandler: completionHandler)
        }
    }

    /// 当任务请求新的请求主体流(request body stream)向远程服务器发送数据时，告知代理
    ///
    /// `task`只在两种情况下调用该代理方法：
    /// 1. 为`uploadTask(withStreamedRequest:)`创建的任务提供初始的请求主体流
    /// 2. 任务已拥有主体流，因身份验证或其它可恢复的服务器错误导致需要重新发送请求时，为任务提供替代的请求主体流
    /// 注意： 如果使用文件`url`或`data`对象来提供请求主体(`request body`), 则没必要实现该方法
    /// - Parameter session: 包含任务的会话
    /// - Parameter task: 需要新的主体流(body stream)
    /// - Parameter completionHandler: 执行该闭包，传递新的主体流
    open func urlSession(
        _ session: URLSession,
        task: URLSessionTask,
        needNewBodyStream completionHandler: @escaping (InputStream?) -> Void)
    {
        guard taskNeedNewBodyStreamWithCompletion == nil else {
            taskNeedNewBodyStreamWithCompletion?(session, task, completionHandler)
            return
        }

        if let taskNeedNewBodyStream = taskNeedNewBodyStream {
            completionHandler(taskNeedNewBodyStream(session, task))
        } else if let delegate = self[task]?.delegate {
            delegate.urlSession(session, task: task, needNewBodyStream: completionHandler)
        }
    }
    
    /// 定期告知代理，向服务器发送的主体内容(`body content`)的进度
    /// - Parameter session: 包含数据任务的会话
    /// - Parameter task: 数据任务
    /// - Parameter bytesSent: 从本代理方法最近一次调用起，发送的字节总数
    /// - Parameter totalBytesSent: 到目前为止发送的总字符数
    /// - Parameter totalBytesExpectedToSend: 预期的主体数据的长度
    open func urlSession(
        _ session: URLSession,
        task: URLSessionTask,
        didSendBodyData bytesSent: Int64,
        totalBytesSent: Int64,
        totalBytesExpectedToSend: Int64)
    {
        if let taskDidSendBodyData = taskDidSendBodyData {
            taskDidSendBodyData(session, task, bytesSent, totalBytesSent, totalBytesExpectedToSend)
        } else if let delegate = self[task]?.delegate as? UploadTaskDelegate {
            delegate.URLSession(
                session,
                task: task,
                didSendBodyData: bytesSent,
                totalBytesSent: totalBytesSent,
                totalBytesExpectedToSend: totalBytesExpectedToSend
            )
        }
    }

#if !os(watchOS)

    /// Tells the delegate that the session finished collecting metrics for the task.
    ///
    /// - parameter session: The session collecting the metrics.
    /// - parameter task:    The task whose metrics have been collected.
    /// - parameter metrics: The collected metrics.
    @available(iOS 10.0, macOS 10.12, tvOS 10.0, *)
    @objc(URLSession:task:didFinishCollectingMetrics:)
    open func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        self[task]?.delegate.metrics = metrics
    }

#endif

    /// Tells the delegate that the task finished transferring data.
    ///
    /// - parameter session: The session containing the task whose request finished transferring data.
    /// - parameter task:    The task whose request finished transferring data.
    /// - parameter error:   If an error occurred, an error object indicating how the transfer failed, otherwise nil.
    open func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        /// Executed after it is determined that the request is not going to be retried
        let completeTask: (URLSession, URLSessionTask, Error?) -> Void = { [weak self] session, task, error in
            guard let strongSelf = self else { return }

            strongSelf.taskDidComplete?(session, task, error)

            strongSelf[task]?.delegate.urlSession(session, task: task, didCompleteWithError: error)

            var userInfo: [String: Any] = [Notification.Key.Task: task]

            if let data = (strongSelf[task]?.delegate as? DataTaskDelegate)?.data {
                userInfo[Notification.Key.ResponseData] = data
            }

            NotificationCenter.default.post(
                name: Notification.Name.Task.DidComplete,
                object: strongSelf,
                userInfo: userInfo
            )

            strongSelf[task] = nil
        }

        guard let request = self[task], let sessionManager = sessionManager else {
            completeTask(session, task, error)
            return
        }

        // Run all validations on the request before checking if an error occurred
        request.validations.forEach { $0() }

        // Determine whether an error has occurred
        var error: Error? = error

        if request.delegate.error != nil {
            error = request.delegate.error
        }

        /// If an error occurred and the retrier is set, asynchronously ask the retrier if the request
        /// should be retried. Otherwise, complete the task by notifying the task delegate.
        if let retrier = retrier, let error = error {
            retrier.should(sessionManager, retry: request, with: error) { [weak self] shouldRetry, timeDelay in
                guard shouldRetry else { completeTask(session, task, error) ; return }

                DispatchQueue.utility.after(timeDelay) { [weak self] in
                    guard let strongSelf = self else { return }

                    let retrySucceeded = strongSelf.sessionManager?.retry(request) ?? false

                    if retrySucceeded, let task = request.task {
                        strongSelf[task] = request
                        return
                    } else {
                        completeTask(session, task, error)
                    }
                }
            }
        } else {
            completeTask(session, task, error)
        }
    }
}

// MARK: - URLSessionDataDelegate

extension SessionDelegate: URLSessionDataDelegate {
    /// Tells the delegate that the data task received the initial reply (headers) from the server.
    ///
    /// - parameter session:           The session containing the data task that received an initial reply.
    /// - parameter dataTask:          The data task that received an initial reply.
    /// - parameter response:          A URL response object populated with headers.
    /// - parameter completionHandler: A completion handler that your code calls to continue the transfer, passing a
    ///                                constant to indicate whether the transfer should continue as a data task or
    ///                                should become a download task.
    open func urlSession(
        _ session: URLSession,
        dataTask: URLSessionDataTask,
        didReceive response: URLResponse,
        completionHandler: @escaping (URLSession.ResponseDisposition) -> Void)
    {
        guard dataTaskDidReceiveResponseWithCompletion == nil else {
            dataTaskDidReceiveResponseWithCompletion?(session, dataTask, response, completionHandler)
            return
        }

        var disposition: URLSession.ResponseDisposition = .allow

        if let dataTaskDidReceiveResponse = dataTaskDidReceiveResponse {
            disposition = dataTaskDidReceiveResponse(session, dataTask, response)
        }

        completionHandler(disposition)
    }

    /// Tells the delegate that the data task was changed to a download task.
    ///
    /// - parameter session:      The session containing the task that was replaced by a download task.
    /// - parameter dataTask:     The data task that was replaced by a download task.
    /// - parameter downloadTask: The new download task that replaced the data task.
    open func urlSession(
        _ session: URLSession,
        dataTask: URLSessionDataTask,
        didBecome downloadTask: URLSessionDownloadTask)
    {
        if let dataTaskDidBecomeDownloadTask = dataTaskDidBecomeDownloadTask {
            dataTaskDidBecomeDownloadTask(session, dataTask, downloadTask)
        } else {
            self[downloadTask]?.delegate = DownloadTaskDelegate(task: downloadTask)
        }
    }

    /// Tells the delegate that the data task has received some of the expected data.
    ///
    /// - parameter session:  The session containing the data task that provided data.
    /// - parameter dataTask: The data task that provided data.
    /// - parameter data:     A data object containing the transferred data.
    open func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        if let dataTaskDidReceiveData = dataTaskDidReceiveData {
            dataTaskDidReceiveData(session, dataTask, data)
        } else if let delegate = self[dataTask]?.delegate as? DataTaskDelegate {
            delegate.urlSession(session, dataTask: dataTask, didReceive: data)
        }
    }

    /// Asks the delegate whether the data (or upload) task should store the response in the cache.
    ///
    /// - parameter session:           The session containing the data (or upload) task.
    /// - parameter dataTask:          The data (or upload) task.
    /// - parameter proposedResponse:  The default caching behavior. This behavior is determined based on the current
    ///                                caching policy and the values of certain received headers, such as the Pragma
    ///                                and Cache-Control headers.
    /// - parameter completionHandler: A block that your handler must call, providing either the original proposed
    ///                                response, a modified version of that response, or NULL to prevent caching the
    ///                                response. If your delegate implements this method, it must call this completion
    ///                                handler; otherwise, your app leaks memory.
    open func urlSession(
        _ session: URLSession,
        dataTask: URLSessionDataTask,
        willCacheResponse proposedResponse: CachedURLResponse,
        completionHandler: @escaping (CachedURLResponse?) -> Void)
    {
        guard dataTaskWillCacheResponseWithCompletion == nil else {
            dataTaskWillCacheResponseWithCompletion?(session, dataTask, proposedResponse, completionHandler)
            return
        }

        if let dataTaskWillCacheResponse = dataTaskWillCacheResponse {
            completionHandler(dataTaskWillCacheResponse(session, dataTask, proposedResponse))
        } else if let delegate = self[dataTask]?.delegate as? DataTaskDelegate {
            delegate.urlSession(
                session,
                dataTask: dataTask,
                willCacheResponse: proposedResponse,
                completionHandler: completionHandler
            )
        } else {
            completionHandler(proposedResponse)
        }
    }
}

// MARK: - URLSessionDownloadDelegate

extension SessionDelegate: URLSessionDownloadDelegate {
    /// Tells the delegate that a download task has finished downloading.
    ///
    /// - parameter session:      The session containing the download task that finished.
    /// - parameter downloadTask: The download task that finished.
    /// - parameter location:     A file URL for the temporary file. Because the file is temporary, you must either
    ///                           open the file for reading or move it to a permanent location in your app’s sandbox
    ///                           container directory before returning from this delegate method.
    open func urlSession(
        _ session: URLSession,
        downloadTask: URLSessionDownloadTask,
        didFinishDownloadingTo location: URL)
    {
        if let downloadTaskDidFinishDownloadingToURL = downloadTaskDidFinishDownloadingToURL {
            downloadTaskDidFinishDownloadingToURL(session, downloadTask, location)
        } else if let delegate = self[downloadTask]?.delegate as? DownloadTaskDelegate {
            delegate.urlSession(session, downloadTask: downloadTask, didFinishDownloadingTo: location)
        }
    }

    /// Periodically informs the delegate about the download’s progress.
    ///
    /// - parameter session:                   The session containing the download task.
    /// - parameter downloadTask:              The download task.
    /// - parameter bytesWritten:              The number of bytes transferred since the last time this delegate
    ///                                        method was called.
    /// - parameter totalBytesWritten:         The total number of bytes transferred so far.
    /// - parameter totalBytesExpectedToWrite: The expected length of the file, as provided by the Content-Length
    ///                                        header. If this header was not provided, the value is
    ///                                        `NSURLSessionTransferSizeUnknown`.
    open func urlSession(
        _ session: URLSession,
        downloadTask: URLSessionDownloadTask,
        didWriteData bytesWritten: Int64,
        totalBytesWritten: Int64,
        totalBytesExpectedToWrite: Int64)
    {
        if let downloadTaskDidWriteData = downloadTaskDidWriteData {
            downloadTaskDidWriteData(session, downloadTask, bytesWritten, totalBytesWritten, totalBytesExpectedToWrite)
        } else if let delegate = self[downloadTask]?.delegate as? DownloadTaskDelegate {
            delegate.urlSession(
                session,
                downloadTask: downloadTask,
                didWriteData: bytesWritten,
                totalBytesWritten: totalBytesWritten,
                totalBytesExpectedToWrite: totalBytesExpectedToWrite
            )
        }
    }

    /// Tells the delegate that the download task has resumed downloading.
    ///
    /// - parameter session:            The session containing the download task that finished.
    /// - parameter downloadTask:       The download task that resumed. See explanation in the discussion.
    /// - parameter fileOffset:         If the file's cache policy or last modified date prevents reuse of the
    ///                                 existing content, then this value is zero. Otherwise, this value is an
    ///                                 integer representing the number of bytes on disk that do not need to be
    ///                                 retrieved again.
    /// - parameter expectedTotalBytes: The expected length of the file, as provided by the Content-Length header.
    ///                                 If this header was not provided, the value is NSURLSessionTransferSizeUnknown.
    open func urlSession(
        _ session: URLSession,
        downloadTask: URLSessionDownloadTask,
        didResumeAtOffset fileOffset: Int64,
        expectedTotalBytes: Int64)
    {
        if let downloadTaskDidResumeAtOffset = downloadTaskDidResumeAtOffset {
            downloadTaskDidResumeAtOffset(session, downloadTask, fileOffset, expectedTotalBytes)
        } else if let delegate = self[downloadTask]?.delegate as? DownloadTaskDelegate {
            delegate.urlSession(
                session,
                downloadTask: downloadTask,
                didResumeAtOffset: fileOffset,
                expectedTotalBytes: expectedTotalBytes
            )
        }
    }
}

// MARK: - URLSessionStreamDelegate

#if !os(watchOS)

@available(iOS 9.0, macOS 10.11, tvOS 9.0, *)
extension SessionDelegate: URLSessionStreamDelegate {
    /// Tells the delegate that the read side of the connection has been closed.
    ///
    /// - parameter session:    The session.
    /// - parameter streamTask: The stream task.
    open func urlSession(_ session: URLSession, readClosedFor streamTask: URLSessionStreamTask) {
        streamTaskReadClosed?(session, streamTask)
    }

    /// Tells the delegate that the write side of the connection has been closed.
    ///
    /// - parameter session:    The session.
    /// - parameter streamTask: The stream task.
    open func urlSession(_ session: URLSession, writeClosedFor streamTask: URLSessionStreamTask) {
        streamTaskWriteClosed?(session, streamTask)
    }

    /// Tells the delegate that the system has determined that a better route to the host is available.
    ///
    /// - parameter session:    The session.
    /// - parameter streamTask: The stream task.
    open func urlSession(_ session: URLSession, betterRouteDiscoveredFor streamTask: URLSessionStreamTask) {
        streamTaskBetterRouteDiscovered?(session, streamTask)
    }

    /// Tells the delegate that the stream task has been completed and provides the unopened stream objects.
    ///
    /// - parameter session:      The session.
    /// - parameter streamTask:   The stream task.
    /// - parameter inputStream:  The new input stream.
    /// - parameter outputStream: The new output stream.
    open func urlSession(
        _ session: URLSession,
        streamTask: URLSessionStreamTask,
        didBecome inputStream: InputStream,
        outputStream: OutputStream)
    {
        streamTaskDidBecomeInputAndOutputStreams?(session, streamTask, inputStream, outputStream)
    }
}

#endif
