class UsersController < ApplicationController

	def index
		youve_got_mail()
		daily_dose_of_data()
		unless current_user
			redirect_to "/sessions"
		end
		if params[:uname]
			params[:id] = User.find_by_username(params[:uname]).id
			redirect_to user_path(params[:id])
		else
			@users = User.all
		end
	end

	

	def show
		daily_dose_of_data()
		@uname = User.find_by_id(params[:id]).username
		if !User.find_by_username(@uname)
			render "norecord"
		else
			@view_messages = []
			build_array()
			if !@view_messages.any?
				render "norecord"
			else
				@gospel = 0
				@converts = 0
				@baptisms = 0
				@church_plants = 0
				@view_messages.each do |view_message|
				case view_message.code_id.to_i
					when 101
						@gospel = @gospel + view_message.message_count.to_i
					when 201
						@converts = @converts + view_message.message_count.to_i
					when 301
						@baptisms = @baptisms + view_message.message_count.to_i
					when 401
						@church_plants = @church_plants + view_message.message_count.to_i
					end
				end
			end
		end
	end

	def build_array()
		@view_messages = []
		@start_time = Date.new(2015,02,07)
		@end_time = (Date.today + 2).to_s(:db)
		@user_id = User.find_by_username(@uname).id
		cmd = "SELECT * FROM view_users(\'#{@start_time}\', \'#{@end_time}\', #{@user_id})" 
		temp_results = ActiveRecord::Base.connection.exec_query(cmd)
		temp_results.each do |view_message_temp|
			view_message = ViewMessage.new( view_message_temp["code_id"],
											view_message_temp["message_id"],
											view_message_temp["message"],
											view_message_temp["message_count"],
											view_message_temp["username"],
											view_message_temp["usertype"],
											view_message_temp["user_id"],
											view_message_temp["location_name"],
											view_message_temp["code_type"],
											view_message_temp["code_action"],
											view_message_temp["message_created_at"],
											)
			
			@view_messages << view_message
		end
	end

end