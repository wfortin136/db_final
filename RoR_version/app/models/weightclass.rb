class Weightclass < ActiveRecord::Base
  has_many :fights
  has_many :fightcards, through: :fights
end
