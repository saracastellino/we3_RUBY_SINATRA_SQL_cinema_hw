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

  def self.find(id)
    sql = "SELECT * FROM films WHERE id = $1"
    values = [@id]
    film = SqlRunner.run(sql, values)[0]
    film_hash = film[0]
    found_film = Album.new(film_hash)
    return found_film
  end

  def customers
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE film_id = $1"
    value = [@id]
    customers = SqlRunner.run(sql, value)
    return customers.map {|customer| Customer.new(customer)}
  end

  def number_of_customers
    customers_per_film = self.customers
    return customers_per_film.length
  end

  def tickets_sold
    sql = "SELECT * FROM tickets WHERE film_id = $1"
    values = [@id]
    tickets_sold = SqlRunner.run(sql, values)
    tickets_sold.map {|ticket| Ticket.new(ticket)}
  end

  def screenings
    sql = "SELECT * FROM screenings WHERE film_id = $1"
    value = [@id]
    screenings = SqlRunner.run(sql, value)
    return screenings.map {|screening| Screening.new(screening)}
  end
 # for each film get the tickets sold for each screeining and p the screening with more tickets sold
  def most_tickets_sold
    sql = "SELECT Count(*) AS Distinct screening_id
FROM tickets"
#     "SELECT
#     film_id,
#     screening_id,
#     ROW_NUMBER() OVER (PARTITION BY film_id ORDER BY screening_id) AS frequency
# FROM
#     tickets
# ORDER BY
#     COUNT(*) OVER (PARTITION BY film_id) DESC,
#     film_id,
#     frequency DESC "

    # "select distinct on (film_id) film_id, most_frequent_value from (
    #   SELECT film_id, screening_id AS most_frequent_value, count(*) as _count
    #   FROM tickets
    #   GROUP BY film_id, screening_id) a
    #   ORDER BY screeing_id, _count DESC LIMIT 1"
    # sql = "SELECT screening_id, COUNT(screening_id) AS value_occurrence FROM tickets GROUP BY screening_id ORDER BY value_occurrence DESC LIMIT 1"
    best_screening_time = SqlRunner.run(sql)
    return best_screening_time.map {|ticket| Ticket.new(ticket)}
  end


end
