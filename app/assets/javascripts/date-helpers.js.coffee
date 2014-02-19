###
DATE HELPERS

A set of prototype modifiers for the Date class that will help out with
everyday date tasks.

REQUIRES: 	string-helpers.js (v0.1b)

Author: 	Jocko MacGregor
Version: 	0.1b
Date: 		January 20, 2014
###

#
#Returns the numeric representation of the day of the year.
#
#Source: http://javascript.about.com/library/bldayyear.htm
#
Date::getDayOfTheYear = ->
  onejan = new Date(@getFullYear(), 0, 1)
  Math.ceil (this - onejan) / 86400000


#
#Add date formating to the Date class using a modified subset of the 'strftime' fomatting patterns
#from Ruby.
#
#Author: Jocko MacGregor
#
#Date (Year, Month, Day):
#  %Y - Year with century
#  %C - year / 100 (round down.  20 in 2009)
#  %y - year % 100 (00..99)
#
#  %m - Month of the year, zero-padded (01..12)
#          %_m  blank-padded ( 1..12)
#          %-m  no-padded (1..12)
#  %B - The full month name (``January'')
#          %^B  uppercased (``JANUARY'')
#  %b - The abbreviated month name (``Jan'')
#          %^b  uppercased (``JAN'')
#
#  %d - Day of the month, zero-padded (01..31)
#          %-d  no-padded (1..31)
#  %e - Day of the month, blank-padded ( 1..31)
#
#  %j - Day of the year (001..366)
#		  %_j  blank-padded (  1..366)
#          %-j  no-padded (1..366)
#
#Time (Hour, Minute, Second, Subsecond):
#  %H - Hour of the day, 24-hour clock, zero-padded (00..23)
#		 %_H - blank-padded ( 0..23)
#  		 %-H - no-padded (0..23)
#  %k - Hour of the day, 24-hour clock, blank-padded ( 0..23)
#  %I - Hour of the day, 12-hour clock, zero-padded (01..12)
#		 %_I - blank-padded ( 0..12)
#		 %-I - no-padded (0..12)
#  %l - Hour of the day, 12-hour clock, blank-padded ( 1..12)
#  %P - Meridian indicator, lowercase (``am'' or ``pm'')
#  %p - Meridian indicator, uppercase (``AM'' or ``PM'')
#
#  %M - Minute of the hour (00..59)
#
#  %S - Second of the minute (00..59)
#
#Weekday:
#  %A - The full weekday name (``Sunday'')
#          %^A  uppercased (``SUNDAY'')
#  %a - The abbreviated name (``Sun'')
#          %^a  uppercased (``SUN'')
#  %u - Day of the week (Monday is 1, 1..7)
#  %w - Day of the week (Sunday is 0, 0..6)
#
#
#
Date::format = (fmt) ->
  fmt = fmt or "%Y-%m-%d %H:%M:%S"
  fmt_matches = fmt.match(/\%[-_^]{0,1}[YCymBbdejHkIlPpMSLNAauw]{1,1}/g)
  return fmt  if fmt_matches.length is 0
  f_months = [
    "January"
    "February"
    "March"
    "April"
    "May"
    "June"
    "July"
    "August"
    "September"
    "October"
    "November"
    "December"
  ]
  a_months = [
    "Jan"
    "Feb"
    "Mar"
    "Apr"
    "May"
    "Jun"
    "Jul"
    "Aug"
    "Sep"
    "Oct"
    "Nov"
    "Dec"
  ]
  am_pm = [
    "am"
    "pm"
  ]
  f_days = [
    "Sunday"
    "Monday"
    "Tuesday"
    "Wednesday"
    "Thursday"
    "Friday"
    "Saturday"
  ]
  a_days = [
    "Sun"
    "Mon"
    "Tue"
    "Wed"
    "Thu"
    "Fri"
    "Sat"
  ]
  fmt_matches = fmt_matches.sort()
  previous_match = ""
  i = 0
  while i < fmt_matches.length
    match = fmt_matches[i]
    unless previous_match is match
      val = ""
      re = null
      switch match
        when "%Y"
          re = /%Y/g
          val = @getFullYear()
        when "%C"
          re = /%C/g
          val = Match.floor(@getFullYear() / 100)
        when "%y"
          re = /%y/g
          val = ("" + @getFullYear % 100).lpad(2)
        when "%m"
          re = /%m/g
          val = ("" + (@getMonth() + 1)).lpad(2)
        when "%_m"
          re = /%\_m/g
          val = ("" + (@getMonth() + 1)).lpad(2, " ")
        when "%-m"
          re = /%\-m/g
          val = ("" + (@getMonth() + 1))
        when "%B"
          re = /%B/g
          val = f_months[@getMonth()]
        when "%^B"
          re = /%\^B/g
          val = f_months[@getMonth()].toUpperCase()
        when "%b"
          re = /%b/g
          val = a_months[@getMonth()]
        when "%^b"
          re = /%\^b/g
          val = a_months[@getMonth()].toUpperCase()
        when "%d"
          re = /%d/g
          val = ("" + @getDate()).lpad(2)
        when "%-d"
          re = /%\-d/g
          val = ("" + @getDate())
        when "%e"
          re = /%e/g
          val = ("" + @getDate()).lpad(2, " ")
        when "%j"
          re = /%j/g
          val = ("" + @getDayOfTheYear()).lpad(3)
        when "%-j"
          re = /%\-j/g
          val = ("" + @getDayOfTheYear())
        when "%_j"
          re = /%\_j/g
          val = ("" + @getDayOfTheYear()).lpad(3, " ")
        when "%H"
          re = /%H/g
          val = ("" + @getHours()).lpad(2)
        when "%-H"
          re = /%\-H/g
          val = ("" + @getHours())
        when "%_H"
          re = /%\_H/g
          val = ("" + @getHours()).lpad(2, " ")
        when "%k"
          re = /%k/g
          val = ("" + @getHours()).lpad(2, " ")
        when "%I"
          re = /%I/g
          val = ("" + ((if @getHours() % 12 is 0 then 12 else @getHours() % 12))).lpad(2)
        when "%-I"
          re = /%\-I/g
          val = ("" + ((if @getHours() % 12 is 0 then 12 else @getHours() % 12)))
        when "%_I"
          re = /%\_I/g
          val = ("" + ((if @getHours() % 12 is 0 then 12 else @getHours() % 12))).lpad(2, " ")
        when "%l"
          re = /%l/g
          val = ("" + ((if @getHours() % 12 is 0 then 12 else @getHours() % 12))).lpad(2, " ")
        when "%P"
          re = /%P/g
          val = am_pm[Math.floor(@getHours() / 12)]
        when "%p"
          re = /%p/g
          val = am_pm[Math.floor(@getHours() / 12)].toUpperCase()
        when "%M"
          re = /%M/g
          val = ("" + @getMinutes()).lpad(2)
        when "%S"
          re = /%S/g
          val = ("" + @getSeconds()).lpad(2)
        when "%A"
          re = /%A/g
          val = f_days[@getDay()]
        when "%^A"
          re = /%\^A/g
          val = f_days[@getDay()].toUpperCase
        when "%a"
          re = /%a/g
          val = a_days[@getDay()]
        when "%^a"
          re = /%\^a/g
          val = a_days[@getDay()].toUpperCase
        when "%w"
          re = /%w/g
          val = ("" + @getDay())
        when "%u"
          re = /%u/g
          val = "" + ((if @getDay() is 0 then 7 else @getDay()))
      fmt = fmt.replace(re, val)
      previous_match = match
    i++
  fmt