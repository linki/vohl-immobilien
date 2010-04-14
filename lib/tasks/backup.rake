namespace :backup do
  task :app => :environment do
    system "astrails-safe -v #{RAILS_ROOT}/config/safe.conf"
  end
end