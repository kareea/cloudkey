Cloudkey
========

Introduction
------------

This gem, still under development, aims to provide an abstract interface to DailyMotion's Cloud service. 
Currently, it's mostly a rewrite of the Python version. 

Usage
-----

		# Fill in your credentials
		@cloudkey = Cloudkey.authenticate USER_ID, KEY

		# Grab a list of your medias
		p @cloudkey.media.list(:fields => [:id])

		# Get an embedded player for your video, with its usage restricted to a specific IP address
		p @cloudkey.media.embedded_url VIDEO_ID, Cloudkey::SecurityPolicy.new(:ip => "88.0.0.1")
		

License
-------

CloudkeyRb is Copyright © 2010-2011 Kareea SARL. It is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.
