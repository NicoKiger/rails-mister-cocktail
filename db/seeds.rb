# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'json'
require 'faker'

Cocktail.destroy_all
Dose.destroy_all
Ingredient.destroy_all

15.times do
  url_cocktail = 'https://www.thecocktaildb.com/api/json/v1/1/random.php'
  data = JSON.parse(open(url_cocktail).string)['drinks']

  data_ingredients = data.first.select {|k, _| k.include? 'strIngredient'}
  p ingredients = data_ingredients.values.reject { |e| e.to_s.empty? }

  data_doses = data.first.select {|k, _| k.include? 'strMeasure'}
  p doses = data_doses.values.reject { |e| e.to_s.empty? }

  p data_name = data.first["strDrink"]

  cocktail1 = Cocktail.create(name: data_name)

  ingredients.each_with_index do |ingredient, index|
    i = Ingredient.create(name: ingredient)
    d = Dose.new(description: doses[index] || 'tbc')
    d.cocktail = cocktail1
    if i.id
      d.ingredient = i
      d.save!
    end
  end
end
