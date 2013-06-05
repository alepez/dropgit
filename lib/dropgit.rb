require 'dropgit/settings'

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

  end
end