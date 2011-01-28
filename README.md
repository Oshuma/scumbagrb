scumbag
=======

Requirements
------------
* Ruby 1.9+
* [bundler](http://gembundler.com/)
* [MongoDB](http://www.mongodb.org/)

Install
-------
Clone the repo then create and edit the config file:

    $ git clone git://github.com/Oshuma/scumbag.git
    $ cd scumbag && cp config/scumbag.yml.example config/scumbag.yml

Make sure you have the gem dependencies:

    $ bundle install

Now run the server (in the foreground):

    $ rake run
