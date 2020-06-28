# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  # GET /reports
  def index
    @reports = Report.where(user_id: current_user.followings).or(Report.where(user_id: current_user)).page(params[:page])
  end

  # GET /reports/1
  def show
    @comments = @report.comments
  end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit
    @report = current_user.reports.find(params[:id])
  end

  # POST /reports
  def create
    @report = current_user.reports.new(report_params)
    if @report.save
      redirect_to @report, notice: t("flash.notice.report.create")
    else
      render :new
    end
  end

  # PATCH/PUT /reports/1
  def update
    if @report = current_user.reports.find(params[:id])
      @report.update(report_params)
      redirect_to @report, notice: t("flash.notice.report.update")
    else
      render :edit
    end
  end

  # DELETE /reports/1
  def destroy
    @report = current_user.reports.find(params[:id])
    @report.destroy
    redirect_to reports_url, notice: t("flash.notice.report.destroy")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def report_params
      params.require(:report).permit(:title, :body)
    end
end
