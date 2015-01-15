class DiagnoseTreatController < ApplicationController
  skip_before_filter :verify_authenticity_token


     def show
        if current_user.doctor_id.nil?
          patient_id=current_user.id
        else
          patient_id
        end

         @diagnose_treats=DiagnoseTreat.where(patient_id:patient_id)
        render partial:'patients/diagnose_treat'
     end
  def show_treat_left
    if current_user.doctor_id.nil?
      patient_id=current_user.id
    else
      patient_id
    end

    @diagnose_treats=DiagnoseTreat.where(patient_id:patient_id)
    render partial: 'patients/diagnose_treat_left'
  end
  def show_treat_right
    render partial: 'patients/diagnose_treat_right'
  end

    def create
            diagnose_treat_param={};
            diagnose_treat_param[:name]=params[:name]
            diagnose_treat_param[:doctor_id]=params[:doctor_id]
            diagnose_treat_param[:patient_id]=params[:patient_id]
            diagnose_treat_param[:create_time]=params[:create_time]
            diagnose_treat_param[:doctor_name]=params[:doctor_name]

             @diagnose_treat=DiagnoseTreat.new(diagnose_treat_param)
             @diagnose_treat.save

          # render partial: 'patients/diagnose_treat'
          redirect_to action: :show_treat_left
        end

        def destroy
            id=params[:id]
            @diagnose_treat=DiagnoseTreat.where(id).first
              if  @diagnose_treat
                @diagnose_treat.destroy
              end

        end
end
