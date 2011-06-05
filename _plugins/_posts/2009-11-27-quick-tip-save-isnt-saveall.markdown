---
  title: Quick Tip - Model::save() isn't Model::saveAll()
  category: Models
  tags:
    - quicktip
    - cakephp
    - models
    - snippet
  layout: post
---

Saving multiple records that are related to a primary record?

{% highlight php %}
<?php echo $this->Page->save($this->data); ?>
{% endhighlight %}

That won't save your related model data. Just the primary model (Page Model in this case).

{% highlight php %}
<?php echo $this->Page->saveAll($this->data, array('validate' => 'first')); ?>
{% endhighlight %}

This will. Have fun saving your page meta data.


_Note: I added the validate first so that everything would be validated (who doesn't want that?)._