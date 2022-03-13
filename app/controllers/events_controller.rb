class EventsController < ApplicationController
  def new
    slack_post = SlackPost.find(params[:slack_post_id])
    redirect_to slack_posts_path unless slack_post

    @event = slack_post.build_event
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
