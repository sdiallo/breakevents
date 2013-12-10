class HomeController < ApplicationController
  def index
    @events = Event.all
  end


  def get_event_data
 
  	@event = Event.all
  	#raise @event00.inspect
  
  	@places = []
  	@event.each do |event|
  		@places << event.place
  		
  	end
  	data  = { 
  				'events' => @event,
  				'places' => @places }
  	render json: data
 
  end
end