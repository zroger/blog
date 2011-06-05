---
  title: Rails-Style Error Messages in CakePHP
  category: Helpers
  tags:
    - cakephp
    - rails
    - helpers
    - errors
    - errorhelper
    - cakephp 1.2
    - cakephp 1.3
  layout: post
---

I've had a bit of code tucked away in various files for a while. It was code to deal with error messages.

In CakePHP, error messages are wrapped around the FormHelper::method() that created it. So if you create an error and you did the following:

{% highlight php %}
<?php
	echo $form->input('Post.title');
?>
{% endhighlight %}

You'd probably get the error message appended below that particular FormHelper::input() call. If you have the default stylesheet, it looks good. And you can still make it look good without the default by specifying your own styles. The correct item to style is ".error-message", for the record.

It's annoying to have to view a form and figure out what you messed up sometimes, and maybe you don't want it to break your beautifully laid out form. In the latter case, you could just set the following:

{% highlight css %}
.error-message {
	display: none
}
{% endhighlight %}

And presto chango, you are done. NOT. You forgot about actually outputting the errors. And this also doesn't cover when you have the former case. It might actually be a Section 508 requirement, I would have to get back to you.

Anywho, I built an ErrorsHelper months ago that kind of did this in a backwards fashion. It wasn't very automatic though. Had to echo the buggers manually where I needed it, and it also was kinda weird (as in I used it to list flash messages as well... but thats another story).

So while I was building out a [now defunct cms](http://github.com/josegonzalez/marcyavenue), noticed I was at a point where I might want to handle, oh, idk, the error messages, and decided to clean up that piece of my ResourceHelper. It was going well, and I realize that others might want to use it someday, so I have packaged it up a bit.

Usage is quite simple. Simply add the helper to the controller you need it to be in. In my example, I will attach it to the AppController (I also included the way to add it in one place specifically, such as the Controller::beforeRender() callback):

{% highlight php %}
<?php
class AppController extends Appcontroller {
	var $helpers = array('Errors');

	function beforeRender() {
		$this->helpers[] = 'Errors';
	}
}
?>
{% endhighlight %}

Then in your layout, simply do the follow:

{% highlight php %}
<?php echo $errors_for_layout; ?>
{% endhighlight %}

It works via the Helper::beforeRender() callback. For the moment, it is called automatically in the beforeRender, but in the future I will add some helpful configuration for you to use. You can also manually call the following:

{% highlight php %}
<?php echo $errors->for_layout(); ?>
{% endhighlight %}

It also takes care of echoing Session messages, both the default and the Authentication message. That will also be configurable in the near future. ErrorHelper requires jQuery, which is something I will ALSO make configurable (jeez, seems like I was being lazy, no?). I just wanted to get it out for you people, give me a break. I'll remove these warnings when I get them done...


[FYI, you can grab the stylish_errors plugin by clicking this delicious text. Feel free to "fork" it and make it better.](https://github.com/josegonzalez/stylish_errors)