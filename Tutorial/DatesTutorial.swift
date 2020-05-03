import Foundation


//: #The basic date
//: The simplest date representation is from the type 'Date'. For the current date, instantiate a veriable with the constructor like this:
 
var date = Date()
print(date)
 
//: ##Time Intervals
//: On the other hand, you might want a measure of time. For this, use the type 'TimeInterval' This is measures of time using seconds. They are of 'Double' type. I'll set a few constants using time intervals.
let minute:TimeInterval = 60.0
let hour:TimeInterval = 60.0 * minute
let day:TimeInterval = 24 * hour
 
//:You can set a date based on the time interval. If you want a time interval different from now use the  constructor 'Date(timeIntervalSinceNow:)'
date = Date(timeIntervalSinceNow: minute)
print(date)
//: Gives you a date one minute from now. If you want a date where you add or subtract a time interval, use 'Date(timeInterval:since:)'
date = Date(timeInterval: hour, since: date)
print(date)
//: Gives us a date an hour from the previous date.
 
//: #Date Formatters
//: The date looks ugly. Let's make the date look better with a *date formatter*.  Start with initializing a date formatter
let dateFormatter = DateFormatter()
 
//: Date formatters require you to set a style for the date using the 'dateStyle' property and time property 'timeStyle'. You have a choice of '.full' '.long', '.medium', '.short', and '.none'
dateFormatter.dateStyle = .medium
dateFormatter.timeStyle = .short
//:  There's a function on date formatters, 'string(from:)' that return a string with the formatted date.
print(dateFormatter.string(from: date))
 
//: By changing the styles from '.full'
dateFormatter.dateStyle = .full
dateFormatter.timeStyle = .full
print(dateFormatter.string(from: date))
 
//:to '.short'
 
dateFormatter.dateStyle = .short
dateFormatter.timeStyle = .short
print(dateFormatter.string(from: date))
 
//:Provides for different formats. If you want only a date or a time, use '.none'
dateFormatter.dateStyle = .none
dateFormatter.timeStyle = .medium
print(dateFormatter.string(from: date))
 
//: Date formatters are locale dependent. They uses the current locale by default. You can change the locale and use that locale's format.
dateFormatter.dateStyle = .medium
dateFormatter.locale = Locale(identifier: "es-mx")
print (dateFormatter.string(from: date))
//: #Date Componenets
//: This is all good for relative dates from a time frame. What if you want an absolute date? that's where 'DateComponents' comes into play. A date component provides a way to add componenets for a date. Initialize 'DateComponents' like this:
 
var dateComponents = DateComponents()
//: You assign to date componenets the date
dateComponents.year = 2016
dateComponents.month = 11
dateComponents.day = 04
dateComponents.hour = 13
dateComponents.minute = 8
dateComponents.second = 0
 
//: The date components are optional values. When a value is not set it returns 'nil'. If you have a nil value for one componenet, operations on the 'dateComponents' object will cause an nil error.  There is a property 'isValidDate' to confirm if you have all of the information.
print(dateComponents.isValidDate)
//: Include the calendar used in a date componenets object. Usually this is the current calendar for the system. A calendar fills in the rest of the information the date componenets needs to make a valid date. You can get the current calendar using 'Calendar.current'
dateComponents.calendar = Calendar.current
print(dateComponents.isValidDate)
 
//: The date components have a property 'date', if you need a value of type Date. Of course you can format this way, changing the components back into dates.
date = dateComponents.date!
print(dateFormatter.string(from: date))
 
//: You can also convert a date to date components. However you do it from the current calendar, not the 'Date' type. Make a set of Calendar components. For most cases include the component .calendar to avoid a nil in the components.
let unitFlags:Set<Calendar.Component> = [.hour, .day, .month, .year,.minute,.hour,.second, .calendar]
 
//: Using the current calendar, get the components
dateComponents = Calendar.current.dateComponents(unitFlags, from: Date())
//: Print the date using the date formatter.
date = dateComponents.date!
print(dateFormatter.string(from: date))
 
//: Date components can be changed. The date componenets are all of type 'Int!'. While it is easier to change them using 'Date' and 'TimeInterval', you might need to to do it this way. For example, to add five days.
dateComponents.day = dateComponents.day! + 5
date = dateComponents.date!
print(dateFormatter.string(from: date))
 
//:Each of these types have their purposes. 'Date'  is the simplest and best for the current date and dates based on the current date. To indicate an interval in seconds, use the 'TimeInterval'. To work with indivdual date components, use 'DateComponents'. You'll find each of these in other API's as well. For example, all three have purposes in the UserNotification framework as event triggers. Learing how to use all three will help you display time and schedule time throughout iOS.