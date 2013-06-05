require 'dropgit/settings'
require 'dropgit/repository'
require 'dropgit/daemon'

module DropGit
  def self.settings=(settings)
    @settings = settings
  end

  def self.settings
    @settings
  end

  class App
    # -- public --
    public
    # Constructor
    def initialize
      DropGit.settings = Settings.new
    end

    # Show usage
    def help
    end
    
    # Initialize repository for current directory
    def init(remote)
      raise "Specify a remote repository" unless remote
      new_repo = Repository.create(Dir.pwd, remote)
      DropGit.settings.add_repo new_repo
    end
    
    def git(name)
      repo = DropGit.settings.repositories.select { |data| data['name'] == name }
    end
    
    def list
      #DropGit.settings.repositories.each { |data| puts "#{data['name']} => #{data['path']}" }
    end

    # start daemon
    def start
      daemon = Daemon.new
      daemon.run
    end
    
    # start daemon
    def run
      daemon = Daemon.new
      daemon.run
    end

  end
end