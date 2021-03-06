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
      repos = DropGit.settings.repositories
      length = {}
      repos.each do |repo|
        repo.each do |key, val|
          if length[key]
            if val.length > length[key]
              length[key] = val.length
            end
          else
            length[key] = val.length
          end
        end
      end
      head = "|"
      length.each do |key, val|
        head << " " << key.ljust(val + 2) << "|"
      end
      puts "-" * head.length
      puts head
      puts "-" * head.length
      repos.each do |repo|
        line = "|"
        repo.each do |key, val|
          line << " " << val.ljust(length[key] + 2) << "|"
        end
        puts line
      end
    end

    # start daemon
    def start
      Daemon.new.start
    end

    # debug daemon
    def run
      Daemon.new.run
    end

    def stop
      Daemon.new.stop
    end

  end
end