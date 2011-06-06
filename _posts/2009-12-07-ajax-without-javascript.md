--- 
layout: post
title: Ajax without Javascript
created: 1260242191
---
<p>Ajax is nothing new.  And especially since Drupal's adoption of <a href="http://jquery.com">jQuery</a>, ajax has certainly become much easier.  Generally, ajax requests in Drupal involve</p><ol><li>PHP code (usually in a module) to generate the necessary markup for the originating page.</li><li>Javascript code to handle the ajax response.</li><li>Some form of initialization code, usually in a Drupal behavior, to connect the markup to the behaviors.</li><li>PHP to generate the response, both for the ajax request and for the non-javascript page. (Oh, and it's up to you to decide how to tell the difference!)</li></ol><h2>Let the Chaos begin</h2><p>There's nothing inherently wrong with the above method, but there's definitely room for improvement.  With the introduction of <a href="http://drupal.org/project/ctools">CTools</a> (a.k.a Chaos tool suite), ajax development has become much simpler.  From the CTools project page on Drupal.org,</p><blockquote><p>"AJAX responder -- tools to make it easier for the server to handle AJAX requests and tell the client what to do with them."</p></blockquote><p>CTools introduces the concept of an ajax command.  A command is a javascript function within the Drupal.CTools.AJAX.commands namespace, which can be invoked as an ajax response.  The server-side callback returns an object representation of a command, and this object contains everything necessary to run the command on the client-side.  The easiest way to explain this is with an example.</p><p>We will be building an example module, which I will call "example".  This module will display a page with an ajax link that will reveal more content when clicked.</p><p>The first thing that is needed is a hook_menu() implementation to define two new paths.  The first is the page that will hold the link, and the second defines the ajax callback.  Take note of the %ctools_js in the second entry.  This is how we will determine if the call is being made from an ajax call or not.  More on that when we get to the callback code.</p>

<?php
/** 
 * Implementation of hook_menu().
 */
function example_menu() {
  $items = array();
  $items['test'] = array(
    'title' => 'Ajax Test',
    'page callback' => 'example_test_main',
    'access arguments' => array('access content'),
  );
  $items['test/%ctools_js/go'] = array(
    'page callback' => 'example_test_ajax_callback',
    'page arguments' => array(1),
    'access arguments' => array('access content'),
  );
  return $items;   
}
?>
<br />

<p>Now for the main page callback.  The only output on this page is a link to the second path that we defined.  The link has two things to take note of.  First, the path of the link is test/nojs/go.  The 'nojs' portion of the path will be replaced with 'ajax' when an ajax call is made.  This distinction is how we detect if the callback is being called from an ajax request or not.  The second thing to note is that we add a class of 'ctools-use-ajax' to the link.  This tells the ajax-responder javascript that this link should be processed by the ajax responder.  And finally, we must include the ajax-responder javascript.</p>

<?php
function example_test_main() {
  $output = l('Load more content', 'test/nojs/go', array(
    'attributes' => array('id' => 'test-ajax-link', 'class' => 'ctools-use-ajax')));

  ctools_add_js('ajax-responder');
  return $output;
}
?>
<br/>

<p>Last but not least, the ajax callback.  Notice how the function takes a boolean parameter for $js.  CTools takes care of turning the strings ('nojs' or 'ajax') into a boolean, so we have a very clean way to determine how to respond.  We will be returning the same content, in both conditions, to maintain accessibility for non-javascript enabled browsers (for <a href="http://en.wikipedia.org/wiki/Progressive_enhancement">progressive enhancement</a> as well as <abbr title="Search engine optimization">SEO</abbr>).</p>

<?php
function example_test_ajax_callback($js = FALSE) {
  $output = t('<p>Lorem ipsum dolor sit amet...</p>');

  if ($js) {
    ctools_include('ajax');

    $commands = array();
    $commands[] = ctools_ajax_command_after('#test-ajax-link', $output);
    $commands[] = ctools_ajax_command_remove('#test-ajax-link');

    ctools_ajax_render($commands);
    // above command will exit().
  }
  else {
    return $output;
  }
}
?>
<br/>

<p>In the javascript branch of the conditional, we construct an array of command objects.  Luckily for us, CTools offers a complementary php function for each javascript command, so creating the commands array is simple.  The particular set of commands that we are using will add the output after the link, then remove the link.  You can add as many commands as needed.  The last thing to do, is to pass the commands array through ctools_ajax_render, which will output the commands array as JSON and exit.  From that point on, the ajax-responder javascript on the first page takes over, and executes the commands in the order they are received.</p><h2>Tada!</h2><p>And that's it.  No javascript, just commands.  CTools provides many commands for most of the basic javascript actions, from which you can build compound actions to do almost anything.  Obviously, this set of commands cannot possibly cover every possible option, but I'll leave that for another day. Until then, here is the list of ajax commands provided by CTools.</p><ul><li> replace (ctools_ajax_command_replace)<ul><li>selector: The CSS selector. This can be any selector jquery uses in $().</li><li>data: The data to use with the jquery replace() function.</li></ul></li><li>prepend (ctools_ajax_command_prepend)<ul><li>selector: The CSS selector. This can be any selector jquery uses in $().</li><li>data: The data to use with the jquery prepend() function.</li></ul></li><li>append (ctools_ajax_command_append)<ul><li>selector: The CSS selector. This can be any selector jquery uses in $().</li><li>data: The data to use with the jquery append() function.</li></ul></li><li>after (ctools_ajax_command_after)<ul><li>selector: The CSS selector. This can be any selector jquery uses in $().</li><li>data: The data to use with the jquery after() function.</li></ul></li><li>before (ctools_ajax_command_before)<ul><li>selector: The CSS selector. This can be any selector jquery uses in $().</li><li>data: The data to use with the jquery before() function.</li></ul></li><li>remove (ctools_ajax_command_remove)<ul><li>selector: The CSS selector. This can be any selector jquery uses in $().</li></ul></li><li>changed (ctools_ajax_command_change)<ul><li>selector: The CSS selector. This selector will have 'changed' added as a clas.</li><li>star: If set, will add a star to this selector. It must be within the 'selector' above.</li></ul></li><li>alert (ctools_ajax_command_alert)<ul><li>title: The title of the alert.</li><li>data: The data in the alert.</li></ul></li><li>css (ctools_ajax_command_css)<ul><li>selector: The CSS selector to add CSS to.</li><li>argument: An array of 'key': 'value' CSS selectors to set.</li></ul></li><li>attr (ctools_ajax_command_attr)<ul><li>selector: The CSS selector. This can be any selector jquery uses in $().</li><li>name: The name or key of the data attached to this selector.</li><li>value: The value of the data.</li></ul></li><li>settings (ctools_ajax_command_settings)<ul><li>argument: An array of settings to add to Drupal.settings via $.extend</li></ul></li><li>data (ctools_ajax_command_data)<ul><li>selector: The CSS selector. This can be any selector jquery uses in $().</li><li>name: The name or key of the data attached to this selector.</li><li>value: The value of the data. Not just limited to strings can be any format.</li></ul></li><li>redirect (ctools_ajax_command_redirect)<ul><li>url: The url to be redirected to. This can be an absolute URL or a Drupal path.</li></ul></li><li>reload (ctools_ajax_command_reload)</li><li>submit (ctools_ajax_command_submit)<ul><li>selector: The CSS selector to identify the form for submission. This can be any selector jquery uses in $().</li></ul></li></ul>
