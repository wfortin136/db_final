class JudgesController < ApplicationController
  
  def index
    @judges = Judge.all
    @user = User.find_by(:id => session[:user_id]) 
    if @user
      @useradmin = @user.admin
    else
      @useradmin = nil
    end
  end

  def create
    @judge = Judge.new
    
    @judge.name = params[:name]

    if @judge.save
      redirect_to '/judges'
    else
      render 'new'
    end
  end

  def show
    @judge = Judge.find_by(:id => params["id"])
  end
  
  def edit
    @judge = Judge.find_by(:id => params["id"])
  end

  def update
    judge = Judge.find_by(:id => params["id"])
    
    judge.name = params[:name]
    judge.save
    
    redirect_to "/judges/#{params["id"]}"
  end

  def destroy
    judge= Judge.find_by(:id => params["id"])
    judge.delete
    redirect_to "/judges"
  end
  
  def new
    @judge = Judge.new
  end

end
