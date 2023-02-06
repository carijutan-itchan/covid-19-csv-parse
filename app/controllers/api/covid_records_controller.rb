class Api::CovidRecordsController < ApplicationController

  def index
    service = CovidRecordService.new(params: params)
    covid_records = service.get_covid_records

    render json: covid_records, each_serializer: CovidRecordsSerializer
  end

  def set_params
    params.permit(:observation_date, :max_results)
  end
end
