//
//  XMLParser.swift
//  NewsAppSwift
//
//  Created by user on 1/14/16.
//  Copyright © 2016 Hemrom, Sheetal. All rights reserved.
//

import Foundation
import UIKit

class XMLParser: NSObject,NSXMLParserDelegate {
        var xmlParser:NSXMLParser! = nil;
        var currentItem:Item!=nil;
        var itemsArray:NSMutableArray! = nil;
        var currentElement:NSString! = "";
        var foundString:NSMutableString! = NSMutableString();
    
    
    func initWithData(data : NSData) -> XMLParser
    {
        self.xmlParser = NSXMLParser(data:data);
        self.xmlParser.delegate = self;
        self.xmlParser.parse();
        return self;
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
