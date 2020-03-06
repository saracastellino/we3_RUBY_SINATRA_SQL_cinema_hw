require_relative("../db/sql_runner")

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize( tickets )
    @id = tickets['id'].to_i if tickets['id']
    @customer_id = tickets['customer_id'].to_i
    @film_id = tickets['film_id'].to_i
  end

  def save
    sql = "INSERT INTO tickets (customer_id, film_id) VALUES ($1, $2) RETURNING id"
    values = [@customer_id, @film_id]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM tickets"
    tickets = SqlRunner.run(sql)
    tickets.map {|ticket| Ticket.new(ticket)}
  end

  def update
    sql = "UPDATE tickets SET (customer_id, film_id) = ($1, $2) WHERE id = $3"
    values = [@custmer_id, @film_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def self.delete(id)
    sql = "DELETE FROM tickets WHERE id = $1"
    value = [id]
    tickets_left = SqlRunner.run(sql, value)
    tickets_left.map {|ticket| Ticket.new(tickets_left)}
  end

end
