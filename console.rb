require_relative('models/ticket.rb')
require_relative('models/customer.rb')
require_relative('models/film.rb')
require_relative('models/screening.rb')

require('pry')

Customer.delete_all
Film.delete_all
Ticket.delete_all
Screening.delete_all

Customer.all
Film.all
Ticket.all
Screening.all


customer1 = Customer.new({'name' => 'Lucas', 'funds' => 50})
customer1.save
customer2 = Customer.new({'name' => 'Valeria', 'funds' => 40})
customer2.save
customer3 = Customer.new({'name' => 'Ruth', 'funds' => 20})
customer3.save

film1 = Film.new({'title' => 'Nausicaä', 'price' => 11})
film1.save
film2 = Film.new({'title' => 'Predator', 'price' => 11})
film2.save

screening1 = Screening.new({'film_id' => film1.id, 'screening_time' => '10.30'})
screening1.save
screening2 = Screening.new({'film_id' => film1.id, 'screening_time' => '15.30'})
screening2.save
screening3 = Screening.new({'film_id' => film2.id, 'screening_time' => '18.30'})
screening3.save
screening4 = Screening.new({'film_id' => film2.id, 'screening_time' => '20.30'})
screening4.save

ticket1 = Ticket.new({'customer_id' => customer2.id,'film_id' => film2.id, 'screening_id' => screening3.id})
ticket1.save
ticket2 = Ticket.new({'customer_id' => customer1.id,'film_id' => film2.id, 'screening_id' => screening4.id})
ticket2.save
ticket3 = Ticket.new({'customer_id' => customer3.id,'film_id' => film1.id, 'screening_id' => screening2.id})
ticket3.save
ticket4 = Ticket.new({'customer_id' => customer1.id,'film_id' => film2.id, 'screening_id' => screening3.id})
ticket4.save
ticket5 = Ticket.new({'customer_id' => customer2.id,'film_id' => film2.id, 'screening_id' => screening1.id})
ticket5.save
ticket6 = Ticket.new({'customer_id' => customer3.id,'film_id' => film1.id, 'screening_id' => screening3.id})
ticket6.save
ticket7 = Ticket.new({'customer_id' => customer2.id,'film_id' => film1.id, 'screening_id' => screening2.id})
ticket7.save


film2.title = "The Imaginarium of Dr Parnassus"
film2.update

customer1.funds = 30
customer1.update

ticket2.customer_id = customer3.id
ticket2.update
ticket2.film_id = film1.id
ticket2.update

Ticket.delete(37)
p customer1.funds_left


binding.pry
nil
