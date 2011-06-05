---
  title: Drop-down select fields in CakePHP
  category: Forms
  tags:
    - cakephp
    - forms
    - selects
    - dropdowns
    - cakephp 1.2
    - cakephp 1.3
  layout: post
---

For anyone wishing to make dropdown select fields in CakePHP forms happen automagically, here are some facts.

- Name your fields `field_name_id` in your tables.
- When setting data for the view, make sure it is variableized such as `fieldNames`. If you are in doubt, use Inflector::variable() to figure out what you need to do
- Bake will cry about missing tables, so make sure to be verbose when using Bake scripts, otherwise you will have issues
- If you want some field other than the Model::displayField to be used in a dropdown resulting from a `find('list')`, do the following:

{% highlight php %}
<?php
	$categories = $this->Category->find('list', array('fields' => array('my_field_here')));
?>
{% endhighlight %}

There are more things to share, but thats just a brief summary of what you need to do. Correct me if I'm wrong.