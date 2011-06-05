---
  title: Yahoo Maps-based Geocoding
  category: Models
  tags:
    - cakephp
    - yahoo maps
    - geocoding
    - cakephp 1.2
  layout: post
---

I recently had to create online maps for an art gallery, specifically for their exhibits. So I decided to use the Yahoo API to grab the coordinates based upon the data that was being sent to the model and save this to the database. Here's how I did it.

First, the model has to be aware of the Yahoo AppID. I set this as a variable within the model itself, but you can set it in the url.

{% highlight php %}
<?php
class Exhibit extends AppModel {

	var $name = 'Exhibit';
	var $yahooApiID = 'YOURAPPIDHERE';
}
?>
{% endhighlight %}

Next we should probably actually get the Latitude and Longitude for the data. I am assuming you have the correct fields defined in your exhibits table. The `CREATE TABLE` query is shown below

{% highlight sql %}
CREATE TABLE `exhibits` (
  `id` int(11) unsigned NOT NULL auto_increment
  `address` varchar(50) default NULL,
  `city` varchar(20) default NULL,
  `state_id` int(3) unsigned default NULL,
  `zipcode` int(5) default NULL,
  `lattitude` varchar(20) default NULL,
  `longitude` varchar(20) default NULL
  PRIMARY KEY  (`id`),
) ENGINE=InnoDB DEFAULT CHARSET=utf8
{% endhighlight %}

Now that you have the proper fields, we'll REALLY get the Latitude and Longitude. Below is the entire Model class relating to Exhibits:

{% highlight php %}
<?php
class Exhibit extends AppModel {

	var $name = 'Exhibit';

	function beforeValidate(){
		$curl = false;

		// Start constructing the URL
		$q = 'http://local.yahooapis.com/MapsService/V1/geocode?appid=';
		// Adding apiid
		$q .= $this->yahooApiID;
		// Adding Street
		$q .= '&street='.$this->data['Exhibit']['address'];
		// Adding City
		$q .= '&city='.$this->data['Exhibit']['city'];
		// Adding State
		//ClassRegistry::init('State')->getState($this->data['Exhibit']['state_id'])
		$q .= '&state='.ClassRegistry::init('State')->getState($this->data['Exhibit']['state_id']);
		// Adding Zip
		$q .= '&zip='.$this->data['Exhibit']['zipcode'];
		// If We had a location, we would do the following instead:
		// $q .= '&location='.rawurlencode($this->data['Exhibit']['location']);
		// Setting Output to xml
		$q .= '&output=php';
		$q = str_replace(' ', '%20', $q);

		//Using cURL or file_get_contents
		if ($curl){
			$c = curl_init();
			curl_setopt($c, CURLOPT_URL, $q);
			curl_setopt($c, CURLOPT_RETURNTRANSFER, 1);
			$phpContent = trim(curl_exec($c));
			curl_close($c);
		} else {
			$phpContent = file_get_contents($q);
		}
		$phpContent = unserialize($phpContent);

		$this->data['Exhibit']['lattitude'] = $phpContent['ResultSet']['Result']['Latitude'];
		$this->data['Exhibit']['longitude'] = $phpContent['ResultSet']['Result']['Longitude'];
	}
?>
{% endhighlight %}

I have allowed you to use either cURL or fopen. For cURL, you need to have that installed on your server, and for fopen, you need to have `allow_url_fopen` set to true in php.ini. Just giving options in case you can't do one or the other :)

You'll notice that when I get the State for this location, I initialize the model via `ClassRegistry`. Just out of habit. I also don't have a relationship to the State in my model, which is why I did this. Read about `Containable` (and `BindModel` for extra points!) for more information. The code for that call in the State model is as follows:

{% highlight php %}
<?php
class State extends AppModel{
	var $name = 'State';
	function getState($state = null){
		$state = $this->find('first',
			array(
				'recursive' => -1,
				'fields' => array(
					'State.title'
				),
				'conditions' => array('State.id' => $state)
			)
		);
		return $state['State']['title'];
	}
}
?>
{% endhighlight %}


So lets review:

- I set my AppID somehow
- Made sure my model contained the proper fields
- Added some code to the beforeValidate
- Updated two fields (latitude and longitude) in my model
- Made getting the State (depending upon state_id) a bit easier

You can now use the Latitude and Longitude in the views just as any other model data.

I realize that you might be thinking "This should be a behavior or something, I'll end up replicating this several times!" Well good. You make the behavior and I'll take credit! In all seriousness though, there is already a Geocode Model on the bakery that should be made into a behavior. This was just a quick fix before I converted it into a Behavior for my own usage :)