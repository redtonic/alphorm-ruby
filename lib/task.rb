require 'json'

# Task
# id, content, flags, is_done
#
# afficher
# done
class Task

	OPTIONS_DEFAULT = {
		flags: [],
		date: nil
	}

	# Retourne une tache
	def self.add params
		contenu = params.shift
		id = @tableau_taches.map(&:id).max+1

		new_task = Task.new id, contenu

		params.each do |argument|
			champ, valeur = argument.split(':')

			if champ == "flags"
				new_task.flags = value.split(',')
			else
				raise "Parametre incorrect: #{champ}"
			end
		end

		@tableau_taches << new_task
	end

	def self.get_task id
		@tableau_taches.select{|tache| tache.id==id }.first
	end

	def self.delete id
		@tableau_taches.reject!{ |tache| tache.id==id }
	end

	# Charge les taches depuis un fichier JSON
	def self.load file
		if File.exists?(file)
			str = File.read(file)
			tableau = JSON.parse(str)

			@tableau_taches = tableau.map do |tache|
				 Task.new(tache["id"], tache["content"], { flags: tache["flags"] } , tache["is_done"] )
			end
		else
			@tableau_taches = []
		end
	end

	# Sauvegarde les taches vers un fichier JSON
	def self.save file
		file = File.open(file, "w") do |file|
			file.write(@tableau_taches.to_json)
		end
	end

	def self.display
		puts "*****TASKMAN*****"
		puts "LISTE DES TACHES "

		@tableau_taches.each(&:display)
	end

	attr_accessor :id, :content, :flags
	attr_reader :is_done

	def initialize id, content, opts={}, is_done = false
		opts = OPTIONS_DEFAULT.merge(opts)

		@id = id
		@content = content
		@flags = opts[:flags]
		@is_done = is_done
	end

	def to_json opts={}
		{
			id: @id,
			content: @content,
			flags: @flags,
			is_done: @is_done
		}.to_json(opts)
	end

	def display
		puts "[#{ @is_done ? "X" : " " }] #{@id} - #{@content} (#{@flags.join(",")})"
	end

	def done
		@is_done = true
	end

	@tableau_taches = []
end
