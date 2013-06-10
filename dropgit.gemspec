Gem::Specification.new do |s|
  s.name        = 'dropgit'
  s.version     = '0.0.2'
  s.date        = '2013-06-10'
  
  s.summary     = "Drop Git"
  s.description = "Automagically put on git version control system a Dropbox folder"
  
  s.authors     = ["Alessandro Pezzato"]
  s.email       = 'alessandro@pezzato.net'
  s.homepage    = 'http://pezzato.net/projects/dropgit.html'

  s.files       << "lib/dropgit.rb"
  s.files       << "lib/dropgit/daemon.rb"
  s.files       << "lib/dropgit/repository.rb"
  s.files       << "lib/dropgit/settings.rb"

  s.executables << "dropgit"

  s.add_dependency('daemons')
end

