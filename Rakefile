require 'rubygems'
require 'rake/gempackagetask'

require 'merb-core'
require 'merb-core/tasks/merb'

GEM_NAME = "merb_couchrest"
GEM_VERSION = "0.1.6"
AUTHOR = "Alexander Veenendaal"
EMAIL = "odogono@gmail.com"
HOMEPAGE = "http://github.com/mohiam/merb_couchrest"
SUMMARY = "Merb ORM plugin that provides support for CouchRest Models"

spec = Gem::Specification.new do |s|
  s.name = GEM_NAME
  s.version = GEM_VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README", "LICENSE", 'TODO']
  s.summary = SUMMARY
  s.description = s.summary
  s.author = AUTHOR
  s.email = EMAIL
  s.homepage = HOMEPAGE
  s.add_dependency('merb', '>= 1.0.9')
  s.add_dependency("mattetti-couchrest",    ">= 0.20")
  s.require_path = 'lib'
  s.files = %w(LICENSE README Rakefile TODO Generators) + Dir.glob("{lib,spec}/**/*")
  
end

desc "install the plugin as a gem"
task :install do
  Merb::RakeHelper.install(GEM_NAME, :version => GEM_VERSION)
end

desc "Uninstall the gem"
task :uninstall do
  Merb::RakeHelper.uninstall(GEM_NAME, :version => GEM_VERSION)
end

desc "Create a gemspec file"
task :gemspec do
  File.open("#{GEM_NAME}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end
