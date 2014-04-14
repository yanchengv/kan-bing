class AppointmentArrange < ActiveRecord::Base
  after_create :mimas_sync_create
  before_update :mimas_sync_update
  before_destroy :mimas_sync_destroy
  attr_accessible :schedule_id,
                  :time_arrange,
                  :doctor_id,
                  :schedule_date,
                  :status

  def mimas_sync_update
    @str = {}
    self.changes.each do |k, v|
      @str[k.to_sym]=v[1]
    end
    @mimas = MimasDataSyncQueue.new(:foreign_key => self.id, :table_name => 'AppointmentArrange',  :code => 3, :contents => @str.to_json(:except => [:updated_at]).to_s)
    @mimas.save
  end

  def mimas_sync_create
    @mimas = MimasDataSyncQueue.new(:foreign_key => self.id, :table_name => 'AppointmentArrange',  :code => 1, :contents => '')
    @mimas.save
  end

  def mimas_sync_destroy
    @mimas = MimasDataSyncQueue.new(:foreign_key => self.id, :table_name => 'AppointmentArrange',  :code => 2, :contents => '')
    @mimas.save
  end
end
