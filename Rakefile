require 'rake'
require 'rake/testtask'
require 'rake/packagetask'
require 'rubygems/package_task'
require 'rspec/core/rake_task'

begin
  require 'spree/testing_support/common_rake'
rescue LoadError
  raise "Could not find spree/testing_support/common_rake. You need to run this command using Bundler."
  exit
end


RSpec::Core::RakeTask.new

task :default => [:spec]

spec = eval(File.read('spree_social.gemspec'))

Gem::PackageTask.new(spec) do |p|
  p.gem_spec = spec
end

desc "Release to gemcutter"
task :release => :package do
  require 'rake/gemcutter'
  Rake::Gemcutter::Tasks.new(spec).define
  Rake::Task['gem:push'].invoke
end

desc "Generates a dummy app for testing"
task :test_app do
  ENV['LIB_NAME'] = 'spree_social'
  Rake::Task['common:test_app'].invoke("Spree::User")
end
