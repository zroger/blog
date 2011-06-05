---
  title: Embedding Custom Finds in Behaviors
  category: Behaviors
  tags:
    - behaviors
    - models
    - custom find
    - code
    - cakephp 1.3
  layout: post
---

Today, while outlining a datasource for a CDN, I REALLY needed to add a custom model find from outside of the model. Custom find types would greatly simplify the Model api and give the developer access to exotic types of finds without having to specify ridiculous option keys.

<!-- end_preview -->

By default, adding a custom model find is as follows:

* Add the find to the `$_findMethods` model property:

{% highlight php %}
<?php
class Post extends Model {
    function __construct($id = false, $table = null, $ds = null) {
        $this->_findMethods['custom'] = true;

        parent::__construct($id, $table, $ds);
    }
}
?>
{% endhighlight %}

* Define the method

{% highlight php %}
<?php
class Post extends Model {
    function __construct($id = false, $table = null, $ds = null) {
        $this->_findMethods['custom'] = true;

        parent::__construct($id, $table, $ds);
    }

    function _findCustom($state, $query, $results = array()) {
        if ($state == 'before') {
            $this->log('using custom find method');
            return $query;
        }
        return $results;
    }
}
?>
{% endhighlight %}

* Win at life

* * *

Unfortunately, this doesn't quite work as I thought it would by doing similarly in the `ModelBehavior::setup()` method. Usually methods are passed through to the behaviors via `Model::call__()`, but they are not when the method begins with the underscore (`_`) character. Lame.

So a work-around is to use the oft-forgotten `$mapMethods` method. Lets define a simple behavior:

{% highlight php %}
<?php
class CustomBehavior extends ModelBehavior {
    var $mapMethods = array();

    function setup(&$model, $settings = array()) {
    }
}
?>
{% endhighlight %}

* Define the custom find method:

{% highlight php %}
<?php
class CustomBehavior extends ModelBehavior {
    var $mapMethods = array();

    function setup(&$model, $settings = array()) {
    }

    function _findCustom($state, $query, $results = array()) {
        if ($state == 'before') {
            $this->log('using custom find method');
            return $query;
        }
        return $results;
    }
}
?>
{% endhighlight %}

* Add the custom find to the available custom finds for the Model:

{% highlight php %}
<?php
class CustomBehavior extends ModelBehavior {
    var $mapMethods = array();

    function setup(&$model, $settings = array()) {
        $model->_findMethods['custom'] = true;
    }

    function _findCustom($state, $query, $results = array()) {
        if ($state == 'before') {
            $this->log('using custom find method');
            return $query;
        }
        return $results;
    }
}
?>
{% endhighlight %}

* Add the appropriate `$mapMethods` regex:

{% highlight php %}
<?php
class CustomBehavior extends ModelBehavior {
    var $mapMethods = array('/\b_findCustom\b/' => '_findCustom');

    function setup(&$model, $settings = array()) {
        $model->_findMethods['custom'] = true;
    }

    function _findCustom($state, $query, $results = array()) {
        if ($state == 'before') {
            $this->log('using custom find method');
            return $query;
        }
        return $results;
    }
}
?>
{% endhighlight %}

* Win at life

This method can be used to add as many custom finds as necessary to your models. You will need to be careful that your regex doesn't match incorrectly, as `$mapMethods` uses a case-insensitive `preg_match()` in order to map the method. So just make your custom finds unique and everything should be fine. You can also use `\b` in your pattern so that partial matches do not trigger a find incorrectly.