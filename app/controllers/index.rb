get '/' do
  erb :welcome
end

get '/cash' do
  erb :cash, locals: { response: false }
end

post '/cash' do

  topic = params[:topic]
  topic_string= topic.split(" ").join("%20")

  base_url = 'http://api.lyricsnmusic.com/songs?api_key='
  search_url = "&q=johnny%20cash%20#{ topic_string }&callback=js_function"

  full_url = base_url + ENV['LYRICSNMUSIC_KEY'] + search_url
  raw_response = RestClient.get full_url

  shortened_response = raw_response.slice((raw_response.index('"data":')+7)..-3)
  parsed_songs = JSON.parse(shortened_response)

  @cash_songs = select_singer(parsed_songs, "Johnny Cash")

  remove_live_versions(@cash_songs)

  @songs = []

  narrow_to_topic(@cash_songs, topic)

  remove_duplicates(@songs)

  standardize_all_songs_lyrics(@songs)

  erb :'_cash_response', layout: false

end

get '/haggard' do
  erb :haggard
end

post '/haggard' do
  erb :haggard
end

get '/jones' do
  erb :jones
end

post '/jones' do
  erb :haggard
end

get '/api_request' do

end
