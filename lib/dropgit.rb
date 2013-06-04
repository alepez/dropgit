class Dropgit
  # -- public --
  public
  # Constructor
  # Show usage
  def help
  end
  # Start daemon
  # TODO: daemonize
  def start
    while true do
      p "."
      sleep 60
      out = `git status`
      unless out.include?("nothing to commit")
        message = "Dropgit: #{Time.new.to_s}"
        `git add . -A`
        `git commit -m '#{message}'`
        `git push`
      end
    end
  end
  # -- private --
  private
end
