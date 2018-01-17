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

# tweet("Bonjour Monde")

# Bot qui follow un array de personnes

def follow(person)
  person.each do |person|
  $client.follow(person)
  end
end

#follow(["@Justikro","@ThpTest","@thpnico","@Fabien_971"])


# Méthode qui récupère les noms dans un array, les mentionne et les tweete

def mention_people(people) 
  people.each do |user|
    message = 'Salut les copains ! ' + user
    $client.update(message)
    end
end

# mention_people(["@Justikro","@ThpTest","@thpnico","@Fabien_971"])


# Méthode qui récupère les topics demandé par l'utilisateur et affiche les tweet concernés

def stream_tweets(topics)
  $client2.filter(track: topics.join(",")) do |object|
  puts object.text if object.is_a?(Twitter::Tweet)
  end
end 

# stream_tweets(["love"])

# Méthode qui like les derniers tweets d'une liste de personne

def like_tweets(person)

# Pour un array d'utilisateurs donnés, on récupère une liste des 20 derniers tweets que l'on stock dans un array	
  person.each do |tweets|
    tweets = $client.user_timeline(tweets)
# Puis on applique la fonction .favorite pour liker les tweets de chacun des utilisateurs

    tweets.each do |tweet|
    $client.favorite(tweet)
    end
  end
end

# like_tweets(["@realDonaldTrump"])

# En théorie, répond aux tweets des personnes rentrées par l'utilisateur


def answer_tweets(person)
    
    person.each do |person|    
      tweets = $client.user_timeline(person)

      tweets.each do |tweet|
        message = person + " Merci pour ce super tweet"
        $client.update(message, in_reply_to_status_id: tweet)


        end
    end 
end


# answer_tweets(["@Fabien_971"])



