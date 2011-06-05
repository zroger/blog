---
  title: Conditional Loading of Helpers
  category: Helpers
  tags:
    - cakephp
    - helpers
    - conditional
    - quicktip
    - cakephp 1.2
    - cakephp 1.3
  layout: post
---

{% highlight php %}
<?php
class TumblesController extends TumbleAppController {

	var $name = 'Tumbles';
	function beforeRender() {
		parent::beforeRender()
		$this->_configureHelpers($this->params['action']);
	}
/**
 * Configures the helpers for the current action
 *
 * @author Jose Diaz-Gonzalez
 */
	function _configureHelpers($action) {
		switch ($action) {
			case 'index' :
				$this->helpers[] = 'Text';
				$this->helpers[] = 'Time';
				break;
			case 'view' :
				$this->helpers[] = 'HtmlCache.HtmlCache';
				$this->helpers[] = 'Text';
				$this->helpers[] = 'Time';
				break;
			case 'admin_add' :
				$this->helpers[] = 'Tagging.Tagging';
				$this->helpers = array_merge($this->helpers, array('Wysiwyg.Wysiwyg' => array('editor' => Configure::read('AppSettings.application.editor'))));
				break;
			case 'admin_preview' :
				$this->helpers = array_merge($this->helpers, array('Wysiwyg.Wysiwyg' => array('editor' => Configure::read('AppSettings.application.editor'))));
				break;
		}
	}
}
?>
{% endhighlight %}