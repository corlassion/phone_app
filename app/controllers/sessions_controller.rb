class SessionsController < ApplicationController

  def index
    @start_time = 2015-02-07
    @end_time = Date.today.to_s(:db)
    youve_got_mail()
    daily_dose_of_data()
    if current_user
      redirect_to "/users"
    end
  end

  def login
    #binding.pry
    @temp_user = User.find_by_email(params[:email])
    if (@temp_user) && can_login?
      #binding.pry
      if ((Digest::SHA1.hexdigest User.find_by_email(params[:email]).salt + params[:password]) == @temp_user.passhash)
        current_user = @temp_user
        session[:user_id] = @temp_user.id
        redirect_to "/users"
        #binding.pry
        params[:password] = nil
      else
        params[:password] = nil
        params[:email] = nil
        @temp_user = nil
        #binding.pry
        redirect_to "/"
      end
    else
      params[:password] = nil
      params[:email] = nil
      @temp_user = nil
      #binding.pry
      redirect_to "/"
    end
  end

  def logout
    #binding.pry
    flash[:success] = "You have successfully logged out."
    current_user = nil
    session[:user_id] = nil
    redirect_to '/'
  end

  private
  def can_login?
    #binding.pry
    @temp_user.user_type_id == 111 || @temp_user.user_type_id == 999
  end




end