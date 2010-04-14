set :cron_log, "#{RAILS_ROOT}/log/cron_log.log"

every :saturday, :at => "3:00 am" do
  rake "backup:app"
end
