require 'yaml'

module DropGit
  # Manage DropGit settings
  class Settings
    @@directory = File.join(Dir.home, ".dropgit")
    @@filename = File.join(@@directory, "settings")
    # Constructor
    def initialize
      Dir.mkdir(@@directory) unless Dir.exists?(@@directory)
      load
    end

    def add(path)
      basename = File.basename(path)
      repository = {
        :name => basename,
        :path => path
      }
      @repositories << repository
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
          # TODO: add accessor
        end
      end
      # defaults
      @repositories = [] unless @repositories
      @dropbox_base = File.join(Dir.home, "Dropbox") unless @dropbox_base
      @git_base =  File.join(Dir.home, ".dropgit", "repositories") unless @git_base
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