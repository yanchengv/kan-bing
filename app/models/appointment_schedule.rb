#author:wangfang
class AppointmentSchedule < ActiveRecord::Base
  after_create :minas_sync_create
  before_update :minas_sync_update
  before_destroy :mimas_sync_destroy
  belongs_to :dictionary, :foreign_key => :dictionary_id
  has_many :appointment_avalibles
  attr_accessible :avalailbecount, :dayofweek, :doctor_id, :timeblock, :dictionary_id ,:remaining_num

  def minas_sync_update
    @str = {}
    self.changes.each do |k, v|
      @str[k.to_sym]=v[1]
    end
    @minas = MimasDataSyncQueue.new(:foreign_key => self.id, :table_name => 'AppointmentSchedule',  :code => 3, :contents => @str.to_json(:except => [:updated_at]).to_s)
    @minas.save
  end

  def minas_sync_create
    @minas = MimasDataSyncQueue.new(:foreign_key => self.id, :table_name => 'AppointmentSchedule',  :code => 1, :contents => '')
    @minas.save
  end

  def mimas_sync_destroy
    @mimas = MimasDataSyncQueue.new(:foreign_key => self.id, :table_name => 'AppointmentSchedule',  :code => 2, :contents => '')
    @mimas.save
  end

end
