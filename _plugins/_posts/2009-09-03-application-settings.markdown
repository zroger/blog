---
  title: Application Settings
  category: CakePHP
  tags:
    - cakephp
    - helpers
    - settings
    - quicktip
    - cakephp 1.2
    - cakephp 1.3
  layout: post
---

{% highlight php %}
<?php
/**
 * AppController
 *
 * Add your application-wide methods in the class below, your controllers
 * will inherit them.
 *
 * @package       cake
 * @subpackage    cake.app
 */
class AppController extends Controller {
/**
* Reads settings from database and writes them using the Configure class
* 
* @return void
* @access private
* @author Jose Diaz-Gonzalez
*/
	function _configureAppSettings() {
		$settings = array();
		$this->loadModel('Setting');
		$Setting = $this->Setting;
		if (($settings = Cache::read("settings.all")) === false) {
			$settings = $this->Setting->find('all');
			Cache::write("settings.all", $settings);
		}
		foreach($settings as $_setting) {
			if ($_setting['Setting']['value'] !== null) {
				Configure::write("{$_setting['Setting']['category']}.{$_setting['Setting']['setting']}", $_setting['Setting']['value']);
			}
		}
	}
}
?>
{% endhighlight %}