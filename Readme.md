Cloudkey
========

Introduction
------------

This gem, still under development, aims to provide an abstract interface to DailyMotion's Cloud service. 
Currently, it's mostly a rewrite of the Python and Php version.

Warning
-------

We were not able to use security features from the web service to craft restricted urls while testing the Python 
or PHP versions, so we supposed they had not been activated yet. 

Usage
-----

		# Fill in your credentials
		@cloudkey = Cloudkey.authenticate USER_ID, KEY

		# Grab a list of your medias
		p @cloudkey.media.list(:fields => [:id])

		# Get an embedded player for your video, with its usage restricted to a specific IP address
		p @cloudkey.media.embedded_url VIDEO_ID, Cloudkey::SecurityPolicy.new(:ip => "88.0.0.1", 
		
License
-------

Cloudkey is released under the MIT License. 