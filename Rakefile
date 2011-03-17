#require File.expand_path('../../config/application', __FILE__)

require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/packagetask'
require 'rake/gempackagetask'

spec = eval(File.read('spree_social.gemspec'))

Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
end

desc "Release to gemcutter"
task :release => :package do
  require 'rake/gemcutter'
  Rake::Gemcutter::Tasks.new(spec).define
  Rake::Task['gem:push'].invoke
end

desc "Default Task"
task :default => [ :spec ]

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new

desc "Regenerates a rails 3 app for testing"
task :test_app do
  require '../spree/lib/generators/spree/test_app_generator'
  class AuthTestAppGenerator < Spree::Generators::TestAppGenerator
    def tweak_gemfile
      append_file 'Gemfile' do
<<-gems
        gem 'spree_core', :path => \'#{File.join(File.dirname(__FILE__), "../spree/", "core")}\'
        gem 'spree_auth', :path => \'#{File.join(File.dirname(__FILE__), "../spree/", "auth")}\'
        gem 'devise', "1.2.rc2"
        gem 'spree_social', :path => \'#{File.dirname(__FILE__)}\'
gems
      end
    end

    def install_gems
      inside "test_app" do
        run 'bundle install'
        run 'rake spree_core:install'
        run 'rake spree_auth:install'
        run 'rake spree_social:install'
      end
    end

    def migrate_db
      run_migrations
    end
  end
  AuthTestAppGenerator.start
end
# require 'cucumber/rake/task'
# Cucumber::Rake::Task.new do |t|
#   t.cucumber_opts = %w{--format pretty}
# end