require "test_helper"

class JokesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get jokes_url
    assert_response :success
  end

  test "should don't show joked content" do
    cookies[:joked] = { ids: Joke.order(id: :desc).pluck(:id).first }.to_json

    get jokes_url
    assert_response :success
    assert_select 'p#joke-content', text: "Content 2"
  end

  test "should show the messge for all jokes for today" do
    cookies[:joked] = { ids: Joke.pluck(:id) }.to_json

    get jokes_url
    assert_response :success
    assert_select 'p#joke-content', text: "That's all the jokes for today! Come back another day!"
  end

  test "should like the joke" do
    joke = Joke.first
    get jokes_url
    assert_response :success

    patch like_joke_path(joke)
    assert_response :redirect

    assert_equal(cookies[:joked].present?, true)
    assert_equal(joke.reload.likes_count, 2)
  end

  test "should dislike the joke" do
    joke = Joke.first
    get jokes_url
    assert_response :success

    patch dislike_joke_path(joke)
    assert_response :redirect
    assert_equal(cookies[:joked].present?, true)
    assert_equal(joke.reload.dislikes_count, 2)
  end
end
