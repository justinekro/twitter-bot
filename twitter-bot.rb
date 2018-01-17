require 'pry'
require 'twitter'
require 'dotenv'
Dotenv.load

$client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['TWITTER_API_KEY']
  config.consumer_secret     = ENV['TWITTER_API_SECRET']
  config.access_token        = ENV['TWITTER_TOKEN']
  config.access_token_secret = ENV['TWITTER_TOKEN_SECRET']
end

# Je change le nom de la variable sinon mon code bugue

$client2 = Twitter::Streaming::Client.new do |config|
  config.consumer_key        = ENV['TWITTER_API_KEY']
  config.consumer_secret     = ENV['TWITTER_API_SECRET']
  config.access_token        = ENV['TWITTER_TOKEN']
  config.access_token_secret = ENV['TWITTER_TOKEN_SECRET']
end

# Bot qui tweete Bonjour Monde

def tweet(tweet)
  $client.update(tweet)
end

#tweet("Bonjour Monde")

# Bot qui follow Louis

def follow(person)
  $client.follow(person)
end

#follow("GabLaff")


# Méthode qui récupère les noms dans un array, les mentionne et les tweete

def mention_people(people) 
  people.each do |message|
    message = 'Salut les copains ! ' + message
    $client.update(message)
    end
end

#mention_people(["@Justikro","@ThpTest","@thpnico","@Fabien_971"])


# Méthode qui prend récupère les topics demandé par l'utilisateur et affiche les tweet concernés

def stream_tweets(topics)
  $client2.filter(track: topics.join(",")) do |object|
  puts object.text if object.is_a?(Twitter::Tweet)
  end
end 

# stream_tweets(["love"])


# Pour un array d'utilisateurs donnés, on récupère une liste des 20 derniers tweets que l'on stock dans un array
# Puis on applique la fonction .favorite pour liker les tweets de chacun des utilisateurs

def like_tweets(person)
  person.each do |tweets|
    tweets = $client.user_timeline(person)
    tweets.each do |tweet|
    $client.favorite(tweet)
    end
  end
end

# like_tweets(["@ThpTest", "@Fabien_971", "@thpnico"])


