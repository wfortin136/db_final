class FightsController < ApplicationController

  before_action :find_fight, only: [:show, :update, :edit, :destroy]

  def find_fight
    @fight = Fight.find_by(:id => params["id"])
  end

  def index
  
    if params["keyword"].present?
      term = params["keyword"].strip
      #For now, find the first instance of the term. Then return
      #and list all fights from that fighter. Will expand to show
      #each similar fighter and their list of fights. 
      @fighter = Fighter.where("name LIKE ?", "%#{term}%").first
      if @fighter
        @fights = @fighter.fights
      else
        @doesnotexist = term
        @fights = []
      end
    else
      @fights = Fight.all
    end

    @fights = @fights.page(params[:page]).per(2)
  end

  def create
    @fight = Fight.new
    scorecard = Scorecard.new
    scorecard.fighter_1_id = params[:fighter1_id]
    scorecard.fighter_2_id = params[:fighter2_id]
    scorecard.save
    
    judgescore1 = Judgescore.new
    judgescore2 = Judgescore.new
    judgescore3 = Judgescore.new
    judgescore1.save
    judgescore2.save
    judgescore3.save
    scorecard.j_1_score_id = judgescore1.id
    scorecard.j_2_score_id = judgescore2.id
    scorecard.j_3_score_id = judgescore3.id
    puts scorecard.id

    @fight.scorecard_id = scorecard.id
    @fight.fightcard_id = params[:fightcard_id]
    @fight.fight_num = params[:fight_num]
    @fight.card_level= params[:card_level]
    @fight.weightclass_id= params[:weightclass]
    @fight.method = params[:method]
    @fight.fighttime_db(params[:round].to_i, params[:min].to_i, params[:sec].to_i)
    scorecard.save

    if @fight.save
      redirect_to root_url
    else
      render 'new'
    end
  end

  def show
  end
  
  def edit
    @fightcard = @fight.fightcard
  end

  def update
    @fight.fightcard_id = params[:fightcard_id]
    scorecard= Scorecard.find_by(:id =>@fight.scorecard_id)
    scorecard.fighter_1_id = params[:fighter1_id]
    scorecard.fighter_2_id = params[:fighter2_id]
    @fight.fight_num = params[:fight_num]
    @fight.card_level= params[:card_level]
    @fight.weightclass_id= params[:weightclass]
    @fight.method = params[:method]
  
    scorecard.save
    @fight.save
    redirect_to root_url
  end

  def destroy
    scorecard = @fight.scorecard
    @fight.score_1.delete
    @fight.score_2.delete
    @fight.score_3.delete

    @fight.scorecard.delete
    @fight.delete
    redirect_to root_url
  end
  
  def new
    @fight = Fight.new
  end

end
