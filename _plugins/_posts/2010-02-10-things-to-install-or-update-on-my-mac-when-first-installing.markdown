---
  title: Things to install or update on my mac when first installing
  category: Installation
  tags:
    - install
    - development
    - os x
    - useful
  layout: post
---

When I install, make the user `jose`, NOT some pseudonym. Will help later when ssh'ing into a box...

Also, restore the silly hidden files/folders in your home folder

First thing is first, install all my applications (as dictated by my current /Applications directory)

- [1Password](http://agilewebsolutions.com/products/1Password)
  - Emailed
- [Adium](http://beta.adium.im/)
  - /Users/user/Library/Application Support/Adium2.0
- [Balsamiq Mockups](http://www.balsamiq.com/)
  - Emailed
- [Chromium Nightly](http://build.chromium.org/buildbot/snapshots/chromium-rel-mac/)
  - /Users/user/Library/Application Support/Chromium
- [Eclipse Classic](http://www.eclipse.org/downloads/)
- [Firefox](http://www.mozilla.com/en-US/firefox/firefox.html)
  - /Users/user/Library/Application Support/Firefox
- [Gitnub](http://wiki.github.com/Caged/gitnub/)
- [Gitx](https://github.com/brotherbard/gitx/downloads)
- [Gmail Notifr](http://ashchan.com/projects/gmail-notifr)
- [Hex Color Picker](http://wafflesoftware.net/hexpicker/)
- iLife
  - Emailed
- iWorks
  - Emailed
- Java ME SDK 3.0
- Microsoft Office 2008
- [The Missing Sync](http://www.markspace.com/products/android/missing-sync-android.html)
  - WTF Have to check their site
- [OmniGraffle Professional](http://www.omnigroup.com/download/latest/OmniGrafflePro.dmg)
  - Emailed
- Open in TextMate
- Parallels Desktop
  - wtf I have to login to my account at http://www.parallels.com/ for the license
- [Pixelmator](http://www.pixelmator.com/)
  - Emailed
- Poedit
- Postbox
  - Emailed
- ScreenSteps
  - Emailed
- Sequel Pro
- Simple Comic
- Skype
  - /Users/user/Library/Application Support/Skype
- Speed Download 5
  - Emailed
- The Hit List
  - Emailed
- TextMate
  - Emailed
- TotalFinder
- Transmit
  - Emailed
- UnRarX
- VLC
- WBFS for MacOS X

Update ruby
{% highlight bash %}
sudo gem install rvm
rvm-install
rvm install ree
rvm ree --default
gem update
{% endhighlight %}

Install homebrew and related tools
{% highlight bash %}
Install XCode+X11 https://connect.apple.com
curl -L http://github.com/mxcl/homebrew/tarball/master | tar xz --strip 1 -C /usr/local
brew update
brew install wget
brew install git
brew install bazaar
brew install subversion
{% endhighlight %}

[Install a LAMP server with PHP 5.2 Support in homebrew](http://boztek.net/blog/2009/10/07/install-lamp-stack-source-mac-os-x-106-snow-leopard-using-homebrew)

[Install mercurial with Homebrew](http://github.com/webs/homebrew/commit/755dcb2de35950b7d662bec33e1dd06519ca4915)

Setup CakePHP in ~/Sites:

{% highlight bash %}
cd ~/Sites
git clone git://github.com/cakephp/cakephp1x.git cakephp1.2 -b 1.2
git clone git://github.com/cakephp/cakephp1x.git cakephp1.3 -b 1.3
cd cakephp1.3/plugins
git clone git://github.com/mcurry/ab_test.git
git clone git://github.com/petteyg/code_check.git
git clone git://github.com/cakephp/debug_kit.git
git clone git://github.com/mcurry/interactive.git
git clone git://codaset.com/cakedc/migrations.git
git clone git://github.com/mcurry/status.git
{% endhighlight %}

Install the Android Development Tools

Get all my documents from the git repository