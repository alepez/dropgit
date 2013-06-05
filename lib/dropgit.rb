class Dropgit
  attr_accessor :git_name, :dropbox_name, :git_base, :dropbox_base, :git_dir, :work_tree
  # -- public --
  public
  # Constructor
  def initialize
    # TODO: load from settings
    @dropbox_base = '/home/pez/Dropbox'
    @git_base = '/home/pez/.dropgit/repositories'
  end
  # change paths
  def set_paths(repo_name, dropbox_name)
    @repo_name = repo_name
    @dropbox_name = dropbox_name
    @git_dir = File.join(@git_base, @repo_name)
    @work_tree = File.join(@dropbox_base, @dropbox_name)
    puts "#{@work_tree} <=> #{@git_dir}"
    ENV['GIT_DIR'] = @git_dir
    ENV['GIT_WORK_TREE'] = @work_tree
  end
  # Show usage
  def help
  end
  # Start daemon
  # TODO: daemonize
  def run
#    while true do
#      sleep 60
#      if need_sync?
#        push
#      end
#      pull
#    end
  end
  # -- private --
  private
  # check if need sycronization
  def need_sync?
    out = `git status`
    !out.include?("nothing to commit")
  end
  # syncronize
  def push
    message = "Dropgit: #{Time.new.to_s}"
    `git add . -A`
    `git commit -m '#{message}'`
    `git push`
  end
  # syncronize
  def pull
  end
end
