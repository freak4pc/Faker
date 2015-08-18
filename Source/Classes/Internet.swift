// Internet.swift
//
// Copyright (c) 2014–2015 Apostle (http://apostle.nl)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

public class Internet {
    // MARK: Provider
    
    public class Provider {
        public init() {
            // noop
        }
        
        func urlFormats() -> [String] {
            return [
                "http://\(Internet.domainName())",
                "http://www.\(Internet.domainName())",
                "http://www.\(Internet.domainName())/\(Internet.slug())",
                "http://www.\(Internet.domainName())/\(Internet.slug())",
                "https://www.\(Internet.domainName())/\(Internet.slug())",
                "http://www.\(Internet.domainName())/\(Internet.slug()).html",
                "http://\(Internet.domainName())/\(Internet.slug())",
                "http://\(Internet.domainName())/\(Internet.slug())",
                "http://\(Internet.domainName())/\(Internet.slug()).html",
                "https://\(Internet.domainName())/\(Internet.slug()).html",
            ]
        }
        
        func emailFormats() -> [String] {
            return [
                "\(Internet.username())@\(Internet.domainName())",
                "\(Internet.username())@\(Internet.freeEmailDomain())",
                "\(Internet.username())@\(Internet.safeEmailDomain())",
            ]
        }
        
        func usernameFormats() -> [String] {
            return [
                "\(Person.lastName()).\(Person.firstName())",
                "\(Person.firstName()).\(Person.lastName())",
                "\(Person.firstName())##",
                "?\(Person.lastName())",
            ]
        }
        
        func tlds() -> [String] {
            return [ "com", "com", "com", "com", "com", "com", "biz", "info", "net", "org" ]
        }
        
        func freeEmailDomains() -> [String] {
            return [
                "gmail.com",
                "yahoo.com",
                "hotmail.com",
            ]
        }
    }
    
    // MARK: Variables
    
    public static var provider : Provider?
    
    // MARK: Generators
    
    /**
        Generate a random e-mail address.
    
        - note: There is a chance that this e-mail address is actually in use,
                if you want to send e-mail, use the `safeEmail` method instead.

        - returns: Returns a random e-mail address.
    */
    public class func email() -> String {
        return dataProvider().emailFormats().random()!
    }
    
    /**
        Generate a random safe e-mail address.

        - returns: Returns a random safe e-mail address.
    */
    public class func safeEmail() -> String {
        return "\(username())@\(safeEmailDomain())"
    }
    
    /**
        Generate a random free e-mail address.
    
        - note: There is a chance that this e-mail address is actually in use,
                if you want to send e-mail, use the `safeEmail` method instead.
    
        - returns: Returns a random free e-mail address.
    */
    public class func freeEmail() -> String {
        return "\(username())@\(freeEmailDomain())"
    }
    
    /**
        Generate a random company e-mail address.
    
        - note: There is a chance that this e-mail address is actually in use,
                if you want to send e-mail, use the `safeEmail` method instead.

        - returns: Returns a random company e-mail address.
    */
    public class func companyEmail() -> String {
        return "\(username())@\(domainName())"
    }
    
    /**
        Generate a random free e-mail domain.

        - returns: Returns a random free e-mail domain.
    */
    public class func freeEmailDomain() -> String {
        return dataProvider().freeEmailDomains().random()!
    }
    
    /**
        Generate a random safe e-mail domain.

        - returns: Returns a random safe e-mail domain.
    */
    public class func safeEmailDomain() -> String {
        return [ "example.com", "example.org", "example.net" ].random()!
    }
    
    /**
        Generate a random username.

        - returns: Returns a random username.
    */
    public class func username() -> String {
        return dataProvider().usernameFormats().random()!.numerify().lexify()
    }
    
    /**
        Generate a random password of at least `minLength` and at most
        `maxLength` characters.

        - parameter minLength: The minimum length of the password.
        - parameter maxLength: The maximum length of the password.

        - returns: Returns a password of at least `minLength` and at most
                   `maxLength` characters.
    */
    public class func password(minLength : Int = 6, maxLength : Int = 20) -> String {
        let format = "".join(Array(count: Int.random(minLength, max: maxLength), repeatedValue: "*"))
        
        return format.lexify()
    }
    
    /**
        Generate a random domain name.

        - returns: Returns a random domain name.
    */
    public class func domainName() -> String {
        return "\(domainWord()).\(tld())"
    }
    
    /**
        Generate a random domain word.

        - returns: Returns a random domain word.
    */
    public class func domainWord() -> String {
        return "\(Person.lastName())".lowercaseString
    }
    
    /**
        Generate a random top-level domain (TLD).

        - returns: Returns a random TLD.
    */
    public class func tld() -> String {
        return dataProvider().tlds().random()!
    }
    
    /**
        Generate a random URL.

        - returns: Returns a random URL.
    */
    public class func url() -> String {
        return dataProvider().urlFormats().random()!
    }
    
    /**
        Generate a random slug.

        - parameter nbWords:  The number of words the slug should contain.
        - parameter variable: If `true`, the number of sentences will vary
                              between +/- 40% of `nbSentences`.

        - returns: Returns a random slug of `nbWords` words.
    */
    public class func slug(nbWords : Int = 6, variable : Bool = true) -> String {
        if nbWords <= 0 {
            return ""
        }
        
        return "-".join(Lorem.words(variable ? nbWords.randomize(40) : nbWords)).lowercaseString
    }
    
    /**
        Generate a random IPv4 address.

        - returns: Returns a random IPv4 address.
    */
    public class func ipv4() -> String {
        return ".".join([
            Int.random(0, max: 255),
            Int.random(0, max: 255),
            Int.random(0, max: 255),
            Int.random(0, max: 255)
        ].map(String.init))
    }
    
    /**
        Generate a random IPv6 address.

        - returns: Returns a random IPv6 address.
    */
    public class func ipv6() -> String {
        let components = (0..<8).map { _ in Int.random(0, max: 65535) }
        
        return ":".join(components.map({ String(format: "%04x", arguments: [ $0 ]) }))
    }
    
    /**
        Generate a random local IPv4 address.

        - returns: Returns a random local IPv4 address.
    */
    public class func localIpv4() -> String {
        var prefix : String = ""
        var components : [String] = [String]()
        
        if Int.random(0, max: 1) == 0 {
            prefix     = "10."
            components = (0..<3).map({ _ in Int.random(0, max: 255) }).map(String.init)
        } else {
            prefix     = "192.168."
            components = (0..<2).map({ _ in Int.random(0, max: 255) }).map(String.init)
        }
        
        return prefix + ".".join(components)
    }
    
    /**
        Generate a random MAC address.

        - returns: Returns a random MAC address.
    */
    public class func mac() -> String {
        let components = (0..<6).map { _ in Int.random(0, max: 255) }
        
        return ":".join(components.map({ String(format: "%02X", arguments: [ $0 ]) }))
    }
    
    private class func dataProvider() -> Provider {
        return provider ?? Provider()
    }
}
