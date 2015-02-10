class ViewMessage
	attr_accessor :code_id
	attr_accessor :message_id
	attr_accessor :message
	attr_accessor :message_count
	attr_accessor :username
	attr_accessor :usertype
	attr_accessor :user_id
	attr_accessor :location_name
	attr_accessor :code_type
	attr_accessor :code_action
	attr_accessor :message_created_at

	def initialize( code_id,
					message_id,
					message,
					message_count,
					username,
					usertype,
					user_id,
					location_name,
					code_type,
					code_action,
					message_created_at)
		@code_id = code_id
		@message_id = message_id
		@message = message
		@message_count = message_count
		@username = username
		@usertype = usertype
		@user_id = user_id
		@location_name = location_name
		@code_type = code_type
		@code_action = code_action
		@message_created_at = message_created_at

	end

end