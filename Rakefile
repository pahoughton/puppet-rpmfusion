require 'rake'
require 'rspec/core/rake_task'

desc "Test prep with librarian-puppet"
task :unittest_prep do
 sh "librarian-puppet install --path=spec/fixtures/modules/"
end

desc "Unit tests"
RSpec::Core::RakeTask.new(:unittest) do |t|
#  t.rspec_opts = ['--format=d']
  t.pattern = 'spec/unit/**/*_spec.rb'
end
