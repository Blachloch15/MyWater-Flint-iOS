//
//  NewsViewController.swift
//  MyWater-Flint
//
//  Created by John Collins on 2/10/17.
//  Copyright © 2017 University of Michigan Software. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, XMLParserDelegate {

    @IBOutlet weak var newsTableView: UITableView!

    var xmlParser = XMLParser()
    var element = String()
    var title1 = NSMutableString()
    var date = NSMutableString()
    var link = NSMutableString()
    var articles: [NewsItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.newsTableView.estimatedRowHeight = 40.0
        
        let urlString = "https://news.google.com/news?cf=all&hl=en&pz=1&ned=us&q=Flint+Water+Crisis&cf=all&ncl=&output=rss"
        guard let url = URL(string: urlString) else {
            print("Error cannot create URL")
            return
        }
        
        xmlParser = XMLParser(contentsOf: url)!
        xmlParser.delegate = self
        
        let success: Bool = xmlParser.parse()
        
        if success {
            print("parse success!")
            print(articles)
            for item in articles {
                print (item.newsTitle)
                print (item.newsDate)
                print (item.newsThumbUrl)
            }
            
        } else {
            print("parse failure")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        element = elementName
        print(element)
        
        if (elementName as NSString).isEqual(to: "item")
        {
            title1 = NSMutableString()
            title1 = ""
            date = NSMutableString()
            date = ""
            link = NSMutableString()
            link = ""
        }

    }

    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        
        if (elementName as NSString).isEqual(to: "item") {
            let newsItem: NewsItem = NewsItem()
            newsItem.newsDate = date as String
            newsItem.newsTitle = title1 as String
            newsItem.newsThumbUrl = link as String
            
            articles.append(newsItem)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        print(string)
        
//        element.append(string)

        
        
        if element.isEqual("title") {
            title1.append(string)
        }
        if element.isEqual("link"){
            link.append(string)
        }
        
        if element.isEqual("pubDate") {
            date.append(string)
        }

    }

}

extension NewsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsItemCell", for: indexPath) as! NewsItemTableViewCell
        
        var labelString = ""
        labelString = articles[indexPath.item].newsTitle
        
        let labelStringArr = labelString.characters.split(separator: "-").map(String.init)
        cell.titleLabel.text = labelStringArr[0]
        cell.authorLabel.text = labelStringArr[1]
        
        var dateString = articles[indexPath.item].newsDate
        dateString = dateString.characters.split(separator: "G").map(String.init)[0]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss "
        dateFormatter.locale = Locale.init(identifier: "en_US")
        let dateObj = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        cell.dateLabel.text = dateFormatter.string(from: dateObj!)
        
        
        return cell
    }
    
}

extension NewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let url = URL(string: articles[(indexPath as NSIndexPath).item].newsThumbUrl)
        if url != nil {
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
    }

    
}
