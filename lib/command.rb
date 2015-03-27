
module Command
	@commands = {}

	def self.register action
		@commands[action.command] = action
	end


	def self.launch!
		command = ARGV.shift

		is_executed = false

		@commands.each do |k, action|
			if k == command
				is_executed = true
				action.apply(ARGV)
			end
		end

		unless is_executed
			display_help
		end
	end

	def self.display_help
		puts "taskman [commande] [contenu|id] [options...]"
		puts "--------------------------------------------"
		@commands.each do |k, action|
			puts action.to_s
		end
	end

	class Action
		attr_accessor :command, :arguments, :description, :block

		def initialize command, arguments, description, &block
			@command = command
			@block = block
			@arguments = arguments
			@description = description
		end

		def apply arguments
			begin
				block.call(arguments)
			rescue TaskmanError => e
				puts "ERREUR: #{e.message.light_red.bold}"
			end
		end

		def register!
			Command.register(self)
		end

		def to_s
			puts "#{@command} #{@arguments}\t * #{@description}"
		end
	end

	class TaskAction < Action
		def initialize command, arguments, description, &block
			super command, arguments, description, &block
		end

		def apply arguments
			id = arguments.shift.to_i
			task = Task.get_task(id)

			if task.nil?
				puts "La tache #{id} n'existe pas!"
				exit
			end

			begin
				block.call(task, arguments)
			rescue TaskmanError => e
				puts "ERREUR: #{e.message.light_red.bold}"
			end
		end

		def to_s
			puts "#{@command} :id #{@arguments}\t * #{@description}"
		end
	end

	def self.define &block
		CommandDSL.new(&block)
	end

	class CommandDSL
		def initialize &block
			instance_eval(&block)
		end

		def args str
			@args = str
		end

		def desc str
			@desc = str
		end

		def action name, &block
			Command::Action.new(name.to_s, @args, @desc, &block).register!

			@args = ""
			@desc = ""
		end

		def task_action name, &block
			Command::TaskAction.new(name.to_s, @args, @desc, &block).register!

			@args = ""
			@desc = ""
		end
	end

end


