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
        sleep 600
      end
    end

    # start daemon
    def start
      raise "DropGit daemon already started" if is_running
      Daemons.daemonize({
        :app_name => 'dropgit',
        :dir_mode => :normal,
        :dir => DropGit.settings.daemon_dir,
        :log_output => true
      })
      run
    end

    def stop
      raise "DropGit daemon is already stopped" unless File.exists?(pid_file)
      Process.kill("INT", pid)
    end

    # -- private ---
    private

    def pid_file
      "#{DropGit.settings.daemon_dir}/dropgit.pid"
    end

    def pid
      `cat #{pid_file}`.to_i
    end

    def is_running
      return false unless File.exists?(pid_file)
      begin
        Process.kill(0, pid)
        return true
      rescue Exception => e
        p "PID: #{e.message}"
        return false
      end
    end

  end
end
