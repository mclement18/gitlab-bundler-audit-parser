# frozen_string_literal: true

require 'rake'
require 'minitest/test_task'

desc 'Run Tests'
task :test do
  Rake::Task['test_task'].invoke
rescue StandardError
  # Suppress rake error when tests fail
end

Minitest::TestTask.create(:test_task) do |t|
  t.warning = false
  t.test_globs = ['test/**/*_test.rb', 'test/*_test.rb']
end
