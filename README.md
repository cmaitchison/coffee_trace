Coffee Trace
============

A dead simple way to add trace logging to your coffeescript code... and then remove it when you're done.

To install
----------    
    
    gem install coffee_trace
     
To turn trace logging on
----------------------------------
    coffee_trace on

Coffee Trace will find all .coffee files below your current directory and insert a log statement after every method it finds.
     
    class MyCoffee   
      initialize: (arg1, arg2) ->
        @doStuff()
       
      doStuff: ->
        alert("ok")

will become

    class MyCoffee   
      initialize: (arg1, arg2) ->
        console.log "mycoffee-initialize", arg1, arg2 #coffee_trace
        @doStuff()
       
      doStuff: ->
        console.log "mycoffee-doStuff" #coffee_trace
        alert("ok")

To turn trace logging off
----------------------------------       
    coffee_trace off

Coffee Trace will remove all log statements that it added to files below the current directory.

***

For those interested in the source code, I was experimenting with a pattern where class names are not nouns, but the single responsibility of the class. I am not convinced yet that it is a pattern I'd use on a bigger project, but it is quite interesting and seems to help keep classes small and testable.

***

Copyright (c) 2011 Chris Aitchison. See LICENSE for details.
    

