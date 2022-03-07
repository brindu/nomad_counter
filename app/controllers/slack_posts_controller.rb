class SlackPostsController < ApplicationController
  def unpublished
    @slack_posts = SlackPost.unpublished
  end
end
