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
