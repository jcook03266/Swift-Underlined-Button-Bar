# Swift-Underlined-Button-Bar
Custom UIView class that hosts an array of UIbuttons that have an 'underline' UIView beneath them which moves from button to button when the user presses on them.

![gif](Scrollview_1.gif)

Quick Setup:

1.) Copy and paste or download the underlinedButtonBar.swift file into your project.

2.) Instantiate and then add the underlinedButtonBar to a view of your choice.

3.) Call the moveUnderLineTo method inside of your button action methods to move the line between the buttons specified.

4.) Enjoy!

![gif](Scrollview_2.gif)

Advanced Setup (Manual Manipulation of the underline with a scrollview):

1.) Integrate the underlinedButtonBar.swift file into your project.

2.) Instantiate and then add the underlinedButtonBar to a view of your choice.

3.) Create a paged scrollView that has an embedded stackview inside of it that will host the pages the button bar will navigate through.

3.) Override the scrollViewDidScroll method to recognize which ever scrollview you need it to recognize, and inside of it compute the current 'page' the paged scroll view is on by using the current content offset of the scrollview. Next you have to compute the distance between the first and last elements of the scrollview, which you then use in conjunction with the completion percentage of the contentOffset and the total scrollview width to manually move the underline on it's track for every percentage of the scrollview's total content you move. You can find this code inside the scrollViewExample.swift file.

4.) After computing the current page and translations you must set the origin of the buttonbar's underline to this translation. Following this create a switch statement that corresponds to the amount of pages inside of your paged scrollview / stackview, and in this you resize the underline to adjust to the title label of the button and you set a global current page variable to the computed page index you found in this method.

5.) Use the scrollViewDidEndDecelerating method to make the underline remain precisely under the current button, the underline may overshoot by a few pixels, hardly noticable, but forcing it to stick will get rid of this error. In the scrollView example file a custom method called turnPage() is used to style the buttons and set the scrollview's offset when one of the buttons is pressed, it's used in each button's action method.

6.) Finally, inside of the action methods for each button, set the content offset for the scrollView, an appropriate solution for this is the turnPage() method described previously where each button can be animated and their functions centralized in one method.

7.) Test everything to make sure the UI is behaving properly, if anything don't be afraid to tweak some settings.

8.) Again, enjoy!
