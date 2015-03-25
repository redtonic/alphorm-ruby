class Object
	def try *args
		if nil?
			nil
		else
			send *args
		end
	end
end