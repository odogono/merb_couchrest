# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{merb_couchrest}
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Alexander Veenendaal"]
  s.date = %q{2009-02-18}
  s.description = %q{Merb ORM plugin that provides support for CouchRest Models.}
  s.email = %q{odogono@gmail.com}
  s.files = %w(LICENSE README Rakefile TODO Generators) + Dir.glob("{lib,spec}/**/*")
  s.has_rdoc = false
  s.homepage = %q{http://github.com/mohiam/merb_couchrest}
  s.require_paths = ["lib"]
  s.summary = %q{Merb ORM plugin for CouchRest.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<merb>, [">= 1.0.9"])
      s.add_runtime_dependency(%q<couchrest>, [">= 0.13.3"])
    else
      s.add_dependency(%q<merb>, [">= 1.0.9"])
      s.add_dependency(%q<couchrest>, [">= 0.13.3"])
    end
  else
    s.add_dependency(%q<merb>, [">= 1.0.9"])
    s.add_dependency(%q<couchrest>, [">= 0.13.3"])
  end
end
