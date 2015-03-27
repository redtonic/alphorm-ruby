require 'time'

# Task
# id, content, flags, is_done
#
# afficher
# done
class Task

	OPTIONS_DEFAULT = {
		flags: []
	}

	# Retourne une tache
	def self.add params
		contenu = params.shift

		id = (@tableau_taches.map(&:id).max||-1) +1

		if contenu.nil?
			raise TaskmanError, "Add a besoin d'un parametre"
		end

		hash = {}
		params.each do |param|
			k,v = param.split(':')
			hash[k.to_sym] = v
		end

		new_task = Task.new id, contenu, hash

		@tableau_taches << new_task
	end

	def self.clear
		@tableau_taches = []
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
				opts = tache.reject{|k,v| ["id", "content", "is_done"].include?(k)  }
				Task.new(tache["id"], tache["content"], opts , tache["is_done"] )
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

	def self.display filtre={}
		puts "*****TASKMAN*****".bold.white
		puts "LISTE DES TACHES ".bold.white

		@tableau_taches.reject do |t|
			x = filtre.map do |k,v|
				field_val = t.send(k)

				if field_val.is_a?(Array)
					field_val.include?(v)
				else
					!!(field_val.to_s =~ /^#{v}/)
				end
			end

			x.uniq.include?(false)
		end.each(&:display)
	end

	attr_accessor :id, :content, :flags, :date
	attr_reader :is_done

	def flags= x
		if x
			if x.is_a?(Array)
				@flags = x
			elsif x.is_a?(String)
				@flags = x.split(",")
			else
				raise "flags= #{x.class} Impossible."
			end
		else
			@date = x
		end
	end

	def date= x
		if x
			if x.is_a?(Time)
				@date = x
			elsif x.is_a?(String)
				@date = Time.parse(x)
			else
				raise "date= #{x.class} Impossible."
			end
		else
			@date = x
		end
	end

	def initialize id, content, opts={}, is_done = false
		opts = OPTIONS_DEFAULT.merge(opts)

		@id = id
		@content = content

		opts.each do |k,v|
			if respond_to?("#{k}=")
				send("#{k}=", v)
			else
				raise "Je ne connais pas ce champ: #{k}"
			end
		end

		@is_done = is_done
	end

	def to_json opts={}
		{
			id: @id,
			content: @content,
			flags: @flags,
			date: @date,
			is_done: @is_done
		}.to_json(opts)
	end

	def display
		puts "[#{ @is_done ? "X".green : ".".red }] #{@id.to_s.light_blue} - #{@content.bold.white} (#{@flags.join(",")}) - #{ @date.try(:strftime, "%Y-%m-%d")}"
	end

	def done
		@is_done = true
	end

	@tableau_taches = []
end
