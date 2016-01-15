//
//  NewsManager.swift
//  NewsAppSwift
//
//  Created by Hemrom, Sheetal on 11/16/15.
//  Copyright (c) 2015 Hemrom, Sheetal. All rights reserved.
//

import UIKit

class NewsManager: NSObject {
    
    var xmlParser:XMLParser! = nil;
    
    func getGoogleRSSFeeds(){
        
        // http://rss.cnn.com/rss/cnn_topstories.rss
        //https://news.google.de/news/feeds?pz=1&cf=all&ned=LANGUAGE&hl=COUNTRY&q=SEARCH_TERM&output=rss
        let url = NSURL(string: "http://rss.cnn.com/rss/cnn_topstories.rss");
        let requestManager:RequestManager = RequestManager();
        let block:RequestManagerBlock =  { (url, response) -> () in
            self.xmlParser = XMLParser().initWithData(response);
            let responseString:NSString =  NSString(data: response, encoding: NSUTF8StringEncoding)!;
            NSLog("Got response %@",responseString);
        };
        requestManager.serverCallToURL(url,block: block);
    }
    
}
