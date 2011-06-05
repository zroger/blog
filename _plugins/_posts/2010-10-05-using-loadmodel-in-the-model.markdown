---
  title: Using loadModel() in the Model
  category: Models
  tags:
    - cakephp
    - code
    - model
    - loadmodel
    - cakephp 1.3
  layout: post
---

In IRC, a frequently asked question is how to use unrelated models in both controllers and models.

The standard answer for controllers is to use `Controller::loadModel()` in the Controller, as this can be used in combination with `Controller::$persistModel`, as well as other features, to quickly cache the model for faster loading later. It's a pretty neat trick.

In the Model, however, the answer has been to use `ClassRegistry::init()` to load models. It works, but it returns an instance of the model, where most developers might expect it to create a class variable like `Controller::loadModel()` does. Because it returns an instance, it also uses more memory and developers use it in all sorts of crazy ways. It's a mess.

Last night, someone asked about what they should use in a Model, so instead of repeating the same tired answers, I came up with a `Model::loadModel()` method of my own.

{% highlight php %}
<?php
class AppModel extends Model {

/**
 * Loads and instantiates models.
 * If the model is non existent, it will throw a missing database table error, as Cake generates
 * dynamic models for the time being.
 *
 * Will clear the model's internal state using Model::create()
 *
 * @param string $modelName Name of model class to load
 * @param mixed $options array|string
 *              id      Initial ID the instanced model class should have
 *              alias   Variable alias to write the model to
 * @return mixed true when single model found and instance created, error returned if model not found.
 * @access public
 */
    function loadModel($modelName, $options = array()) {
        if (is_string($options)) $options = array('alias' => $options);
        $options = array_merge(array(
            'datasource'  => 'default',
            'alias'       => false,
            'id'          => false,
        ), $options);

        list($plugin, $className) = pluginSplit($modelName, true, null);
        if (empty($options['alias'])) $options['alias'] = $className;

        if (!isset($this->{$options['alias']}) || $this->{$options['alias']}->name !== $className) {
            if (!class_exists($className)) {
                if ($plugin) $plugin = "{$plugin}.";
                App::import('Model', "{$plugin}{$modelClass}");
            }
            $table = Inflector::tableize($className);

            if (PHP5) {
                $this->{$options['alias']} = new $className($options['id'], $table, $options['datasource']);
            } else {
                $this->{$options['alias']} =& new $className($options['id'], $table, $options['datasource']);
            }
            if (!$this->{$options['alias']}) {
                return $this->cakeError('missingModel', array(array(
                    'className' => $className, 'code' => 500
                )));
            }
            $this->{$options['alias']}->alias = $options['alias'];
        }

        $this->{$options['alias']}->create();
        return true;
    }

}
?>
{% endhighlight %}

I think it's pretty nifty. Usage is simple:

{% highlight php %}
<?php
class User extends AppModel {
    
    function getPosts($limit = 10) {
        $this->loadModel('Post');
        return $this->Post->find('all', array('limit' => $limit));
    }

    function getTags($limit = 10) {
        // Tag is really just an alias for a Category, we can then 
        // load up separate instances of the model for things like
        // attaching behaviors etc.
        $this->loadModel('Tag', 'Category');
        return $this->Category->find('all', array('limit' => $limit));
    }

}
?>
{% endhighlight %}

Of course, once you call `Model::loadModel()`, the loaded model is available for the length of the entire request, so long as it is called from that same initial model. It would be useful in cases where, for example, one needs to call an internal, unrelated Api Model repeatedly across multiple model methods.

Calling `Model::loadModel()` multiple times doesn't even create a new instance, merely clears it's internal state.

Feel free to use and abuse this. It is currently untested, and would do well to go into a behavior.