class FightcardsController < ApplicationController
  
  def index
    @fightcards = Fightcard.all
  end

  def create
    @fightcard = Fightcard.new
    
    @fightcard.name = params[:name]
    @fightcard.promotion = params[:promotion]
    @fightcard.city = params[:city]
    @fightcard.state = params[:state]
    @fightcard.country = params[:country]
    @fightcard.date = params[:fc][:date]

    if @fightcard.save
      redirect_to "/fightcards"
    else
      render 'new'
    end
  end

  def show
    @fightcard = Fightcard.find_by(:id => params["id"])
  end
  
  def edit
    @fightcard = Fightcard.find_by(:id => params["id"])
  end

  def update
    fightcard = Fightcard.find_by(:id => params["id"])
    fightcard.name = params[:name]
    fightcard.promotion = params[:promotion]
    fightcard.city = params[:city]
    fightcard.state = params[:state]
    fightcard.country = params[:country]
    fightcard.date = params[:fc][:date]
    
    fightcard.save
    redirect_to "/fightcards"
  end

  def destroy
    fightcard = Fightcard.find_by(:id => params["id"])
    fightcard.clearfights
    fightcard.delete
    redirect_to "/fightcards"
  end
  
  def new
    @fightcard = Fightcard.new
  end

end
