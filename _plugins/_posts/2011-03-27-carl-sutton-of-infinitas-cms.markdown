---
  title: Carl Sutton of Infinitas CMS
  category: Interviews
  tags:
    - cakephp
    - infinitas
    - cms
    - cakephp 1.3
  layout: post
---

I'd like to take a few posts to highlight those non-CakeDC and non-Core developers I feel have done a major service to the community in some fashion. If you fit the bill - I've yet to contact more than a handful of people - feel free to send me a message via twitter, github, email etc.

### What is Infinitas?

[Infinitas](https://github.com/infinitas/infinitas) is an open source content management system that was developed using the CakePHP v1.3 framework. Amongst other things, its a blog, cms, newsletter emailing system and on-line shopping cart. Carl Sutton and Walther Lalk are the developers of this CMS, which has been gaining some steam in recent months and is now in beta. It's a great alternative to Wordpress for developers that aren't as comfortable building out complex logic and want things built into the cms.

### The Interview

1. **Why yet another CMS? Other than there not being one in CakePHP.**
    {% blockquote %}When I started using cake (around 1.2b) there was almost nothing like this available.  most of the behaviours and components were for 1.1 which made them not all that easy to use for a noob. After getting into cake and having built a number of sites i found my self writing the same code over and over again. Using the bits of code in many apps was a problem as they were not "general" enough so I began building a few plug-ins that were much easier to drop into any site. This was still not the answer as there was always some code needed to tie the plug-ins into the app, like loading components and views and slowly Infinitas started taking shape.{% endblockquote %}
2. **What is the ultimate goal of your cms? Do you wish to become a standard amongst CakePHP developers?**
    {% blockquote %}Provide an app for building solid web apps with much less coding. Something that is more focused on some (any) kind of "content". Be it some blog posts, products in an e-commerce store or customers of a company (CRM). By definition Infinitas is a Content Management System (CMS), but its NOT Joomla! or WordPress. We do believe that CakePHP developers will benefit from all the hard work, but also hope it will show developers using other frameworks what they missing out on.{% endblockquote %}
3. **Of all the code in the current codebase, what is the single greatest accomplishment?**
    {% blockquote %}That would have to be the Events (callbacks/hooks) system that is built into Infinitas. It is pretty much the backbone of Infinitas and without it, things would not be as simple as they are. It does everything from allowing plug-ins to load routes and build cache configs right through to changing the output of views (even of other plug-ins). It is not only limited to the plug-ins that users would develop themselves but is also used throughout the core code that makes Infinitas what it is.{% endblockquote %}
4. **What needs the most love in Infinitas? In CakePHP?**
    {% blockquote %}Sadly that would be the tests. Currently they are very limited, but the tests that are done are for very global code. This is the reason its still alpha and is actually our next and final step before a RC will become available. The code base covers just about everything we wanted it to cover, so now all we need to do is test, test, test! During the testing we hope to uncover a lot of the security issues and any bugs that may exists.{% endblockquote %}
5. **If CakePHP had a feature that would greatly increase the ease of your development of Infinitas, what would it be?**
    {% blockquote %}I think CakePHP does a great job at being a framework. With out cake Infinitas would not be where it is today. Nothing comes to mind that is missing, but some of the things that made it really easy was the good documentation, all the Unit tests and the fantastic abstraction that it provides to everything (DB's, php, sessions and super globals etc). We have dropped support for php4 and will be nice to see that gone in Cake2.{% endblockquote %}
6. **Anything interesting in the Infinitas codebase that might be useful to outside developers?**
    {% blockquote %}Some times it can take a lot of abstract thinking to develop a DRY script that can be easily used over and over for a number of different things. The "reader" datasource for example does a whole lot of heavy lifting for some other datasources (currently JSON and XML). The later two only having 1 method each. Another example is the ViewCounter plug-in that is able to track views on any model, with no code in said model. This includes reporting and other related tasks. I hope that this can show other developers a different approach to development, that might take slightly longer to think up, but is way faster down the road.{% endblockquote %}
7. **Why is Dakota so handsome?**
    {% blockquote %}Must be all the pizza, late nights and lack of sun... same reason all developers are so handsome.{% endblockquote %}

### Notes

Where does Infinitas fit into your development cycle? If you need a full-stack, easy to use CMS, then Infinitas might be a good fit. The developers are open to comments and contributions, and are frequent contributors themselves to both the CakePHP Core and support in IRC. It's definitely something to keep your eye on.

It's telling that tests are always the hardest thing to write. They get something of a pass for being alpha/beta state, but testing is always important. I'd definitely like to see greater test coverage in the community at large, and should this CMS become widespread, it will be a nice example for testers if they continue to write unit tests, selenium tests, etc.

Download [Infitas](http://www.infinitas-cms.org/) at [Github](https://github.com/infinitas/infinitas) or track [Walther Lalk](http://twitter.com/#!/dakotairene) and [Carl Sutton](http://twitter.com/#!/dogmatic69) on twitter.