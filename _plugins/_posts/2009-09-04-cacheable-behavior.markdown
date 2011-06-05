---
  title: Cacheable Behavior
  category: Behaviors
  tags:
    - cakephp
    - behaviors
    - caching
    - quicktip
    - cakephp 1.2
  layout: post
---

{% highlight php %}
<?php
/**
 * Cacheable Model Behavior
 * 
 * Caches the file to the database
 *
 * @package app
 * @subpackage app.models.behaviors
 * @author Jose Diaz-Gonzalez
 * @version $Id$
 * @copyright Stoop Dev
 **/
class CacheableBehavior extends ModelBehavior {

/**
 * Initiate Cacheable Behavior
 *
 * @param object $model
 * @param array $config
 * @return void
 * @access public
 */
	function setup(&$model, $config = array()) {
	}

/**
 * After save callback
 *
 * @param object $model Model using this behavior
 * @param boolean $created True if this save created a new record
 * @access public
 * @return boolean True if the operation succeeded, false otherwise
 */
	function afterSave(&$model, $created) {
		$pluginName = get_parent_class($model);
		if ($pluginName == 'AppModel') {
			$pluginName = null;
		} else {
			$pluginName = substr($pluginName, 0 , -8);
			$pluginName = strtolower(Inflector::camelize($pluginName));
		}
		$requestPath = array(
			'plugin' => $pluginName,
			'controller' => Inflector::tableize($model->alias),
			'action' => 'view',
			'admin' => false,
			$model->id,
			Inflector::slug($model->data[$model->alias][$model->displayField])
		);

		$stops = array('published', 'approved');
		$stopped = false;
		$arr = array_keys($model->data[$model->alias]);
		foreach ($stops as $stop) {
			if (in_array($stop, $arr) and ($model->data[$model->alias][$stop] == 0)) {
				$stopped = true;
				break;
			}
		}

		if (!$stopped) {
			$cachePath = Router::url($requestPath, false);
			$surrenderOuput = $this->requestAction($cachePath, array('return', 'cacheableRequest' => true));
			$path = WWW_ROOT . "cache" . $cachePath . "/" . 'index.html';
			$file = new File($path, true);
			$file->write($surrenderOuput);
			$file->close();
		}

		return true;
	}

/**
 * Removes the respective file from cache
 *
 * @return void
 * @author Jose Diaz-Gonzalez
 **/
	function resetCache(&$model, $primaryKey = null, $displayField = null) {
		$path = '/' . Inflector::tableize($model->alias) . '/' . 'view' . '/' . $primaryKey . "/" . Inflector::slug($displayField);
		$path = WWW_ROOT . "cache" . $path . "/" . 'index.html';
		$file = new File($path, true);
		$file->delete();
		$file->close();
	}
}
?>
{% endhighlight %}