class EventsController < ApplicationController
  def index
    # @events = Event.all
    # @host = 

    @in_state_events = Event.eager_load(:user, :users_joined).where(state: current_user.state)
		@out_state_events = Event.eager_load(:user, :users_joined).where.not(state: current_user.state)
    
  end
end
