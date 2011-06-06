--- 
layout: post
title: Drupal theme and module naming conflicts
created: 1248314152
---
<p>Andrew was having a problem earlier today with a theme's preprocess function not being called in the order he expected.  In particular, this function was a THEMENAME_preprocess_node() function.  The odd thing was, that when he looked at the theme registry using the handy devel module, the order of preprocess functions was</p><ul><li>THEMENAME_preprocess_node()</li><li>views_preprocess_node()</li><li>phptemplate_preprocess_node()</li></ul><p>The phptemplate_preprocess_node function is found in the base theme, so that didn't look out of place.  I then realized that the themes preprocess function was being called amongst a bunch of module preprocess functions.  That's when the light bulb went off in my head.</p><p>It turns out that there was also a module with the same name as the theme.  Since php has only a single namespace, THEMENAME_preprocess_node() was interpreted as MODULENAME_preprocess_node(). Yikes!!!</p><p>Let's get this fixed in Drupal 7.  There is already an <a href="http://drupal.org/node/371375">issue</a> in the Drupal issue queue to handle these naming conflicts.</p><p> </p>
