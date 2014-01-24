# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','geeknote','version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'geeknote'
  s.version = GeekNote::VERSION
  s.author = ["Ma Lucheng"]
  s.email = ["mlc880926@gmail.com"]
  s.homepage = 'http://your.website.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'geeknote ruby clone'
# Add your other files here if you make them
  s.files = %w(
bin/geeknote
lib/geeknote/version.rb
lib/geeknote.rb
  )
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','geeknote.rdoc']
  s.rdoc_options << '--title' << 'geeknote' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'geeknote'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_runtime_dependency('gli','2.8.0')
  s.add_runtime_dependency('mechanize')
  s.add_runtime_dependency('evernote_oauth')
  s.add_runtime_dependency('netrc')
end
