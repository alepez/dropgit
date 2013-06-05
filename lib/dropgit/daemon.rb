require 'daemons'
require 'dropgit/repository.rb'
require 'dropgit/settings.rb'

module DropGit
  class Daemon
    def initialize
      @repositories = []
      DropGit.settings.repositories.each do |data|
        @repositories << Repository.new(data)
      end
    end

    # run
    def run
      loop do
        @repositories.each { |r| r.update }
        sleep 1
      end
    end

  end
end