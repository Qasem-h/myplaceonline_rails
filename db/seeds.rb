# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

order = Category.create(name: "order",link: "order", position: 0)
joy = Category.create(name: "joy", link: "joy", position: 1)
meaning = Category.create(name: "meaning", link: "meaning", position: 2)
passwords = Category.create(name: "passwords", link: "passwords", position: 0, parent: order)
movies = Category.create(name: "movies", link: "movies", position: 0, parent: joy)
wisdoms = Category.create(name: "wisdoms", link: "wisdoms", position: 0, parent: meaning)
to_dos = Category.create(name: "to_dos", link: "to_dos", position: 0, parent: order)
contacts = Category.create(name: "contacts", link: "contacts", position: 0, parent: order)
files = Category.create(name: "files", link: "files", position: 0, parent: order)
accomplishments = Category.create(name: "accomplishments", link: "accomplishments", position: 0, parent: meaning)
feeds = Category.create(name: "feeds", link: "feeds", position: 0, parent: order)
locations = Category.create(name: "locations", link: "locations", position: 0, parent: order)
activities = Category.create(name: "activities", link: "activities", position: 0, parent: joy)
apartments = Category.create(name: "apartments", link: "apartments", position: 0, parent: order)
jokes = Category.create(name: "jokes", link: "jokes", position: 0, parent: joy)
companies = Category.create(name: "companies", link: "companies", position: 0, parent: order)
promises = Category.create(name: "promises", link: "promises", position: 0, parent: order)
subscriptions = Category.create(name: "subscriptions", link: "subscriptions", position: 0, parent: order)
credit_scores = Category.create(name: "credit_scores", link: "credit_scores", position: 0, parent: order)
websites = Category.create(name: "websites", link: "websites", position: 0, parent: order)
credit_cards = Category.create(name: "credit_cards", link: "credit_cards", position: 0, parent: order)
bank_accounts = Category.create(name: "bank_accounts", link: "bank_accounts", position: 0, parent: order)
ideas = Category.create(name: "ideas", link: "ideas", position: 0, parent: order)
lists = Category.create(name: "lists", link: "lists", position: 0, parent: order)
calculation_forms = Category.create(name: "calculation_forms", link: "calculation_forms", position: 0, parent: order)
calculations = Category.create(name: "calculations", link: "calculations", position: 0, parent: order)
vehicles = Category.create(name: "vehicles", link: "vehicles", position: 0, parent: order)
questions = Category.create(name: "questions", link: "questions", position: 0, parent: meaning)
health = Category.create(name: "health", link: "health", position: 0, parent: order)
weights = Category.create(name: "weights", link: "weights", position: 0, parent: health)
blood_pressures = Category.create(name: "blood_pressures", link: "blood_pressures", position: 0, parent: health)
heart_rates = Category.create(name: "heart_rates", link: "heart_rates", position: 0, parent: health)
