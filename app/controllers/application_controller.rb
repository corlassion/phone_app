class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  helper_method :current_user
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def youve_got_mail()
    Mail.defaults do
        retriever_method :pop3, :address    => "pop.gmail.com",
                                :port       => 995,
                                :user_name  => 'capstone.sp.15@gmail.com',
                                :password   => 'student15',         #plaintext password, possible security concern?
                                :enable_ssl => true
    end
    emails = Mail.all
    #binding.pry
    emails.each do |email|
      @message = email.body.decoded.partition("\n")[0]
      #binding.pry
      @code_id = @message[0..2].to_i
      if Code.find_by_id(@code_id) == nil
        @message = email.body.decoded.partition("\n\n")[2].partition("\n")[0]
        @code_id = @message[0..2].to_i
        #binding.pry
        if Code.find_by_id(@code_id) == nil
          next
        end
      end
      @message_count = @message[3..@message.length].to_i
      @user = User.find_by_phone_num(email.from.first[0..9])
      if @user == nil
        next
      else
        @user_id = @user.id
      end
      
      begin
      	Message.create :user_id => @user_id, :code_id => @code_id, :message_count => @message_count, :message => @message
      rescue
      end
    end
  end

  def daily_dose_of_data()
    @start_time = (Date.today).to_s(:db)
    @end_time = (Date.today + 2).to_s(:db)
    @daily_gospel = 0
    @daily_converts = 0
    @daily_baptisms = 0
    @daily_church_plants = 0
    cmd = "SELECT * FROM daily_data(\'#{@start_time}\', \'#{@end_time}\')"
    temp_results = ActiveRecord::Base.connection.exec_query(cmd)
    #binding.pry
    temp_results.each do |daily_message_temp|
      daily_message = DailyMessage.new( daily_message_temp["code_id"],
                      daily_message_temp["message_count"]                     
                      )
      case daily_message.code_id.to_i
        when 101
          @daily_gospel = @daily_gospel + daily_message.message_count.to_i
        when 201
          @daily_converts = @daily_converts + daily_message.message_count.to_i
        when 301
          @daily_baptisms = @daily_baptisms + daily_message.message_count.to_i
        when 401
          @daily_church_plants = @daily_church_plants + daily_message.message_count.to_i
      end
    end
    #binding.pry

  end

end
