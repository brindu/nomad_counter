class SlackPostsController < ApplicationController
  def index
    @slack_posts = SlackPost.remaining
  end

  def discard
    slack_post = SlackPost.find(params[:id])

    if slack_post.update(discarded: true)
      redirect_to slack_posts_path
    end
  end
end
