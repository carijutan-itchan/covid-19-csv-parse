class CovidRecordService
  def initialize(params:)
    @params = params
  end

  def get_covid_records
    if @params["observation_date"].present? && @params["max_results"].present?
      CovidObservation.search_by_obsercation_date(@params["observation_date"]).limit(@params["max_results"])
    elsif @params["observation_date"].present? && @params["max_results"].nil?
      CovidObservation.search_by_obsercation_date(@params["observation_date"])
    elsif @params["observation_date"].nil? && @params["max_results"].present?
      CovidObservation.all.limit(@params["max_results"])
    else
      CovidObservation.all
    end
  end

end