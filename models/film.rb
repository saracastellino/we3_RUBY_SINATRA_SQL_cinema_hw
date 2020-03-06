require_relative("../db/sql_runner")

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize( films )
    @id = films['id'].to_i if films['id']
    @title = films['title']
    @price = films['price']
  end

  def save
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM films"
    films = SqlRunner.run(sql)
    films.map {|film| Film.new(film)}
  end

  def update
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def customers
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE film_id = $1"
    value = [@id]
    customers = SqlRunner.run(sql, value)
    return customers.map {|customer| Customer.new(customer)}
  end

  def number_of_customers
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE customer_id = $1"
    value = [@id]
    customers = SqlRunner.run(sql, value)
    customers_per_film = customers.map {|customer| Customer.new(customer)}
    return customers_per_film.length
  end

end
