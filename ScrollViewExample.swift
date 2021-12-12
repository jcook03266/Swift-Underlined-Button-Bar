   
    private var navItem = UINavigationItem(title: "Developer Console 📱")
    private var closeButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(closeButton))
    private var navBar = UINavigationBar()
    private var databaseButton = UIButton()
    private var coreDataButton = UIButton()
    private var metricsButton = UIButton()
    private var adminsButton = UIButton()
    private var buttonBar: underlinedButtonBar? = nil
    /** The various different views will be hosted inside of this scrollview stack view combination*/
    private var scrollView = UIScrollView()
    private var stackView = UIStackView()
    private var viewHasLoaded = false
    private var databaseView = UIView()
    private var coreDataView = UIView()
    private var metricsView = UIView()
    private var adminsView = UIView()
    private var currentPage = 0

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
        databaseButton.titleLabel?.font = getCustomFont(name: .Ubuntu_Light, size: 16)
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
        coreDataButton.titleLabel?.font = getCustomFont(name: .Ubuntu_Light, size: 16)
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
        metricsButton.titleLabel?.font = getCustomFont(name: .Ubuntu_Light, size: 16)
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
        adminsButton.titleLabel?.font = getCustomFont(name: .Ubuntu_Light, size: 16)
        adminsButton.titleLabel?.adjustsFontSizeToFitWidth = true
        adminsButton.addTarget(self, action: #selector(adminsButtonPressed), for: .touchDown)
    }
    
    /** Objc methods for navigating between the different views in the paged horizontal scrollview*/
    @objc func databaseButtonPressed(sender: UIButton){
        currentPage = buttonBar!.getIndexOf(this: sender)!
        turnPage()
    }
    
    @objc func coreDataButtonPressed(sender: UIButton){
        currentPage = buttonBar!.getIndexOf(this: sender)!
        turnPage()
    }
    
    @objc func metricsButtonPressed(sender: UIButton){
        currentPage = buttonBar!.getIndexOf(this: sender)!
        turnPage()
    }
    
    @objc func adminsButtonPressed(sender: UIButton){
        currentPage = buttonBar!.getIndexOf(this: sender)!
        turnPage()
    }
    /** Objc methods for navigating between the different views in the paged horizontal scrollview*/
    
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
        buttonBar = underlinedButtonBar(buttons: [metricsButton, adminsButton], width: self.view.frame.width, height: 45, underlineColor: appThemeColor, underlineTrackColor: barBgColor.withAlphaComponent(0.8), underlineHeight: 2, backgroundColor: barBgColor, animated: true)
        
        view.addSubview(buttonBar!)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){[self] in
            navBar.sizeToFit()
            //Add the button bar below the navigation bar
            buttonBar?.frame.origin = CGPoint(x: 0, y: navBar.frame.maxY)
            
            scrollView.frame = CGRect(x: 0, y: buttonBar!.frame.maxY, width: view.frame.width, height: view.frame.height)
            stackView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
            
            scrollView.contentSize = CGSize(width: view.frame.width, height: scrollView.frame.height)
            
            let leading = NSLayoutConstraint(item: stackView, attribute: .leading, relatedBy: .equal, toItem: scrollView, attribute: .leading, multiplier: 1.0, constant: 0)
            scrollView.addConstraint(leading)
            let trailing = NSLayoutConstraint(item: stackView, attribute: .trailing, relatedBy: .equal, toItem: scrollView, attribute: .trailing, multiplier: 1.0, constant: 0)
            scrollView.addConstraint(trailing)
            let top = NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1.0, constant: 0)
            scrollView.addConstraint(top)
            let bottom = NSLayoutConstraint(item: stackView, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottom, multiplier: 1.0, constant: 0)
            scrollView.addConstraint(bottom)
            let equalHeight = NSLayoutConstraint(item: stackView, attribute: .height, relatedBy: .equal, toItem: scrollView, attribute: .height, multiplier: 1.0, constant: 0)
            scrollView.addConstraint(equalHeight)
            leading.isActive = true
            trailing.isActive = true
            top.isActive = true
            bottom.isActive = true
            equalHeight.isActive = true
            /**Set priority of this constraint to 1 to enable stack view and stack view subview user interactions, if this isn't set then taps aren't sent to the views as a result of constraint hiccups*/
            equalHeight.priority = UILayoutPriority(1000)
        }
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        /**Scrollview can override touches to the content within an use those touches as parameters for movement*/
        scrollView.canCancelContentTouches = true
        scrollView.isPagingEnabled = true
        scrollView.clipsToBounds = false
        scrollView.delaysContentTouches = true
        scrollView.isExclusiveTouch = true
        
        stackView.backgroundColor = UIColor.clear
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isUserInteractionEnabled = true
        stackView.semanticContentAttribute = .forceLeftToRight
        
        stackView.addArrangedSubview(databaseView)
        stackView.addArrangedSubview(coreDataView)
        stackView.addArrangedSubview(metricsView)
        stackView.addArrangedSubview(adminsView)
        
        scrollView.addSubview(stackView)
        self.view.addSubview(scrollView)
        self.view.addSubview(navBar)
    }

    /** ScrollView Button Bar Methods*/
    /**Override default listener for UIScrollview to inform the instantiated page control of a page change*/
    public override func scrollViewDidScroll(_ UIScrollView: UIScrollView){
        /** Prevent the smaller scrollviews that scroll in the same direction as the parent scroll view from affecting the parent scrollview's content offset*/
        if(UIScrollView != scrollView){
            scrollView.isScrollEnabled = false
        }
        else{
            let pageIndex = round(scrollView.contentOffset.x/scrollView.frame.width)
            
            /** Start from the offset of the first button then move until the total distance between the first and last button is covered*/
            let scrollingDistanceComputation = buttonBar!.getOffsetOfFirstButton() + ((buttonBar!.getTotalDistance()) * CGFloat(scrollView.contentOffset.x/(scrollView.frame.width * CGFloat(buttonBar!.buttons.count-1))))
            
            /** Shift the underline along the total distance between the first and last offset in the track according to the percentage of the scrollview scrolled*/
            buttonBar!.underline.frame.origin = CGPoint(x: scrollingDistanceComputation, y: 0)
            
            switch pageIndex{
            case 0:
                currentPage = 0
                buttonBar!.resizeTheUnderlineFor(this: buttonBar!.buttons[currentPage])
            case 1:
                currentPage = 1
                buttonBar!.resizeTheUnderlineFor(this: buttonBar!.buttons[currentPage])
            case 2:
                currentPage = 2
                buttonBar!.resizeTheUnderlineFor(this: buttonBar!.buttons[currentPage])
            case 3:
                currentPage = 3
                buttonBar!.resizeTheUnderlineFor(this: buttonBar!.buttons[currentPage])
            default:
                break
            }
        }
    }
    
    /** Switches to the current page indicated by the scrollview offset and moves the underline beneath the corresponding button*/
    func turnPage(){
        DispatchQueue.main.asyncAfter(deadline: .now()){[self] in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn){[self] in
                scrollView.contentOffset = CGPoint(x: scrollView.frame.width * CGFloat(currentPage), y: 0)
            }
        }
        
        /** Style the specific button corresponding to this page in the scrollview to show that it's being pressed/ is currently active*/
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn){[self] in
            buttonBar!.buttons[currentPage].alpha = 0.8
            buttonBar!.buttons[currentPage].transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
        UIView.animate(withDuration: 0.25, delay: 0.25, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn){[self] in
            buttonBar!.buttons[currentPage].alpha = 1
            buttonBar!.buttons[currentPage].transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        
        /** Delay this because animations need to finish*/
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01){[self] in
        switch currentPage{
        case 0:
            buttonBar!.moveUnderLineTo(this: buttonBar!.buttons[currentPage])
            searchController!.searchBar.placeholder = "Search for a table"
        case 1:
            buttonBar!.moveUnderLineTo(this: buttonBar!.buttons[currentPage])
            searchController!.searchBar.placeholder = "Search for an entity"
        case 2:
            buttonBar!.moveUnderLineTo(this: buttonBar!.buttons[currentPage])
            searchController!.searchBar.placeholder = "Search for a statistic"
        case 3:
            buttonBar!.moveUnderLineTo(this: buttonBar!.buttons[currentPage])
            searchController!.searchBar.placeholder = "Search for an admin"
        default:
            break
        }
        }
    }
    
    func scrollViewDidEndDecelerating(_ UIScrollView: UIScrollView) {
        /** Reenable the parent scrollview when any scrollview is done scrolling*/
        scrollView.isScrollEnabled = true
        
        //Force the underline to stay under the nearest element
        turnPage()
    }
    /** ScrollView Button Bar Methods*/
