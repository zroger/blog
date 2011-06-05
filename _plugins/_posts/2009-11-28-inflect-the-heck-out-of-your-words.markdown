---
  title: Inflect Shell - Inflect the heck out of your word(s) 
  category: Console
  tags:
    - cakephp
    - cakeshell
    - inflector
    - github
    - cakephp 1.2
    - cakephp 1.3
  layout: post
---

CakePHP provides us with a nice little Inflector class. It's quite useful in creating slugs, as you can see from [Mariano Iglesias' Sluggable Behavior](http://github.com/mariano/syrup/blob/master/models/behaviors/sluggable.php). You can also use it to see what you should name your tables based upon your model name (is the tableized form of 'Person' 'person' or 'peoples'?). To initiate such tests, though, you'd usually need to either embed the code in an app - why are we using an entire app to variablize a phrase? - or use something like [Matt Curry's](http://pseudocoder.com/) [Interactive Plugin](github.com/mcurry/interactive) for the [DebugKit](thechaw.com/debug_kit). Both slightly lame because of the setup.

Anyways, I needed to turn a word/phrase into what the fieldname in the database would be in order to properly capture it for usage in a [defunct cms](http://github.com/josegonzalez/marcyavenue). I then thought of using the Interactive Plugin, but didn't have it installed in the app, and I thought refreshing pages/changing code to find out what methods to use would not be an efficient use of my time. So I spent around 3 hours coding up a little shell to do it instead :P

Usage is simple:

{% highlight bash %}
cake inflect
cake inflect methodName
cake inflect methodName word
cake inflect methodName words to inflect
{% endhighlight %}

It'll prompt for any missing information/anything that isn't correct (there isn't a 'helff' Inflector method, for example).

The code for this is available in the [inflection plugin on github](https://github.com/josegonzalez/inflection).

_Note: For the record, the correct rules for turning phrases into fieldnames are Inflector::underscore(Inflector::variable('phrase goes here'))_