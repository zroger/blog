---
  title: Clean up your Model data with Purifiable Behavior
  category: Behaviors
  tags:
    - cakephp
    - github
    - behaviors
    - html purifier
    - licensing
    - cakephp 1.3
  layout: post
---

Someone on #cakephp had an issue with PHP timing out. Normally, I'd say it was just bad coding, but it's probably just a bad practice on their part. The issue they had is with HTML Purifier.

Now the library itself is pretty good. I've used it a few times, works great. The problem that arose was that they were sanitizing the data on the output instead of the input. That's a no-no. You'll run out of memory quick when you have lots of data to sanitize on the output, and you are duplicating the sanitization process on each page-view. That is really silly, as unless you have a sanitization scheme that changes all the time, your app is doing way more work than it needs to. So sanitize on the input.

Why sanitize on input? Facebook does it. Yes, I said it. When you have a mass of user-contributed material, you are bound to have some trouble-makers, especially on social networks. So you sanitize the hell out of your data.

So how do we do it? Well, we can either overwrite the original data before saving it, or save it to an extra field specially setup for cleaned data. In a CMS, it is trivial to save the extra data - you probably won't get that many comments anyways, to be honest - and web applications can use the original data to crawl for unusual activity or malevolent users. Hell, [Jonathan Snook](http://snook.ca) even used it to build a [comment spam blocker](http://snook.ca/archives/other/effective_blog_comment_spam_blocker). So saving the cleaned data in another field has it's benefits.

I created a behavior that uses the [HTMLPurifier library](http://htmlpurifier.org) to purify data. You can either overwrite the original data (if you are constrained by space or memory concerns), or you can simply allow it to be saved to another field. By default, it uses a suffix on your original field. Here is an example

{% highlight php %}
<?php
class Post extends Model {
	public $actsAs = array(
		'Purifiable.Purifiable' => array(
			'fields' => array('title', 'content')));
	
	public function saveNewPost() {
		$record = array(
			$this->alias => array(
				'title' => '<h1>sasafras</h1>',
				'content' => '<br><br><center><font size="2">testing</font></center>')
		);
		return $this->save($record);
	}
}
?>
{% endhighlight %}

Calling `Post::saveNewPost()` in the above example should populate the fields `title_clean` and `content_clean` with clean data, while keeping your other fields in their less than pristine state.

There are other options in the behavior which I have built in but don't want to elaborate upon at 5 in the morning, so feel free to muck about with it. I may add new features, but at the very least I should be able to add documentation soon.

_I hate people with LGPL. I want to release great code that people can depend on to work in a particular setup, but your stupid license contaminates everything it touches. Please only release works in MIT, BSD or other similar FOSS licenses (creative commons works too sometimes!)_

[The code is available on github, so fork away!](http://github.com/josegonzalez/purifiable)