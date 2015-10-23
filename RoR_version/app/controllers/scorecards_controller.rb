class ScorecardsController < ApplicationController
  
  def index
    @scorecards= Scorecard.all
  end

  def create
    @fight = Fight.find_by(:id => params[:fight_id])
    scorecard = @fight.scorecard
    if params[:url].length > 0
      scorecard.pic = params[:url]
    end
    scorecard.save

    judgescore = Judgescore.new
    judgescore.judge_id = params[:judge_1]
    judgescore.r1_1 = params[:j1_r1_1]
    judgescore.r2_1 = params[:j1_r2_1]
    judgescore.r3_1 = params[:j1_r3_1]
    judgescore.r4_1 = params[:j1_r4_1]
    judgescore.r5_1 = params[:j1_r5_1]
    judgescore.r1_2 = params[:j1_r1_2]
    judgescore.r2_2 = params[:j1_r2_2]
    judgescore.r3_2 = params[:j1_r3_2]
    judgescore.r4_2 = params[:j1_r4_2]
    judgescore.r5_2 = params[:j1_r5_2]
    judgescore.t1 = params[:j1_t1]
    judgescore.t2 = params[:j1_t2]
    judgescore.save
    scorecard.j_1_score_id = judgescore.id
    
    judgescore = Judgescore.new
    judgescore.judge_id = params[:judge_2]
    judgescore.r1_1 = params[:j2_r1_1]
    judgescore.r2_1 = params[:j2_r2_1]
    judgescore.r3_1 = params[:j2_r3_1]
    judgescore.r4_1 = params[:j2_r4_1]
    judgescore.r5_1 = params[:j2_r5_1]
    judgescore.r1_2 = params[:j2_r1_2]
    judgescore.r2_2 = params[:j2_r2_2]
    judgescore.r3_2 = params[:j2_r3_2]
    judgescore.r4_2 = params[:j2_r4_2]
    judgescore.r5_2 = params[:j2_r5_2]
    judgescore.t1 = params[:j2_t1]
    judgescore.t2 = params[:j2_t2]
    judgescore.save
    scorecard.j_2_score_id = judgescore.id
    
    judgescore = Judgescore.new
    judgescore.judge_id = params[:judge_3]
    judgescore.r1_1 = params[:j3_r1_1]
    judgescore.r2_1 = params[:j3_r2_1]
    judgescore.r3_1 = params[:j3_r3_1]
    judgescore.r4_1 = params[:j3_r4_1]
    judgescore.r5_1 = params[:j3_r5_1]
    judgescore.r1_2 = params[:j3_r1_2]
    judgescore.r2_2 = params[:j3_r2_2]
    judgescore.r3_2 = params[:j3_r3_2]
    judgescore.r4_2 = params[:j3_r4_2]
    judgescore.r5_2 = params[:j3_r5_2]
    judgescore.t1 = params[:j3_t1]
    judgescore.t2 = params[:j3_t2]
    judgescore.save
    scorecard.j_3_score_id = judgescore.id
    
    if scorecard.save
      redirect_to root_url
    else
      render 'new'
    end
  end

  def show
    @scorecard = Scorecard.find_by(:id => params["id"])
  end
  
  def edit
    @scorecard = Scorecard.find_by(:id => params["id"])
    @fight = @scorecard.fight
  end

  def update
    scorecard = Scorecard.find_by(:id => params["id"])
    
    puts params[:url].length
    if params[:url].length > 0
      scorecard.pic = params[:url]
    end
    scorecard.save

    judgescore = Judgescore.find_by(:id => scorecard.j_1_score_id)
    judgescore.judge_id = params[:judge_1]
    judgescore.r1_1 = params[:j1_r1_1]
    judgescore.r2_1 = params[:j1_r2_1]
    judgescore.r3_1 = params[:j1_r3_1]
    judgescore.r4_1 = params[:j1_r4_1]
    judgescore.r5_1 = params[:j1_r5_1]
    judgescore.r1_2 = params[:j1_r1_2]
    judgescore.r2_2 = params[:j1_r2_2]
    judgescore.r3_2 = params[:j1_r3_2]
    judgescore.r4_2 = params[:j1_r4_2]
    judgescore.r5_2 = params[:j1_r5_2]
    judgescore.t1 = params[:j1_t1]
    judgescore.t2 = params[:j1_t2]
    judgescore.save
    
    judgescore = Judgescore.find_by(:id => scorecard.j_2_score_id)
    judgescore.judge_id = params[:judge_2]
    judgescore.r1_1 = params[:j2_r1_1]
    judgescore.r2_1 = params[:j2_r2_1]
    judgescore.r3_1 = params[:j2_r3_1]
    judgescore.r4_1 = params[:j2_r4_1]
    judgescore.r5_1 = params[:j2_r5_1]
    judgescore.r1_2 = params[:j2_r1_2]
    judgescore.r2_2 = params[:j2_r2_2]
    judgescore.r3_2 = params[:j2_r3_2]
    judgescore.r4_2 = params[:j2_r4_2]
    judgescore.r5_2 = params[:j2_r5_2]
    judgescore.t1 = params[:j2_t1]
    judgescore.t2 = params[:j2_t2]
    judgescore.save
    
    judgescore = Judgescore.find_by(:id => scorecard.j_3_score_id)
    judgescore.judge_id = params[:judge_3]
    judgescore.r1_1 = params[:j3_r1_1]
    judgescore.r2_1 = params[:j3_r2_1]
    judgescore.r3_1 = params[:j3_r3_1]
    judgescore.r4_1 = params[:j3_r4_1]
    judgescore.r5_1 = params[:j3_r5_1]
    judgescore.r1_2 = params[:j3_r1_2]
    judgescore.r2_2 = params[:j3_r2_2]
    judgescore.r3_2 = params[:j3_r3_2]
    judgescore.r4_2 = params[:j3_r4_2]
    judgescore.r5_2 = params[:j3_r5_2]
    judgescore.t1 = params[:j3_t1]
    judgescore.t2 = params[:j3_t2]
    judgescore.save
  
    scorecard.save
    redirect_to "/scorecards/#{scorecard.id}"
  end

  def destroy
    scorecard = Scorecard.find_by(:id => params["id"])
    js = Array.new(3)
    js[0]= scorecard.score_1
    js[1]= scorecard.score_2
    js[2]= scorecard.score_3
    
    js.each do |j|  
      j.judge_id = nil
      j.r1_1 = nil
      j.r2_1 = nil
      j.r3_1 = nil
      j.r4_1 = nil
      j.r5_1 = nil
      j.r1_2 = nil
      j.r2_2 = nil
      j.r3_2 = nil
      j.r4_2 = nil
      j.r5_2 = nil
      j.t1 = nil
      j.t2 = nil
      j.save
    end
    
    scorecard.pic = nil
    scorecard.save
    redirect_to "/scorecards/#{params["id"]}"
  end
  
  def new
    @scorecard = Scorecard.new
    @fight = @scorecard.fight
  end

end
