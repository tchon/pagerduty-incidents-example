#!/usr/bin/env ruby

###############################
# Author: Timothy Chon (tchon)
# Date: 2013-11-07 08:15 PST
# Program: This script lists the created date, assigned user, and status
#          for each of the 10 most recently created incidents in descending
#          date order, i.e., most recent incident first.
###############################

if !RUBY_VERSION.match(/^(1\.9|2\.0)/)
  puts "NOTE: this script requires at least ruby 1.9.3"
  exit 1
end


require "awesome_print"
require "httparty"
require "time"


module PagerDuty
  class Incident
    include HTTParty

    TOKEN = "VxuRAAxQoTgTjbo7wmmG"
    URL = "https://webdemo.pagerduty.com/api/v1/incidents"

    def run
      read
      trim
      sort
      print
    end

    def read
      # default lookback is 30 days per API docs, although
      # results limited to past 100 events
      @response = HTTParty.get(URL, :headers => headers)
      if @response.code != 200
        puts "Unsuccessful request! Got HTTP status code: #{@response.code}"
        exit 2
      end
      @payload = JSON.parse(@response.body)
    end

    def trim
      @incidents = @payload['incidents'].map do |incident|
        {
          :created_on => Time.parse(incident['created_on']),
          :assigned_to_user => incident['assigned_to_user'],
          :status => incident['status']
        }
      end
    end

    def sort
      # default order is created_at most recent first
      @incidents = @incidents.sort { |a, b| b[:created_on] <=> a[:created_on] }
    end

    def print
      #puts "----- Total Number of incidents: #{@incidents.length} ------"
      if @incidents.length > 10
        puts "#{@incidents.slice(0,10).awesome_inspect}"
      else
        puts "#{@incidents.awesome_inspect}"
      end
    end

    private

    def headers
      {
        'Authorization' => "Token token=\"#{TOKEN}\"",
        'Content-Type' => 'application/json'
      }
    end

  end
end

### "the big lebowski"
events = PagerDuty::Incident.new
events.run
