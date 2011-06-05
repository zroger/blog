---
  title: Adding a Helper/Behavior/Component on the fly
  category: CakePHP
  tags:
    - cakephp
    - behaviors
    - components
    - helpers
    - fails
    - snippet
    - cakephp 1.2
    - cakephp 1.3
  layout: post
---

Since I am on #cakephp at irc.freenode.org, I noticed a question about using a component in only one controller action.

I previously had a similar question about a helper and it was pointed out that the following works:

Controller Class:

{% highlight php %}
<?php
class PostsController extends Appcontroller {
	var $name = 'Posts';
	var $helpers = array('Text');
	
	function index() {
		$this->helpers[] = 'Time';
	}
	
	function add() {
	}
}
?>
{% endhighlight %}

In the above example, the TextHelper can be used everywhere. Note that the FormHelper is always available, as is the HtmlHelper and the XmlHelper (depending upon the type of request). The TimeHelper would ONLY be available at the PostsController::index() action. Good way to decrease the memory usage in an app, as some helpers are rarely always needed.

Behaviors are a bit trickier. You need to attach it to the Model's BehaviorCollection
Model Class:

{% highlight php %}
<?php
class Post extends AppModel {
	var $name = 'Post';
	var $actsAs = array('Cacheable');
	
	function beforeSave() {
		$this->Behaviors->attach('Twitterable');
	}
}
?>
{% endhighlight %}

Controller Class:

{% highlight php %}
<?php
class PostsController extends Appcontroller {
	var $name = 'Pages';
	
	function index() {
		$this->Post->Behaviors->attach('Trim.Trim');
		// Some model stuff goes on here, with TrimBehavior in play
		$this->Post->Behaviors->detach('Trim.Trim');
		// No more TrimBehavior :(
	}
	
	function add() {
	}
}
?>
{% endhighlight %}

In the above example, I use my custom CacheableBehavior (might be on my http://github.com account...) in all interactions with my Post Model. On the beforeSave, I attached the TwitterableBehavior (another custom thing, works at the Model::afterSave() level). TwitterableBehavior is therefore never loaded in my PostsController::index() action, but it IS loaded in my PostsController::add() action (I've omitted the code for brevity). I also load TrimBehavior from my TrimPlugin, which creates a tinyurl for the current resource, and detach it when I am done (you do not have to detach a behavior). Nifty way of saving on memory usage.

For Components, we are in a whole other ballgame. We could try the same trick as the one used for Helpers, but that will give you an error

{% highlight php %}
<?php
$this->components[] = 'Email';
// Some email-fu here
$this->Post->Email->send();
Call to undefined method stdClass::send()
?>
{% endhighlight %}

FAIL
There is no ComponentCollection, so don't even think of attempting the following:

{% highlight php %}
<?php
	$this->Post->Components->attach('Email');
?>
{% endhighlight %}

So what are we to do? See the following: http://tinyurl.com/ovf92z

Basically, since Components are loaded at startup (or at least before the Controller::beforeFilter() as far as I know), App::import() cannot be used as is. The loading of the Components runs Component::initialize() and Component::startup(), and therefore simply trying the Helper trick won't work. So instead, we must ALSO do what the loading does 

Below is the Component attached to that particular ticket in it's entirety. I'd probably add it to my AppController and then use it wherever I need a component. But that's just me :P
Component Class:

{% highlight php %}
<?php
//loads a component on the fly from within the controller
class ComponentLoaderComponent extends Object {
	
	var $controller = null;
	
	function initialize(&$controller) {
		// saving the controller reference for later use
		$this->controller =& $controller;
	}
	
	function load($component_name) {
		App::import('Component', $component_name);
		$component2 = $component_name.'Component';
		$component =& new $component2(null);
		
		if (method_exists($component, 'initialize')) {
			$component->initialize($this->controller);
		}
		
		if (method_exists($component, 'startup')) {
			$component->startup($this->controller);
		}
		
		$this->controller->{$component_name} = &$component;
	}
}
?>
{% endhighlight %}

Feel free to correct or improve any and all of the above gobbledyk-gook.

- Trac Ticket: [https://trac.cakephp.org/ticket/5170](https://trac.cakephp.org/ticket/5170)
- Component Bin Source: [http://bin.cakephp.org/view/947590030](http://bin.cakephp.org/view/947590030)