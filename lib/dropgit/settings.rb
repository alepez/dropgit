require 'yaml'

module DropGit
  # Manage DropGit settings
  class Settings
    attr_accessor :repositories, :git_base
    @@directory = File.join(Dir.home, ".dropgit")
    @@filename = File.join(@@directory, "settings")
    # Constructor
    def initialize
      Dir.mkdir(@@directory) unless Dir.exists?(@@directory)
      load
    end

    def add_repo(repository)
      @repositories << repository.data
      save
    end

    # --- private ---
    private

    # load
    def load
      if File.readable?(@@filename)
        data = YAML::load(File.read(@@filename))
        data.each do |key, val|
          instance_variable_set("@#{key}", val)
        end
      end
      # defaults
      @git_base =  File.join(Dir.home, ".dropgit", "repositories") unless @git_base
      Dir.mkdir(@git_base) unless Dir.exists?(@git_base)
      @repositories = [] unless @repositories
      save
    end

    # save
    def save
      data = {}
      instance_variables.each {|var| data[var.to_s.delete("@")] = instance_variable_get(var) }
      YAML::dump(data, File.open(@@filename, 'w'))
      YAML::dump(data)
    end
  end
end