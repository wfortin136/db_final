class Fightcard < ActiveRecord::Base

  has_many :fights, class_name: "Fight"#, foreign_key: :fightcard_id
  has_many :weightclasses, through: :fights
  validates :name, presence: true, uniqueness: true

  def headliner
    
    f1 = Fight.where(fightcard_id: self.id).find_by(fight_num: 1)
    f2 = f1 
    if f1
      f1 = f1.fighter_1.name
    end

    if f2
      f2 = f2.fighter_2.name
    end

  return "#{f1} vs. #{f2}"
  end

  def clearfights
    self.fights.all.each do |f|
      f.fightcard_id = nil
      f.fight_num = nil
      f.card_level = nil
      f.save
    end
  end
end
