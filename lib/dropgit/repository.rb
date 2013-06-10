module DropGit
  class Repository
    def self.create(path, remote)
      data = {
        'name' => File.basename(path),
        'path' => path
      }
      new_repo = Repository.new(data)
      new_repo.git_init(remote)
      new_repo
    end

    def initialize(data)
      @name = data['name']
      @path = data['path']
      @git_dir = File.join(DropGit.settings.git_base, @name)
      @git_cmd = "git --git-dir=#{@git_dir} --work-tree=#{@path}"
    end

    def update
      if need_sync?
        git_commit
        git_push
        puts "#{@name} remote was out of sync, pushed"
      end
      if git_pull
        puts "#{@name} local was out of sync, pulled"
      end
    end

    def git_init(remote)
      @remote = remote
      raise "Repository '#{@name}' already exists in '#{@git_dir}'" if File.exists?(@git_dir)
      puts "Initializing git repository in #{@git_dir} from data in #{@path}"
      puts git "init"
      puts git "add ."
      puts git "commit -m 'DropGit initial commit'"
      puts git "remote add origin #{@remote}"
      puts git "push -u origin master"
    end

    def data
      {
        'name' => @name,
        'path' => @path,
        'remote' => @remote
      }
    end

    # -- private --
    private

    # check if need sycronization
    def need_sync?
      out = git "status"
      !out.include?("nothing to commit")
    end

    def git_commit
      message = "Dropgit: #{Time.new.to_s}"
      git "add . -A"
      git "commit -m '#{message}'"
    end

    def git_push
      git "push origin master"
    end

    def git_pull
      out = git "pull origin master"
      out != "Already up-to-date.\n"
    end

    # call git
    def git(params)
      `#{@git_cmd} #{params}`
    end
  end
end
