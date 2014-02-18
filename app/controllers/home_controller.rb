class HomeController < ApplicationController
  def index
    if params[:search].present?
      redirect_to city_events_path(params[:search])
    else
      @events = Event.all
    end  
  end

  def get_city_events
    @places  = Place.near(params[:city], 50, :order => :event_id)
      @events = []
      @places.each do |place|
        @events << place.event
      end

  end

  def city_events_data
    @places  = Place.near(params[:city], 50, :order => :event_id)
      @events = []
      @places.each do |place|
        @events << place.event
      end
    data  = { 
          'events' => @events,
          'places' => @places }
      render json: data
    
  end
end