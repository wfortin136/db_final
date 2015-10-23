class Fighter < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true
  
  has_many :fights_1, class_name: "Scorecard", foreign_key: "fighter_1_id"
  has_many :fights_2, class_name: "Scorecard", foreign_key: "fighter_2_id"

  #Get a list of fights for each fighter. Needed to do an or sql clause because I was
  #find it too difficult and convoluted to combine the fights_1 and fights_2 from above.
  #Once I get the IDs of all fights where the fighter is either the first or second fighter
  #I use a join with a where to get a list of all the fights. 
  def fights
    #self.fights_1
    #self.fights_2
    scs = Scorecard.where("fighter_1_id = ? or fighter_2_id = ?", self.id, self.id).select("id")
    return Fight.joins(:scorecard).where(scorecard_id: scs.all)

  end
  
  def self.fighter_id(a)
    return self.connection.execute("
          select * from fighters
          where id = "+a[0].to_s+"
          limit 1")
  end

  def self.list
    return self.connection.execute("
          select *
          from fighters")
  end

  def self.fname(a)
    return a[1]
  end
end
