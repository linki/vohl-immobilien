desc 'Continuous build target'
task :cruise do
  out = ENV['CC_BUILD_ARTIFACTS']
  mkdir_p out unless File.directory? out if out

  Rake::Task["metrics:all_with_migrate"].invoke

  Rake::Task["doc:diagrams"].invoke
  mv 'doc/controllers.png', "#{out}" if out  
  mv 'doc/models.png', "#{out}" if out
  
  Rake::Task["svn:stats"].invoke
  mv 'tmp/svn-stats', "#{out}/svn-stats" if out
  
  Rake::Task["doc:app"].invoke
  mv 'doc/app', "#{out}/api_doc" if out
end