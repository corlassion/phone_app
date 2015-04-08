class DailyMessage
	attr_accessor :code_id
	attr_accessor :message_count
	

	def initialize( code_id,
					message_count
					)
		@code_id = code_id
		@message_count = message_count

	end

end