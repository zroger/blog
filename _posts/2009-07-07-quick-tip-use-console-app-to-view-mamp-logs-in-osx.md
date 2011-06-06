--- 
layout: post
title: "Quick Tip: Use console.app to view MAMP logs in OSX"
created: 1246994038
---
<p>I've been using this little tip for so long now that I forgot how to do it, until I showed someone here at work how to do it.  You can use the standard console application that ships with OS X to view any type of log file.  Its not obvious how to do this since there is no interface to add a new log file, but once you figure it out, it couldn't be any easier.</p><ol><li>Open up a terminal.</li><li>cd ~/Library/Logs</li><li>ln -s /Applications/MAMP/logs MAMP</li><li>Open console.app and you will now see MAMP in the ~/Library/Logs tree</li></ol><p><img src="http://img.skitch.com/20090707-ems6pbtcy9k6e7bn4m8k2nft9t.jpg" alt="OSX console.app displaying Apache, MySQL and PHP error logs from MAMP" width="601" height="466" /></p>
