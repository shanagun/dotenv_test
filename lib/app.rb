 # ligne très importante qui appelle la gem.
 require 'twitter'
 require 'dotenv'
Dotenv.load

 # n'oublie pas les lignes pour Dotenv ici…
 
 # quelques lignes qui appellent les clés d'API de ton fichier .env
def stream_client
 client = Twitter::Streaming::Client.new do |config|
   config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
   config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
   config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
   config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
 end
end

def client
  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
    config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
    config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
    config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
  end
 end
 
 # ligne qui permet de tweeter sur ton compte
 def say_hello(client)
  list_artists = ["@donaldglover", "@kidcudi", "@playboicarti", "@trvisxx", "@gucci1017", "@postmalone", "@nickiminaj", "@tylerthecreator", "@iamcardib", "@kendricklamar", "@drake", "@jcolenc", "@kanyewest", "@asvpxrocky", "@theweeknd", "@brysontiller", "@meekmill", "@treysongz", "@migos", "@offsetyrn", "@quavostuntin", "@chrisbrown", "@virgilabloh", "@wizkidayo", "@majidjordan"]
  5.times do
    random_artists = list_artists[rand(list_artists.length)]
    client.update("#{random_artists} su-per ! #bonjour_monde")
 end
end

def favorite(client)
  client.search("#bonjour_monde", result_type:"recent").take(25).collect do |tweet| 
  client.fav tweet
 end
end

def follow(client)
  client.search("#bonjour_monde", result_type:"recent").take(25).collect do |tweet|
  return tweet.user.screen_name
  client.follow tweet.user.screen_name
 end
end

def stream(stream_client, client)
    stream_client.filter(track: "#bonjour_monde") do |object|
    puts object.text if object.is_a?(Twitter::Tweet)
    client.fav object
    client.follow object.user.screen_name
  end
end
stream(stream_client, client)