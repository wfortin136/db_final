class Judge < ActiveRecord::Base
  has_many :judgescores, class_name: "Judgescore", foreign_key: :judge_id
  
  validates :name, presence: true, uniqueness: true
  
  def fightcount
    self.judgescores.count
  end
end

