class AttendeesController < ApplicationController
  def create
    Attendee.create(user: current_user, event: Event.find(params[:id]))
    redirect_to "/events"
  end

  def destroy
    trash = Attendee.find_by(event_id: params[:id])
    trash.destroy
    redirect_to "/events"
  end
end
