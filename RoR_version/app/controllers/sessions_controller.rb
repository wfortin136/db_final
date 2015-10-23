class SessionsController < ApplicationController

  def new

  end

  def destroy
    # sessions[:user_id] = nil
    reset_session
    redirect_to root_url, notice: "PACE!"
  end
  def create
    user = User.find_by_email(params["email"])

    if user
      if user.authenticate(params["password"])
        session[:user_id] = user.id
        flash[:notice] = "Time to score again, #{user.name}!"
        redirect_to root_url
      else
        render 'new'
      end
    else
      render 'new'
    end

  end
end
