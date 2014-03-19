#!/usr/bin/env ruby
require 'rubygems'
require 'daemons'

Daemons.run('./cpu_killer.rb')
