#encoding:utf-8
namespace :db  do
  task seed:  :environment do
    appointment_schedules_data
  end
end
def appointment_schedules_data
  AppointmentSchedule.delete_all
  AppointmentSchedule.create(
      doctor_id:@doctor3.id,
      schedule_date:'2014-03-25',
      start_time:'13:00:00',
      end_time:'15:00:00',
      remaining_num:4,
      status:1,
      avalailbecount:4
  )
  AppointmentSchedule.create(
      doctor_id:@doctor3.id,
      schedule_date:'2014-04-18',
      start_time:'09:00:00',
      end_time:'11:00:00',
      remaining_num:4,
      status:1,
      avalailbecount:4
  )
  AppointmentSchedule.create(
      doctor_id:@doctor4.id,
      schedule_date:'2014-04-11',
      start_time:'14:00:00',
      end_time:'15:00:00',
      remaining_num:4,
      status:1,
      avalailbecount:4
  )
  AppointmentSchedule.create(
      doctor_id:@doctor4.id,
      schedule_date:'2014-03-19',
      start_time:'08:00:00',
      end_time:'09:00:00',
      remaining_num:4,
      status:1,
      avalailbecount:4
  )
  AppointmentSchedule.create(
      doctor_id:@doctor6.id,
      schedule_date:'2014-04-18',
      start_time:'09:00:00',
      end_time:'11:00:00',
      remaining_num:4,
      status:1,
      avalailbecount:4
  )
  AppointmentSchedule.create(
      doctor_id:@doctor6.id,
      schedule_date:'2014-03-22',
      start_time:'09:00:00',
      end_time:'12:00:00',
      remaining_num:4,
      status:1,
      avalailbecount:4
  )
  AppointmentSchedule.create(
      doctor_id:@doctor6.id,
      schedule_date:'2014-04-15',
      start_time:'10:00:00',
      end_time:'11:00:00',
      remaining_num:4,
      status:1,
      avalailbecount:4
  )
  AppointmentSchedule.create(
      doctor_id:@doctor6.id,
      schedule_date:'2014-03-20',
      start_time:'15:00:00',
      end_time:'16:00:00',
      remaining_num:4,
      status:1,
      avalailbecount:4
  )
  AppointmentSchedule.create(
      doctor_id:@doctor8.id,
      schedule_date:'2014-04-21',
      start_time:'09:00:00',
      end_time:'10:00:00',
      remaining_num:4,
      status:1,
      avalailbecount:4
  )
  AppointmentSchedule.create(
      doctor_id:@doctor8.id,
      schedule_date:'2014-04-18',
      start_time:'11:00:00',
      end_time:'12:00:00',
      remaining_num:6,
      status:1,
      avalailbecount:6
  )
  AppointmentSchedule.create(
      doctor_id:@doctor29.id,
      schedule_date:'2014-04-14',
      start_time:'09:00:00',
      end_time:'10:00:00',
      remaining_num:4,
      status:1,
      avalailbecount:4
  )
  AppointmentSchedule.create(
      doctor_id:@doctor1.id,
      schedule_date:'2014-04-15',
      start_time:'10:30:00',
      end_time:'12:00:00',
      remaining_num:6,
      status:1,
      avalailbecount:6
  )
  AppointmentSchedule.create(
      doctor_id:@doctor1.id,
      schedule_date:'2014-04-15',
      start_time:'14:30:00',
      end_time:'16:00:00',
      remaining_num:4,
      status:1,
      avalailbecount:4
  )
  AppointmentSchedule.create(
      doctor_id:@doctor1.id,
      schedule_date:'2014-03-16',
      start_time:'11:00:00',
      end_time:'12:00:00',
      remaining_num:6,
      status:1,
      avalailbecount:6
  )
  AppointmentSchedule.create(
      doctor_id:@doctor6.id,
      schedule_date:'2014-04-8',
      start_time:'16:00:00',
      end_time:'17:00:00',
      remaining_num:4,
      status:1,
      avalailbecount:4
  )
  AppointmentSchedule.create(
      doctor_id:@doctor4.id,
      schedule_date:'2014-04-12',
      start_time:'13:30:00',
      end_time:'15:00:00',
      remaining_num:4,
      status:1,
      avalailbecount:4
  )
  AppointmentSchedule.create(
      doctor_id:@doctor4.id,
      schedule_date:'2014-03-21',
      start_time:'11:00:00',
      end_time:'12:00:00',
      remaining_num:6,
      status:1,
      avalailbecount:6
  )
  AppointmentSchedule.create(
      doctor_id:@doctor4.id,
      schedule_date:'2014-03-13',
      start_time:'16:00:00',
      end_time:'17:00:00',
      remaining_num:4,
      status:1,
      avalailbecount:4
  )
  AppointmentSchedule.create(
      doctor_id:@doctor19.id,
      schedule_date:'2014-03-29',
      start_time:'10:00:00',
      end_time:'11:00:00',
      remaining_num:4,
      status:1,
      avalailbecount:4
  )
  AppointmentSchedule.create(
      doctor_id:@doctor22.id,
      schedule_date:'2014-03-30',
      start_time:'09:00:00',
      end_time:'12:00:00',
      remaining_num:6,
      status:1,
      avalailbecount:6
  )
  AppointmentSchedule.create(
      doctor_id:@doctor22.id,
      schedule_date:'2014-04-16',
      start_time:'16:00:00',
      end_time:'18:00:00',
      remaining_num:4,
      status:1,
      avalailbecount:4
  )
  AppointmentSchedule.create(
      doctor_id:@doctor16.id,
      schedule_date:'2014-04-15',
      start_time:'09:00:00',
      end_time:'11:00:00',
      remaining_num:6,
      status:1,
      avalailbecount:6
  )
  AppointmentSchedule.create(
      doctor_id:@doctor16.id,
      schedule_date:'2014-04-23',
      start_time:'11:00:00',
      end_time:'12:00:00',
      remaining_num:4,
      status:1,
      avalailbecount:4
  )
  AppointmentSchedule.create(
      doctor_id:@doctor17.id,
      schedule_date:'2014-04-26',
      start_time:'15:30:00',
      end_time:'16:30:00',
      remaining_num:4,
      status:1,
      avalailbecount:4
  )
  AppointmentSchedule.create(
      doctor_id:@doctor18.id,
      schedule_date:'2014-04-17',
      start_time:'11:00:00',
      end_time:'12:00:00',
      remaining_num:4,
      status:1,
      avalailbecount:4
  )
end
