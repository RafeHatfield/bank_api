# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html

Account.create(card_number: '1', pin: '1111', balance: 10000)
Account.create(card_number: '2', pin: '1111', balance: 10000)
Account.create(card_number: '3', pin: '1111', balance: 10000)
Account.create(card_number: '4', pin: '1111', balance: 10000)
Account.create(card_number: '5', pin: '1111', balance: 0)
puts 'card numbers 1, 2, 3, 4, 5 all created with pin 1111'
