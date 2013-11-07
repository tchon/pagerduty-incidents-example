PagerDuty Examples of Incidents API
=====================================

Brief
------
In order to run this script, you'll need ruby version 2.0.0.
It probably works fine with ruby 1.9.3, however, as both are
syntactically close in release changes.

It also uses bundler via Gemfile, so you should probably be
sure you are up-to-date with bundler and do a `bundle install`


Summary requirements of needed environment and versions
--------------------------------------------------------
  - ruby 2.0.x
  - gem 2.0.x
  - bundler 1.3.x


Detailed instructions per platform
------------------------------------

###  running on Mac OS X 10.8+

  1. You need to ensure that you have the latest build tools from Xcode
     via the App Store
     - `xcodebuild -version` => Xcode 5.0.1

  2. We employ latest homebrew package manager because its much better
     than MacPorts or managing it manually (via Makefiles).
     - `brew --version` => 0.9.5

  3. Be sure you are up-to-date with brew:
     - `brew update`

  4. Install ruby 2.0.0:
     - `brew install ruby`

  5. Install latest bundler:
     - `gem install bundler`
        * be sure `which gem` points to `/usr/local/bin/gem`
          i.e., do not use the one from Apple in /usr/bin
          as it will potentially result in version mismatch
          issues

  6. Now you can run `./most_recent_incidents.rb` to view
     the last 10 incidents


###  running on Linux
  TBD

###  running on BSD*
  TBD

###  running on Windows
  TBD


TODO
------------------------------------
  1. Optimize the time lookback. We are not always guaranteed
     that given a time interval that a minimum of 10 events
     will occur. In fact, based on a high-load system, we
     could have million of events occurring per minute, so
     its not smart to poll back the last 30 days (default).
     Although, PagerDuty seems to guard against this by setting
     a max default limit to 100.

  2. Pass in options to configure what fields to show rather
     than hardcoding just the create time, assigned user, and status.
