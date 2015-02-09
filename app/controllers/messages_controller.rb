class MessagesController < ApplicationController

	def index
		@start_time = 2015-02-07
		@end_time = Date.today.to_s(:db)
		@items_count = 5
	end

	def create
		@view_messages = []
		build_array()
		#binding.pry
		if !@view_messages.any?
			render "norecord"
		end
	end

	def build_array()
		@view_messages = []
		@start_time = Date.new(2015,02,07)
		@end_time = (Date.today + 1).to_s(:db)
		@items_count = 10
		cmd = "SELECT * FROM view_messages(\'#{@start_time}\', \'#{@end_time}\', \' #{@items_count}\')" 
		temp_results = ActiveRecord::Base.connection.execute(cmd)
		#binding.pry
		temp_results.each do |view_message_temp|
			view_message = ViewMessage.new( view_message_temp["code_id"],
											view_message_temp["message_id"],
											view_message_temp["message"],
											view_message_temp["username"],
											view_message_temp["usertype"],
											view_message_temp["user_id"],
											view_message_temp["location_name"],
											view_message_temp["code_type"],
											view_message_temp["code_action"],
											view_message_temp["message_created_at"],
											)
			#if view_message.username == "SMichal"
				@view_messages << view_message
			#end
			#binding.pry
		end
	end



end