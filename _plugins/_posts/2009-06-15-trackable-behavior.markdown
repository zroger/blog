---
  title: Trackable Behavior
  category: Behaviors
  tags:
    - cakephp
    - trackable
    - behaviors
    - github
    - quicktip
    - cakephp 1.2
    - cakephp 1.3
  layout: post
---


As always, I like taking code and trying to improve it. It's an exercise for me, sort of like dissecting a pig in high school. I try to understand what it is I am working with as much as I can before actually using it.

In this case, I had been thinking about how to track who created a record, and who last modified said record. There is [Logable Behavior](http://bakery.cakephp.org/articles/view/logablebehavior) at the Bakery, but I thought it was a bit overkill for my needs. So I went with [WhoDidIt Behavior](http://bakery.cakephp.org/articles/view/whodidit-behavior-automagic-created_by-and-modified_by-fields) by Daniel Vecchiato.

The implementation was still a bit messy, but I understood it well enough. Then I read Matt Curry's [Super Awesome Advanced CakePHP Tips eBook](http://www.pseudocoder.com/free-cakephp-book/) and saw a slightly varied implementation of WhoDidIt, except using his yummy User::get() syntax. Since this still required adding the model association on what you were tracking, it wasn't self-contained and a bit messier than WhoDidIt.

So at the end of the day, I decided to combine the two and produce this (hopefully) equally yummy Behavior. I believe it's a small improvement on both behavior's in that it:

- Uses Yummy Syntax
- Does not make me type more in the tracked model

Remember to implement Matt Curry's User::get() syntax, or this won't work. It's in his eBook, which I highly recommend.

Enhancements, Bug Fixes, Questions and Comments are welcome.

[http://github.com/josegonzalez/trackable-behavior](http://github.com/josegonzalez/trackable-behavior)