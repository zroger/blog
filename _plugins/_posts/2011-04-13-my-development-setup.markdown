---
  title: My development setup
  category: Other
  tags:
  layout: post
---

For the purposes of archiving how I like to develop, I'll chronicle a few things here.

As far as base things that need to get done, I typically install the [Homebrew package manager](http://github.com/mxcl/homebrew) right off the bat. This requires Xcode - you can get this by having a developer account or having an install CD from a Macbook Pro - to be installed, but then it's basically just a terminal installation. One thing that would be nice to see is a Formular browser, but for now I'm pretty content with how homebrew has turned out.

Next I install [RVM](https://rvm.beginrescueend.com/rvm/install/), a Ruby version manager, and get Ruby 1.8.7, Ruby 1.9.x, and REE installed. I'd like to get into Macruby/Jruby, but for now these are enough. [Ruby on Rails](http://rubyonrails.org/) typically gets installed, since every now and again I use it for something small, as does [Phusion Passenger](http://www.modrails.com/), since I am not as baller as all those who use [Unicorn](http://unicorn.bogomips.org/) and [Nginx](http://nginx.org/) on their macs. I also make sure to install [Jekyll](https://github.com/mojombo/jekyll), a ruby static site generator, which is how I install my blog. Running LSI to figure out related content means installing [Ruby-GSL](http://rb-gsl.rubyforge.org/), and then issuing `brew install gsl`. Homebrew comes in handy.

After that, I make sure to brew install a couple things:

- `brew install git`
- `brew install svn`
- `brew install bazaar`
- `brew install bazaar`
- `brew install mysql`
- `brew install mongodb`
- `brew install ack`
- `brew install python`
- `brew install pip`
- `brew install growlnotify`

I also install the [PHP Homebrew Alternative](https://github.com/adamv/homebrew-alt/blob/master/duplicates/php.rb) formula, after which I install either xdebug, as well as apc, memcache, or xcache, through Homebrew. Clutch.

Now I need to ensure I have all my ducks in a row, and I sync in my home directory scripts. My [gitconfig](https://gist.github.com/565837), my ssh keys, all sorts of yummy stuff.

[Textmate](http://macromates.com/) is the text editor I use, and I make sure to setup the [Git-Bundle](https://github.com/jcf/git-tmbundle) to my liking, including the hotkeys. The [CakePHP bundle](https://github.com/cakephp/cakephp-tmbundle) is up next, as is the [GitHub bundle](https://github.com/drnic/github-tmbundle). I use [PeepOpen](http://peepcode.com/products/peepopen) to find files in my projects - supports regular expression lookups - which is developed by the awesome guys at PeepCode.

I'll then make sure all my projects are installed in their proper directories (under ~/Sites). Once that is through, I'll install [VirtualHostX](http://clickontyler.com/virtualhostx/), which I use to configure Apache VirtualHosts. At this point, I enable the PHP module in my apache conf, and once the default Apache setup is enabled in the `Sharing` panel of `System Preferences`, I have all my sites ready and rearing to go (assuming I've imported a backup of my virtualhosts).

Now I need all the browsers ever. Install the latest versions of [Chrome](http://www.google.com/chrome/), [Firefox](http://www.mozilla.com/en-US/firefox/new/), Safari, [Opera](http://www.opera.com/). Get [iPhoney](http://www.marketcircle.com/iphoney/), which lets you test mobile sites on an iPhone-like browser. My [Parallels](http://www.parallels.com/products/desktop/) vms get rsync'ed over, and I go through a very painful install of Parallels (gotta download their app from their panel). Test to ensure that all my vhosts are getting passed into my VMs, and then onto the next step.

Python should be setup via Homebrew, refer to the docs for that (I do that before setting up PHP). I don't normally use Python, but every once in a while a tool I use will require it.

[Skype](http://www.skype.com) and Adium are a must for chatting. Everyone has a different Adium setup - just copy your old profile for that ;) - but for Skype I use [version 2.8](http://www.skype.com/intl/en/get-skype/on-your-computer/macosx/2-8/). [Tweetie](http://www.atebits.com/tweetie-mac/) also deserves a mention here. The new Twitter for Mac is lame in that it follows me on every single workspace, but they may have fixed that since I last checked.

I also install [TotalFinder](http://totalfinder.binaryage.com/) and [Visor](http://visor.binaryage.com/). TotalFinder is like Finder but more boss, with tabs and everything. If you've ever played Quake, you'll know what Visor is. Drop-down terminal. Makes life easy.

I'll also install [Dropbox](http://www.dropbox.com/) for the 5 times I use it ever, as well as [CloudApp](http://getcloudapp.com/). CloudApp makes file-sharing easy, and I use it on a regular database to share screenshots with other developers.

I install [Pixelmator](http://www.pixelmator.com/) for quick and dirty image-editing, and Photoshop for things that my boss needs to be pixel-perfect. If Pixelmator could fully support Photoshop images, that would be sweet, but I guess we can't have everything. [iShowU HD](http://store.shinywhitebox.com/ishowuhd/main.html) is good for screencasting, and I'll also install [Silverback](http://silverbackapp.com/) for recording user interaction with a site/screencasting.

For Git tooling, I'll install [Git Tower](http://www.git-tower.com/), which is sort of like [Versions](http://versionsapp.com/) is for SVN. I'll also install GitX - use [Brotherbard's branch](https://github.com/brotherbard/gitx) from github - and [GitNub](https://github.com/Caged/gitnub), which provide some of the Git Tower features, but with a less-polished UI. Definitely an alternative for those not wishing to spend money. [Kaleidoscope](http://www.kaleidoscopeapp.com/) also works well for file diffing. I haven't checked out alternatives in that space, but there should be something roughly equivalent for free.

I typically need access to productivity software, so I grab my copies of iWorks and Office for Mac.

As far as utilities, I use [Transmit](http://www.panic.com/transmit/) for FTP, [Speed Download](http://www.yazsoft.com/) for downloading many files at once, [UnRarX](http://www.unrarx.com/) for rar files, [Split&Concat](http://www.xs4all.nl/~loekjehe/Split&Concat/) for concatenating large files I've downloaded off the internet (typically zips of large binary image files spanning several hundred megabytes), [uTorrent](http://www.utorrent.com/) so I can quickly get ISOs of Linux distributions - [Vagrant](http://vagrantup.com/) is a nice tool I'm playing around with - and [Sequel Pro](http://www.sequelpro.com/) for interacting with MySQL databases. [Omnigraffle Professional](http://www.omnigroup.com/products/omnigraffle/) deserves a mention, simply for the 7 or 8 times a month I use it when creating a schema for something I'd like feedback on.

What are you using?