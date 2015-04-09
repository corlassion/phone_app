class SessionsController < ApplicationController

  def index
    youve_got_mail()
    daily_dose_of_data()
    if current_user
      redirect_to "/users"
    end
  end

  def login
    @temp_user = User.find_by_email(params[:email])
    if (@temp_user)
      if ((Digest::SHA1.hexdigest User.find_by_email(params[:email]).salt + params[:password]) == @temp_user.passhash)
        current_user = @temp_user
        session[:user_id] = @temp_user.id
        params[:password] = nil
        params[:email] = nil
        redirect_to "/users"
      else
        params[:password] = nil
        params[:email] = nil
        @temp_user = nil
        redirect_to "/"
      end
    else
      params[:password] = nil
      params[:email] = nil
      @temp_user = nil
      redirect_to "/"
    end
  end

  def logout
    flash[:success] = "You have successfully logged out."
    current_user = nil
    session[:user_id] = nil
    redirect_to '/'
  end

end