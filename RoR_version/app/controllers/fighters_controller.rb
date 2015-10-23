class FightersController < ApplicationController
  
  def index
    @fighters = Fighter.list
    @user = User.find_by(:id => session[:users_id]) 
    @user = nil
    if @user
      @useradmin = @user.admin
    else
      @useradmin = nil
    end
  end

  def create
    @fighter = Fighter.new
    
    @fighter.name = params[:name]
    @fighter.wins= params[:wins]
    @fighter.losses= params[:losses]
    @fighter.draws = params[:draws]
    @fighter.nc = params[:nc]
    @fighter.picture= params[:picture]

    if @fighter.save
      redirect_to '/fighters'
    else
      render 'new'
    end
  end

  def show
    @fighter = Fighter.find_by(:fighter_id => params["id"])
  end
  
  def edit
    @fighter = Fighter.find_by(:id => params["id"])
  end

  def update
    fighter = Fighter.find_by(:id => params["id"])
    
    fighter.name = params[:name]
    fighter.wins= params[:wins]
    fighter.losses= params[:losses]
    fighter.draws = params[:draws]
    fighter.nc = params[:nc]
    fighter.picture= params[:picture]
    fighter.save
    
    redirect_to "/fighters/#{params["id"]}"
  end

  def destroy
    fighter = Fighter.find_by(:id => params["id"])
    fighter.delete
    redirect_to "/fighters"
  end
  
  def new
    @fighter = Fighter.new
  end

end
