require 'bundler'
Bundler::GemHelper.install_tasks

require 'spec/rake/spectask'

desc "Run all examples"
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['spec/**/*.rb']
end
