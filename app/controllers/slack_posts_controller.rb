class SlackPostsController < ApplicationController
  def index
    @slack_posts = SlackPost.remaining
  end
end
