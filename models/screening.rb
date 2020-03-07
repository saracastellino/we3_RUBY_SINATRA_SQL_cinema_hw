require_relative("../db/sql_runner")

class Screening

  attr_reader :id
  attr_accessor :film_id, :screening_time

  def initialize( screenings )
    @id = screenings['id'].to_i if screenings['id']
    @film_id = screenings['film_id'].to_i
    @screening_time = screenings['screening_time']
  end

  def save
    sql = "INSERT INTO screenings (film_id, screening_time) VALUES ($1, $2) RETURNING id"
    values = [@film_id, @screening_time]
    screening = SqlRunner.run(sql, values).first
    @id = screening['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM screenings"
    screenings = SqlRunner.run(sql)
    screenings.map {|screening| Screening.new(screenings)}
  end

  def update
    sql = "UPDATE screenings SET (film_id, screening_time) = ($1, $2) WHERE id = $3"
    values = [@film_id, @screening_time, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

  def self.delete(screening_time)
    sql = "DELETE FROM screenings WHERE id = $1"
    value = [screening_time]
    screenings_left = SqlRunner.run(sql, value)
    screenings_left.map {|screening| Screening.new(screenings_left)}
  end

  def tickets_sold
    sql = "SELECT * FROM tickets WHERE screening_id = $1"
    values = [@id]
    tickets_info = SqlRunner.run(sql, values)
    tickets_info.map {|ticket| Ticket.new(ticket)}
  end

  def number_of_tickets_sold
    tickets_per_screening = self.tickets_sold
    return tickets_per_screening.length
  end

end
