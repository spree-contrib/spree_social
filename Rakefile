# encoding: utf-8
require 'bundler'
Bundler::GemHelper.install_tasks
Bundler.setup

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new

require 'spree/core/testing_support/common_rake'

desc "Default Task"
task :default => [ :spec ]

namespace :test_app do
  desc 'Rebuild test and cucumber databases'
  task :rebuild_dbs do
    system("cd spec/test_app && rake db:drop db:migrate RAILS_ENV=test && rake db:drop db:migrate RAILS_ENV=cucumber")
  end
end

desc "Generates a dummy app for testing"
task :test_app do
  ENV['LIB_NAME'] = 'spree_social'
  Rake::Task['common:test_app'].invoke
end
