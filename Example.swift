//  DeveloperConsoleVC.swift
//  Inspec
//
//  Created by Justin Cook on 12/11/21.
//

import Foundation
import UIKit
import SwiftUI

/** Console that displays all important data such as remote database tables, coredata tables, administrators*/
public class DeveloperConsoleVC: UIViewController, UISearchBarDelegate, UISearchResultsUpdating{
    private var navItem = UINavigationItem(title: "Developer Console 🛠")
    private var closeButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(closeButton))
    /** Create navigation bar to host navigation items*/
    private var navBar = UINavigationBar()
    private var searchController: UISearchController? = nil
    private var databaseButton = UIButton()
    private var coreDataButton = UIButton()
    private var metricsButton = UIButton()
    private var adminsButton = UIButton()
    private var buttonBar: underlinedButtonBar? = nil
    
    public override func viewWillAppear(_ animated: Bool) {}
    
    public override func viewWillDisappear(_ animated: Bool) {}
    
    public override func viewDidAppear(_ animated: Bool) {}
    
    public override func viewDidDisappear(_ animated: Bool) {}
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setButtons()
        constructUI()
        setSearchController()
        setCustomNavUI()
    }
    
    /** Customize the specified buttons that control navigation*/
    func setButtons(){
        databaseButton.frame.size.height = 40
        databaseButton.frame.size.width = 100
        databaseButton.contentHorizontalAlignment = .center
        databaseButton.setTitle("Database", for: .normal)
        databaseButton.setTitleColor(darkModeFontColor, for: .normal)
        databaseButton.layer.backgroundColor = UIColor.clear.cgColor
        databaseButton.isExclusiveTouch = true
        databaseButton.clipsToBounds = true
        databaseButton.titleLabel?.font = getCustomFont(name: .Ubuntu_Regular, size: 16)
        databaseButton.titleLabel?.adjustsFontSizeToFitWidth = true
        databaseButton.addTarget(self, action: #selector(databaseButtonPressed), for: .touchDown)
        
        coreDataButton.frame.size.height = 40
        coreDataButton.frame.size.width = 100
        coreDataButton.contentHorizontalAlignment = .center
        coreDataButton.setTitle("Core Data", for: .normal)
        coreDataButton.setTitleColor(darkModeFontColor, for: .normal)
        coreDataButton.layer.backgroundColor = UIColor.clear.cgColor
        coreDataButton.isExclusiveTouch = true
        coreDataButton.clipsToBounds = true
        coreDataButton.titleLabel?.font = getCustomFont(name: .Ubuntu_Regular, size: 16)
        coreDataButton.titleLabel?.adjustsFontSizeToFitWidth = true
        coreDataButton.addTarget(self, action: #selector(coreDataButtonPressed), for: .touchDown)
        
        metricsButton.frame.size.height = 40
        metricsButton.frame.size.width = 100
        metricsButton.contentHorizontalAlignment = .center
        metricsButton.setTitle("Metrics", for: .normal)
        metricsButton.setTitleColor(darkModeFontColor, for: .normal)
        metricsButton.layer.backgroundColor = UIColor.clear.cgColor
        metricsButton.isExclusiveTouch = true
        metricsButton.clipsToBounds = true
        metricsButton.titleLabel?.font = getCustomFont(name: .Ubuntu_Regular, size: 16)
        metricsButton.titleLabel?.adjustsFontSizeToFitWidth = true
        metricsButton.addTarget(self, action: #selector(metricsButtonPressed), for: .touchDown)
        
        adminsButton.frame.size.height = 40
        adminsButton.frame.size.width = 100
        adminsButton.contentHorizontalAlignment = .center
        adminsButton.setTitle("Admins", for: .normal)
        adminsButton.setTitleColor(darkModeFontColor, for: .normal)
        adminsButton.layer.backgroundColor = UIColor.clear.cgColor
        adminsButton.isExclusiveTouch = true
        adminsButton.clipsToBounds = true
        adminsButton.titleLabel?.font = getCustomFont(name: .Ubuntu_Regular, size: 16)
        adminsButton.titleLabel?.adjustsFontSizeToFitWidth = true
        adminsButton.addTarget(self, action: #selector(adminsButtonPressed), for: .touchDown)
    }
    
    /** Objc methods for navigating between the different views in the paged horizontal scrollview*/
    @objc func databaseButtonPressed(sender: UIButton){
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn){
            sender.alpha = 0.8
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
        UIView.animate(withDuration: 0.25, delay: 0.25, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn){
            sender.alpha = 1
            sender.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        
        buttonBar?.moveUnderLineTo(this: sender)
    }
    
    @objc func coreDataButtonPressed(sender: UIButton){
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn){
            sender.alpha = 0.8
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
        UIView.animate(withDuration: 0.25, delay: 0.25, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn){
            sender.alpha = 1
            sender.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        
        buttonBar?.moveUnderLineTo(this: sender)
    }
    
    @objc func metricsButtonPressed(sender: UIButton){
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn){
            sender.alpha = 0.8
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
        UIView.animate(withDuration: 0.25, delay: 0.25, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn){
            sender.alpha = 1
            sender.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        
        buttonBar?.moveUnderLineTo(this: sender)
    }
    
    @objc func adminsButtonPressed(sender: UIButton){
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn){
            sender.alpha = 0.8
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
        UIView.animate(withDuration: 0.25, delay: 0.25, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn){
            sender.alpha = 1
            sender.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        
        buttonBar?.moveUnderLineTo(this: sender)
    }
    
    func constructUI(){
        navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 200))
        navItem.rightBarButtonItem = closeButton
        navItem.largeTitleDisplayMode = .always
        navBar.prefersLargeTitles = true
        navBar.setItems([navItem], animated: false)
        
        var barBgColor = appThemeColor
        switch darkMode{
        case true:
            barBgColor = UIColor.black
        case false:
            barBgColor =  appThemeColor
        }
        buttonBar = underlinedButtonBar(buttons: [databaseButton, coreDataButton, metricsButton, adminsButton], width: self.view.frame.width, height: 45, underlineColor: appThemeColor, underlineTrackColor: barBgColor.withAlphaComponent(0.8), underlineHeight: 2, backgroundColor: barBgColor, animated: true)
        
        view.addSubview(buttonBar!)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){[self] in
            navBar.sizeToFit()
            //Add the button bar below the navigation bar
            buttonBar?.frame.origin = CGPoint(x: 0, y: navBar.frame.maxY)
        }
        
        self.view.addSubview(navBar)
        view.backgroundColor = bgColor
    }
    
    /**Customize the nav and tab bars for this view*/
    func setCustomNavUI(){
        /**Prevent the scrollview from snapping into place when integrating with large title nav bar*/
        self.extendedLayoutIncludesOpaqueBars = true
        /**nav bar customization*/
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        /**Make the shadow clear**/
        standardAppearance.shadowColor = UIColor.clear
        
        navItem.leftItemsSupplementBackButton = true
        switch darkMode{
        case true:
            navBar.barTintColor = bgColor
            navBar.titleTextAttributes = [.foregroundColor: fontColor]
            navBar.tintColor = fontColor
            standardAppearance.backgroundColor = UIColor.black
            standardAppearance.largeTitleTextAttributes = [.foregroundColor: fontColor]
            standardAppearance.titleTextAttributes = [.foregroundColor: fontColor]
            
            /**Customize the navigation items if any are present*/
            if(navItem.rightBarButtonItems?.count != nil){
                for index in 0..<self.navItem.rightBarButtonItems!.count{
                    navItem.rightBarButtonItems?[index].tintColor = fontColor
                }
            }
            if(navItem.leftBarButtonItems?.count != nil){
                for index in 0..<self.navItem.leftBarButtonItems!.count{
                    navItem.leftBarButtonItems?[index].tintColor = fontColor
                }
            }
            
        case false:
            navBar.barTintColor = bgColor
            navBar.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBar.tintColor = UIColor.white
            standardAppearance.backgroundColor = appThemeColor
            standardAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            
            /**Customize the navigation items if any are present*/
            if(navItem.rightBarButtonItems?.count != nil){
                for index in 0..<self.navItem.rightBarButtonItems!.count{
                    navItem.rightBarButtonItems?[index].tintColor = UIColor.white
                }
            }
            if(navItem.leftBarButtonItems?.count != nil){
                for index in 0..<self.navItem.leftBarButtonItems!.count{
                    navItem.leftBarButtonItems?[index].tintColor = UIColor.white
                }
            }
        }
        navBar.standardAppearance = standardAppearance
        navBar.scrollEdgeAppearance = standardAppearance
    }
    
    /**Customize and set up the search controller for this view*/
    func setSearchController(){
        searchController = UISearchController(searchResultsController: nil)
        searchController!.searchResultsUpdater = self
        searchController!.obscuresBackgroundDuringPresentation = false
        searchController!.searchBar.placeholder = "Search for a table"
        
        /**Cancel button and editing carot*/
        switch darkMode {
        case true:
            searchController!.searchBar.tintColor = appThemeColor
        case false:
            searchController!.searchBar.tintColor = UIColor.white
        }
        searchController?.searchBar.barTintColor = fontColor
        self.navItem.searchController = searchController
        self.definesPresentationContext = true
        navItem.hidesSearchBarWhenScrolling = false
        navBar.backgroundColor = bgColor
        searchController?.searchBar.delegate = self
        searchController?.searchBar.searchTextField.textColor = lightModeFontColor
        searchController?.searchBar.searchTextField.backgroundColor = lightModeBgColor
        searchController?.searchBar.searchTextField.leftView?.tintColor = appThemeColor/**change color of searchbar icon*/
        searchController?.searchBar.searchTextField.font = .systemFont(ofSize: 16, weight: .light)
    }
    
    public func updateSearchResults(for searchController: UISearchController){
        //
    }
    
    @objc func closeButton(sender: UIBarButtonItem){
        dismiss(animated: true, completion: nil)
    }
}
