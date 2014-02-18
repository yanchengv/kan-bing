require 'rubygems'
require 'rufus/scheduler'
scheduler = Rufus::Scheduler.new

#@user=MimasDataSyncQueue.new
#@user.foreign_key=113921059357
#@user.code=3
#@user.table_name="User"
#@user.save
#@user=MimasDataSyncQueue.new
#@user.foreign_key=11392105929257
#@user.code=1
#@user.table_name="Patient"
#@user.save

#scheduler.every("10d") do
#  #sleep 20
#  puts Time.now
#end
scheduler.every("10s") do
  @DataSyncQueue=MimasDataSyncQueue.new
  data=@DataSyncQueue.scan
end
#scheduler.cron '21 16 * * *' do
#  puts "ruby"
#end
#
#scheduler.cron '26 16 * * *' do
#  puts Time.now
#end
#scheduler.join
#scheduler.cron '25 16 * * *' do
#  @user=User.first
#  puts @user.name
#  puts Time.now
#  puts "232323"
#end