class Scorecard < ActiveRecord::Base
  
  has_one :fight, class_name: "Fight", foreign_key: :scorecard_id, primary_key: :id
  
  belongs_to :fighter_1, class_name: "Fighter"#, foreign_key: :fighter_1_id, primary_key: :id
  belongs_to :fighter_2, class_name: "Fighter"#, foreign_key: :fighter_1_id, primary_key: :id
  
  belongs_to :score_1, class_name: "Judgescore", foreign_key: :j_1_score_id, primary_key: :id
  belongs_to :score_2, class_name: "Judgescore", foreign_key: :j_2_score_id, primary_key: :id
  belongs_to :score_3, class_name: "Judgescore", foreign_key: :j_3_score_id, primary_key: :id

  #has_one :judge_1, class_name: "Judge", foreign_key: :id, primary_key: :judge_id, through: :score_1
  #belongs_to :judge_2, class_name: "Judge", foreign_key: :id, primary_key: :judge_id, through: :score_2
  #belongs_to :judge_3, class_name: "Judge", foreign_key: :id, primary_key: :judge_id, through: :score_3
  
  validates :fighter_1_id, presence: { message: "2 Fighters are needed"}
  validates :fighter_2_id, presence: { message: "2 Fighters are Needed"}

  def judge_1
    if self.score_1
      return self.score_1.judge
    else
      return nil
    end
  end 

  def judge_2
    if self.score_2
      return self.score_2.judge
    else
      return nil
    end
  end
  
  def judge_3
    if self.score_3
      return self.score_3.judge
    else
      return nil
    end
  end
end
