class AttendeesController < ApplicationController
  def create
    p "*" * 20
    p params[:id]
    Attendee.create(user: current_user, event: Event.find(params[:id]))
    p @attendee = Attendee.where(user: current_user)
    redirect_to "/events"

  end

  def destroy
  end
end
