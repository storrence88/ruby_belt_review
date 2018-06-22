class EventsController < ApplicationController
  def index
    @in_state_events = Event.all.where(state: current_user.state)
    @out_state_events = Event.all.where.not(state: current_user.state)
    # @in_state_events = Event.eager_load(:user, :users_joined).where(state: current_user.state)
		# @out_state_events = Event.eager_load(:user, :users_joined).where.not(state: current_user.state)
  end

  def create
    event = Event.create(event_params)
    
    if event.valid?
      event.user_id = current_user.id
      event.save
      redirect_to "/events"
    else
      flash[:errors] = event.errors.full_messages
      redirect_to :back
    end
  end
  
  def show
    @event = Event.find(params[:id])
    @comments = @event.comments
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    updated_event = Event.find(params[:id])
    updated_event.update(event_params)
    
    if updated_event.valid?
      redirect_to "/events"
    else
      flash[:errors] = updated_event.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    trash = Event.find(params[:id])
    trash.comments.destroy
    trash.destroy
    redirect_to "/events"
  end

  private
  def event_params
    params.require(:event).permit(:name, :date, :city, :state)
  end
end
