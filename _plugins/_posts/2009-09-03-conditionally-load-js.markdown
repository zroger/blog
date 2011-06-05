---
  title: Conditionally Load Javascript
  category: Views
  tags:
    - cakephp
    - conditional
    - javascript
    - quicktip
    - cakephp 1.2
  layout: post
---

{% highlight php %}
<?php
$includeScripts = array(
	"jquery/jquery",
	"jquery/jquery.easing.1.3",
	"jquery/jquery.easing.compatibility",
);

$layoutScript = sprintf('%sviews/layouts/%s.js', JS, $this->layout);
if (file_exists($layoutScript)) {
	$includeScripts[] = substr($layoutScript, strlen(JS));
}

$action = (isset($viewElement))
	? $viewElement
	: $this->params['action'];

$controllerScript = sprintf('%sviews/%s/default.js', JS, $this->params['controller']);
if (file_exists($controllerScript)) {
	$includeScripts[] = substr($controllerScript, strlen(JS));
}


$viewScript = sprintf('%sviews/%s/%s.js', JS, $this->params['controller'], $action);
if (file_exists($viewScript)) {
	$includeScripts[] = substr($viewScript, strlen(JS));
}

if ($this->params['pass'] && preg_match('/^\w+$/', $this->params['pass'][0])) {
	$viewScript = sprintf('%sviews/%s/%s.js', JS, $this->params['controller'], $action . '_' . $this->params['pass'][0]);
	if (file_exists($viewScript)) {
		$includeScripts[] = substr($viewScript, strlen(JS));
	}
}

foreach ($includeScripts as $script) {
	echo $html->script($script);
}
?>
{% endhighlight %}