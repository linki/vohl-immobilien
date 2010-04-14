namespace :svn do
  task :stats do
    out = "tmp/svn-stats"
    mkdir_p out unless File.directory? out if out
    
    system "rm -rf #{out}/*"
    system "svn log --xml -v > #{out}/svn.log"
    system "java -jar script/statsvn.jar -output-dir #{out} #{out}/svn.log ."
    system "rm #{out}/svn.log"     
  end
end
