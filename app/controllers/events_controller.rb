class EventsController < ApplicationController
  def new
    slack_post = SlackPost.find(params[:slack_post_id])
    redirect_to slack_posts_path unless slack_post

    @event = slack_post.build_event
  end

  def create
    event = Event.new(create_params)

    if event.save
      redirect_to slack_posts_path
    end
  end

  private

  def create_params
    params.require(:event)
      .permit(:title, :start_time, :end_time, :slack_post_id)
  end
end
