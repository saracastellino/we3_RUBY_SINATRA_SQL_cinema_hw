require('sinatra')
require('sinatra/contrib/all')
require('pg')
require_relative("db/sql_runner")

require_relative('models/film.rb')
also_reload('./models/*')

get '/films' do
 sql = "SELECT * FROM films"
 films = SqlRunner.run(sql)
 @film_list = films.map {|film| Film.new(film)}
 erb(:index)
end

get '/film1' do
  sql = "SELECT * FROM films WHERE id = $1"
  values = [@id]
  film = SqlRunner.run(sql, values)[0]
  film_hash = film[0]
  found_film = Album.new(film_hash)
  return found_film
  erb(:film1)
end

get '/film2' do
  sql = "SELECT * FROM films WHERE id = $1"
  values = [@id]
  film = SqlRunner.run(sql, values)[0]
  film_hash = film[1]
  found_film = Album.new(film_hash)
  return found_film
  erb(:film2)
end
