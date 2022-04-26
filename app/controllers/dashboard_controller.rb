class DashboardController < ApplicationController
  require 'json'
  require 'ostruct'
  require 'date'
  before_action :require_user, :session_active?
  # Load all events data
  # Find average sleep duration for last week + last month

  def index
    puts session[:oktastate]['credentials']['token']
    three_months_ago = 3.months.ago.strftime("%Y-%m-%d %H:%M:%S.%6N")
    current_time = Time.now.strftime("%Y-%m-%d %H:%M:%S.%6N")
    url = ENV['EVENTS_ENDPOINT']+"?startTime="+three_months_ago+"&endTime="+current_time
    # url = "http://127.0.0.1:8000/request/events"+"?user_id="+"#{session[:oktastate][1]}"+"&startTime="+three_months_ago+"&endTime="+current_time
    res = RestClient::Request.execute(:url => url, headers: {Authorization: "Bearer #{session[:oktastate]['credentials']['token']} "}, :method => :get,:verify_ssl => false )
    
    if res
      @response = JSON.parse(res,object_class: OpenStruct)
      # last_month_total_sleep, last_month_sleep_events
      # last_week_total_sleep, last_week_sleep_events
      @last_week_average_sleep = 9.5
      @last_month_average_sleep = 8
    end
    
  end
  

end
