class AccountsController < ApplicationController

	def index
		@start_time = 2015-02-07
		@end_time = Date.today.to_s(:db)
		@items_count = 5
		@user_type = UserType.all
		youve_got_mail()
		daily_dose_of_data()
		unless current_user
			redirect_to "/sessions"
		end

	end

	def create
		daily_dose_of_data()
		if current_user.user_type_id == 999 || current_user.user_type_id == 111
			begin
				if params[:uname] == '' || params[:upass] == '' || params[:uemail] == ''
					render "failure"
				else
					@salt = Array.new(16){[*"A".."Z", *"0".."9", *"a".."z"].sample}.join
					@passhash = Digest::SHA1.hexdigest @salt + params[:upass]
					#binding.pry
					User.create :username => params[:uname], :user_type_id => UserType.find_by_user_type(params[:utype]).user_type, :location_id => 1, :email => params[:uemail], :phone_num => params[:uphone], :salt => @salt, :passhash => @passhash

				end
			rescue
				render "failure"
			end
		else
			render "failure"
		end
	end

end