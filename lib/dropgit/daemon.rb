require 'daemons'

module DropGit
  class Daemon
    def initialize
      @repositories = []
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