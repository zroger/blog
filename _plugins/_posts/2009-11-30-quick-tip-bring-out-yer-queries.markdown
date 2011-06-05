---
  title: Quick Tip - Bring Out Yer Queries
  category: Datasources
  tags:
    - cakephp
    - github
    - quicktip
    - datasources
    - debugging
    - mysql
    - logging
    - cakephp 1.2
    - cakephp 1.3
  layout: post
---

When I was a lad... jk

Log your queries to find out what CakePHP is doing when it has 9 million blobs or is taking 34234 years to process (then use the 'contain' and 'fields' keys in your queries to trim it down.)

{% highlight php %}
<?php
/**
 * MySQL Logging layer for DBO.
 *
 * Original idea by Rainchen
 * Article at: http://bakery.cakephp.org/articles/rainchen/2009/03/09/how-to-debug-as-in-rails
 * PHP versions 4 and 5
 *
 * CakePHP(tm) : Rapid Development Framework (http://cakephp.org)
 * Copyright 2005-2009, Cake Software Foundation, Inc. (http://cakefoundation.org)
 *
 * Licensed under The MIT License
 * Redistributions of files must retain the above copyright notice.
 *
 * @copyright     Copyright 2005-2009, Cake Software Foundation, Inc. (http://cakefoundation.org)
 * @link          http://cakephp.org CakePHP(tm) Project
 * @package       datasources
 * @subpackage    datasources.models.datasources.dbo
 * @since         CakePHP Datasources v 0.2
 * @license       MIT License (http://www.opensource.org/licenses/mit-license.php)
 */

App::import('Datasource', 'DboSource');
App::import('Datasource', 'DboMysql');

/**
 * DBO implementation for the MySQL DBMS with logging enabled.
 *
 * A DboSource adapter for MySQL that enables developers to log queries
 *
 * @package datasources
 * @subpackage datasources.models.datasources.dbo
 */
class DboMysqlLog extends DboMysql {

/**
 * Datasource Description
 *
 * @var string
 */
	public $description = 'MySQL Logging DBO Driver';

/**
 * Log given SQL query.
 *
 * @param string $sql SQL statement
 */
	public function logQuery($sql) {
		$return = parent::logQuery($sql);
		if (Configure::read('logQueries')) {
			$this->log("sql[{$this->_queriesCnt}]:{$sql}", 'sql');
		}
		return $return;
	}
}
?>
{% endhighlight %}

Place that in `app/models/datasources/dbo_mysql_log.php` and set `driver` key in your database configuration to `mysql_log`. You'll need to use `Configure::write('logQueries', true)` whenever you want to enable logging. I normally turn this on and off in my bootstrap file. I modified this datasource to work in 1.3, and the original code is from a bakery article.

If you are using CakePHP 1.3, it is also available in the [CakePHP datasources plugin](https://github.com/cakephp/datasources) on github.