class EventImporterController < ApplicationController
  def index
  	user = FbGraph::User.new("me", :access_token => current_user.fb_token).fetch
  	@events = user.events
  	
  	#@events.each do |event|
  		# raise @events.inspect
  	#end
  end

  def import_event
  	event = FbGraph::Event.fetch(params[:fb_eid], :access_token => current_user.fb_token)
   # raise event.inspect
    @event = Event.create!(fb_eid:params[:fb_eid],
                  name:event.raw_attributes[:name],
                  description:event.raw_attributes[:description],
                  start_time:event.raw_attributes[:start_time],
                  end_time:event.raw_attributes[:end_time],
                  location:event.raw_attributes[:location],
               
                  )
    Place.create(street:event.raw_attributes[:venue][:street],
                        city:event.raw_attributes[:venue][:city],
                        state:event.raw_attributes[:venue][:state],
                        country:event.raw_attributes[:venue][:country],
                        zip:event.raw_attributes[:venue][:zip],
                        latitude:event.raw_attributes[:venue][:latitude],
                        longitude:event.raw_attributes[:venue][:longitude],
                        name:event.raw_attributes[:venue][:name],
                        event_id: @event.id
                        )
    redirect_to events_path
	
  end
end