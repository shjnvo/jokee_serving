class JokesController < ApplicationController
  before_action :set_joke, only: %i[like dislike]

  def index
    cookies[:joked] ||= { ids: [] }.to_json
    @joke = Joke.exclude_joke(JSON.parse(cookies[:joked])['ids']).first(10).sample
  end

  def like
    increment_counter!(:likes_count)

    redirect_to root_path
  end

  def dislike
    increment_counter!(:dislikes_count)

    redirect_to root_path
  end

  private

  def set_joke
    @joke = Joke.find(params[:id])
  end

  def increment_counter!(col_name)
    @joke.increment!(col_name)
    hash = JSON.parse(cookies[:joked])
    hash['ids'] << @joke.id
    cookies[:joked] = hash.to_json
  end
end
