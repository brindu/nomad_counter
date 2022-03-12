class EventsController < ApplicationController
  def new
    @event = Event.new
    @event.slack_post_id = params[:slack_post_id]
  end

  def create
    Event.create(create_params)

    redirect_to slack_posts_path
  end

  private

  def create_params
    params.require(:event)
      .permit(:title, :start_time, :end_time, :slack_post_id)
  end
end
