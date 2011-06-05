---
  title: How CakePHP Automagic fails me (or How I failed at the FormHelper)
  category: CakePHP
  tags:
    - fails
    - cakephp
    - forms
    - automagic
    - cakephp 1.2
    - cakephp 1.3
  layout: post
---

Okay, so I have a custom Model::find() that looks like the following:

{% highlight php %}
<?php
	function _findEditprofile($state, $query, $results = array()) {
		if ($state == 'before') {
			$query['conditions'] = array("{$this->alias}.{$this->primaryKey}" => User::get('id'));
			$query['contain'] = false;
			$query['fields'] = array(
				'id', 'first_name', 'last_name', 'email', 
				'job_title', 'phone_number', 'photo_file_name'
			);
			$query['limit'] = 1;
			return $query;
		} else if ($state == 'after') {
			if (isset($results[0])) {
				return $results[0];
			}
			return false;
		}
	}
?>
{% endhighlight %}

And I have an action, UsersController::profile(), with the following structure:

{% highlight php %}
<?php
	function profile() {
		if (!empty($this->data)) {
			$this->data['User']['id'] = User::get('id');
			if ($this->User->save($this->data, true, array(
					'id', 'first_name', 'last_name', 'email', 'job_title', 'phone_number',
					'password', 'new_password', 'new_password_confirm'))) {
				$this->Session->setFlash(__('Your profile has been saved', true));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->data = $this->User->resetDataForRegistration($this->data);
				$this->Session->setFlash(__('Your profile could not be saved. Please, try again.', true));
			}
		}
		if (empty($this->data)) {
			$this->data = $this->User->find('editprofile');
		}
	}
?>
{% endhighlight %}

and has the following form:

{% highlight php %}
<div>
	<?php $session->flash(); ?>
	<?php echo $form->create('User', array(
					'url' => array('controller' => 'users', 'action' => 'profile'))); ?>
		<fieldset>
			<legend><?php echo __('Edit Profile', true); ?></legend>
			<?php
				echo $form->input('User.first_name', array(
					'div' => 'input text required',
					'label' => __('First Name', true),
					'type' => 'text'));
				echo $form->input('User.last_name', array(
					'div' => 'input text required',
					'label' => __('Last Name', true),
					'type' => 'text'));
				echo $form->input('User.email', array(
					'div' => 'input text required',
					'label' => __('Email Address', true),
					'type' => 'text'));
				echo $form->input('User.job_title', array(
					'div' => 'input text required',
					'label' => __('Job Title', true),
					'type' => 'text'));
				echo $form->input('User.phone_number', array(
					'div' => 'input text required',
					'label' => __('Phone Number', true),
					'type' => 'text'));
				echo $form->input('User.photo', array(
					'div' => 'input file',
					'label' => __('Personal Photo', true),
					'type' => 'file'));
			?>
		</fieldset>
	<?php echo $form->submit(); ?>
	<?php echo $form->end(); ?>
</div>
{% endhighlight %}

I also have the following route setup

{% highlight php %}
<?php
	Router::connect('/profile', array('controller' => 'users', 'action' => 'profile'));
?>
{% endhighlight %}

Tell me why CakePHP thought it was a good idea to have the form submit to `/users/profile/1` ?

Because I have configured the FormHelper to submit to default to the `User` model, and `$this->data['User']['id']` is set! Either modify the find to remove the `id`, or modify the form to not submit with the `User` as default. Below are the examples in the order I proposed them:

{% highlight php %}
<?php
	function _findEditprofile($state, $query, $results = array()) {
		if ($state == 'before') {
			$query['conditions'] = array("{$this->alias}.{$this->primaryKey}" => User::get('id'));
			$query['contain'] = false;
			$query['fields'] = array(
				'first_name', 'last_name', 'email', 
				'job_title', 'phone_number', 'photo_file_name'
			);
			$query['limit'] = 1;
			return $query;
		} else if ($state == 'after') {
			if (isset($results[0])) {
				if (isset($results[0][$this->alias][$this->primaryKey])) {
					unset($results[0][$this->alias][$this->primaryKey]);
				}
				return $results[0];
			}
			return false;
		}
	}
?>
{% endhighlight %}

{% highlight php %}
<?php echo $form->create('', array(
				'url' => array('controller' => 'users', 'action' => 'profile'))); ?>
{% endhighlight %}

I used the first example to get the job done, but you can swat the flies or find cows that eat trees in Brooklyn for all I care ;)