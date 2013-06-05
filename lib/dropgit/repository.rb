module DropGit
  class Repository
    def initialize(name)
      @repo_name = name
      @dropbox_name = name
      @git_dir = File.join(DropGit.settings.git_base, @repo_name)
      @work_tree = File.join(DropGit.settings.dropbox_base, @dropbox_name)
      puts "#{@work_tree} <=> #{@git_dir}"
    end

    def update
      if need_sync?
        # push
      end
      # pull
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
end