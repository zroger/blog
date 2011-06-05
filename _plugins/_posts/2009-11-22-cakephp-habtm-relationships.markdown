---
  title: CakePHP HABTM Relationships
  category: Models
  tags:
    - cakephp
    - habtm
    - relationships
    - join tables
    - counterCache
  layout: post
---

I'm working with a startup at the moment and am attempting to add a simple counterCache to a [http://book.cakephp.org/view/83/hasAndBelongsToMany-HABTM](hasAndBelongsToMany) (HABTM) relationship. Let me briefly define the HABTM relationship before I move on and go insane...

An habtm relationship consists of two different objects. Normally it is something like Tag HABTM Post, or Post HABTM Category. These are relatively simple and CakePHP gives a number of options for one to use. A common mistake is that CakePHP sets the 'unique' key on the HABTM relationship to true, and then people forget to pass the existing relationships in when saving new ones. This can be mitigated through:

1. simply setting the 'unique' key to false. 
2. behaviors to insert directly into the table
3. using a HasMany<->BelongsTo relationship between the models and the join Table

You might even want to do something like Post HABTM User, if you wanted to track the users that have modified a specific record. This isn't very efficient, but ["...scaling issues are the best issues to have. You should be so lucky."](http://carsonified.com/blog/carsonified/features/why-50-isnt-good-enough/) I actually make use of Alkemann's [Logable Behavior](http://github.com/alkemann/CakePHP-Assets/blob/master/models/behaviors/logable.php) for this, but you can do what you want.

Solution number 1 is cool, except that you'll definitely have fun when CakePHP inserts multiple of the exact same relationship. Have fun if you don't have a Primary Key on that table :)

Solution number 2 has been [spoken](http://bakery.cakephp.org/articles/view/add-delete-habtm-behavior) [about](http://stackoverflow.com/questions/1588318/cakephp-habtm-relationship-saving-data) [before](http://www.jamesfairhurst.co.uk/posts/view/full%5Fcakephp%5Fapplication%5Fpart%5F5/). Funstuff. Don't really need to explain how it works.

If you made a HasMany<->BelongsTo relationship, then you can just do whatever you want. Treat the table as if it were a regular model. Post HasMany PostsTags BelongsTo Post and Tag HasMany PostsTags BelongsTo Tag. Think about that for a second and treat it kindly. You can just pump things into the join table and everything will be hunky dory.

Now for my problem. The last solution provides built-in support for counterCache. It's incredibly easy to do it (Post and Tag tables can have their own little `posts_tags_count` field). Suppose you don't want to do that one though? Well, then there are two behaviors out there to do what we need.

- [http://bakery.cakephp.org/articles/view/counter-cache-behavior-for-habtm-relations](http://bakery.cakephp.org/articles/view/counter-cache-behavior-for-habtm-relations)
- [http://gist.github.com/235599](http://gist.github.com/235599)

I would use these, except the app I am working on is using HABTM INCORRECTLY! errg. Let me explain.

The application has Businesses, and Users can Favorite them. Of course, Users can also own their own businesses. So Users have many Favorite Businesses and Users own many businesses. These two are best modeled by the HABTM relationship. So what the company did was to create a businesses_users table, and then set a type on that table. The type indicates what kind of relationship it is.

:-\

This is wrong. Clearly wrong. Why? Because there should be, ideally, a `business_users` table that tracks ownership (you can name it `owners` if you really want to show the relationship in the database), and a `favorites` table to track the favoriting aspect. This would remove the need for a type, and allow the app to use CakePHP's built-ins for adding HABTM relations between records. Then I would be able to use any of the two previous HABTM CounterCache solutions. Instead, they add directly to the table, as if it were a HasMany<->BelongsTo relationship, when it most clearly is not (even in the models). This is very upsetting, as now I have to do an updateAll manually.

Please, when modeling your relationships in a table, think of the whoagies. Don't stuff two relationships into one table because they track the same kinds of records. The relationships are different, so mark them as such.