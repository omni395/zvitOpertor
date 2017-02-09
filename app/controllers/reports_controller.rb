class ReportsController < ApplicationController
  def index
    @payments_today = Payment.report_today
    @expences_today = Expence.report_today
  end

  def report
    @payments_today = Payment.report_today
    @payments_week = Payment.report_week
    @payments_month = Payment.report_month
    @payments_by_date = Payment.report_by_date(params[:start_date], params[:end_date])
    @expences_today = Expence.report_today
    @expences_week = Expence.report_week
    @expences_month = Expence.report_month
    @expences_by_date = Expence.report_by_date(params[:start_date], params[:end_date])
    respond_to do |format|
      format.pdf do
        render :pdf => "Report_from_#{(Date.today - 6.day).strftime('%d.%m.%Y')}_to_#{(Date.today).strftime('%d.%m.%Y')}",
               template: 'reports/pdf_report.html.haml',
               page_size: "A4",
               disposition: 'attachment'
      end
    end
  end

  def report_today
    @payments_today = Payment.report_today
    @expences_today = Expence.report_today
    respond_to do |format|
      format.js
    end
  end

  def report_week
    @payments_week = Payment.report_week
    @expences_week = Expence.report_week
    respond_to do |format|
      format.js
    end
  end

  def report_month
    @payments_month = Payment.report_month
    @expences_month = Expence.report_month
    respond_to do |format|
      format.js
    end
  end

  def report_by_date
    @payments_by_date = Payment.report_by_date(params[:start_date], params[:end_date])
    @expences_by_date = Expence.report_by_date(params[:start_date], params[:end_date])
    respond_to do |format|
      format.js
    end
  end

  private
    def material_params
      params.require(:report).permit(:start_date, :end_date)
    end
end