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
