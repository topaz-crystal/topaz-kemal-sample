require "kemal"
require "./models/*"

class WebServer

  def initialize(@port = 3000)
  end
  
  def self.render_tweets
    tweets = Tweet.select.reverse
    render "src/views/index.ecr", "src/views/layout.ecr"
  end

  get "/" do
    render_tweets
  end

  get "/jsons/:id" do |env|
    env.response.content_type = "application/json"
    tweet = Tweet.find(env.params.url["id"])
    tweet.json
  end

  post "/" do |env|
    Tweet.create(env.params.body["tweet"], 0.to_i64)
    render_tweets
  end
  
  put "/" do |env|
    case env.params.body["action"]
    when "delete"
      Tweet.find(env.params.body["id"]).delete
    when "like"
      t = Tweet.find(env.params.body["id"])
      t.likes = t.likes + 1.to_i64
      t.update
    end
    render_tweets
  end
  
  def run
    Kemal.run(@port)
  end
end

Topaz::Log.debug_mode(false)
Topaz::Log.show_query(true)

Topaz::Db.setup("sqlite3://./db/sample.db")

server = WebServer.new
server.run
