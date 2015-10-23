class Judgescore < ActiveRecord::Base
  belongs_to :judge, class_name: "Judge"#, foreign_key: :judge_id, primary_key: :id

  has_one :j1scorecard, class_name: "Scorecard", foreign_key: :j_1_score_id, primary_key: :id
  has_one :j2scorecard, class_name: "Scorecard", foreign_key: :j_2_score_id, primary_key: :id
  has_one :j3scorecard, class_name: "Scorecard", foreign_key: :j_3_score_id, primary_key: :id

  def scorecard
    if self.j1scorecard
      return self.j1scorecard
    elsif self.j2scorecard
      return self.j2scorecard
    elsif self.j3scorecard
      return self.j3scorecard
    end
  end

  def winner
    if self.t1 > self.t2
      return self.scorecard.fighter_1.name
    elsif self.t2>self.t1
      return self.scorecard.fighter_2.name
    else
      return "draw"
    end
  end


end
