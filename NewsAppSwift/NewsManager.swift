//
//  NewsManager.swift
//  NewsAppSwift
//
//  Created by Hemrom, Sheetal on 11/16/15.
//  Copyright (c) 2015 Hemrom, Sheetal. All rights reserved.
//

import UIKit

class NewsManager: NSObject,NSXMLParserDelegate {
    
    var xmlParser:NSXMLParser! = nil;
    var itemsArray:NSMutableArray! = nil;
    var currentElement:NSString! = "";
    var foundString:NSMutableString! = NSMutableString();
    var currentItem:Item!=nil;
    
    func getGoogleRSSFeeds(){
        
        // http://rss.cnn.com/rss/cnn_topstories.rss
        //https://news.google.de/news/feeds?pz=1&cf=all&ned=LANGUAGE&hl=COUNTRY&q=SEARCH_TERM&output=rss
        let url = NSURL(string: "http://rss.cnn.com/rss/cnn_topstories.rss");
        let requestManager:RequestManager = RequestManager();
        let block:RequestManagerBlock =  { (url, response) -> () in
            
            self.xmlParser = NSXMLParser(data:response);
            self.xmlParser.delegate = self;
            self.xmlParser.parse();
            let responseString:NSString =  NSString(data: response, encoding: NSUTF8StringEncoding)!;
            NSLog("Got response %@",responseString);
        };
        requestManager.serverCallToURL(url,block: block);
    }
    
    
    
    
    // MARK: XMLParser Delegates
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        let elementNam:NSString = elementName;
        if(elementNam.isEqualToString("item")){
            if(itemsArray == nil){
                itemsArray = NSMutableArray();
            }
            self.currentElement = elementNam;
            currentItem = Item();
            itemsArray.addObject(currentItem);
        }
        if(elementNam.isEqualToString("media:thumbnail"))
        {
            let dict:NSDictionary = attributeDict;
            let imageUrl:NSString! = dict.objectForKey("url") as! NSString;
            currentItem.thumbNailURL = imageUrl;
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(self.currentElement.isEqualToString("item"))
        {
            let elementNam:NSString = elementName;
            if(elementNam.isEqualToString("item"))
            {
               self.currentElement = "";
            }
            else if(elementNam.isEqualToString("description"))
            {
                currentItem.descriptionText = NSString(string: foundString);
            }
            else if(!elementNam.isEqualToString("media:content") && !elementNam.isEqualToString("media:thumbnail")){
                currentItem.setValue(NSString(string: foundString), forKey: elementNam as NSString as String)
            }
        }
        self.foundString="";
        
    }
    func parser(parser: NSXMLParser, foundAttributeDeclarationWithName attributeName: String, forElement elementName: String, type: String?, defaultValue: String?) {
        NSLog(elementName,attributeName);
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        self.foundString.appendString(string);
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        let window:UIWindow! = UIApplication.sharedApplication().keyWindow;
        let splitViewController = window.rootViewController as! UISplitViewController
        let masterNavigationController = splitViewController.viewControllers[0] as! UINavigationController
        let controller = masterNavigationController.topViewController as! MasterViewController
         controller.insertObjects(itemsArray);
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        
    }
    
    
    
    
//    class func getPropertiesInfo() -> (propertiesName:[String], propertiesType:[String]) {
//        var propertiesName:[String] = Array();
//        var propertiesType:[String] = Array();
//        
//        var outCount:UInt32 = 0;
//        var i:Int        = Int();
//        
//        var properties:UnsafePointer<objc_property_t> = class_copyPropertyList(object_getClass(self), &outCount);
//        println("\(outCount)");
//        
//        
//        //        unsigned int outCount, i;
//        //        objc_property_t *properties = class_copyPropertyList([self class], &outCount);
//        //        for(i = 0; i < outCount; i++) {
//        //            objc_property_t property = properties[i];
//        //            const char *propName = property_getName(property);
//        //            if(propName) {
//        //                const char *propType = getPropertyType(property);
//        //                NSString *propertyName = [NSString stringWithCString:propName
//        //                    encoding:[NSString defaultCStringEncoding]];
//        //                NSString *propertyType = [NSString stringWithCString:propType
//        //                    encoding:[NSString defaultCStringEncoding]];
//        //                ...
//        //            }
//        //        }
//        //        free(properties);
//    }
    
}
