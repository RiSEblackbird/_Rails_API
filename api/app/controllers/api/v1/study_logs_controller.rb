# frozen_string_literal: true

module Api
  module V1
    class StudyLogsController < ApplicationController
      before_action :set_stamp, only: %i[show update destroy]

      def index
        stamps = StudyLog.order(created_at: :desc)
        render json: { status: 'SUCCESS', message: 'Loaded stamps', data: stamps }
      end

      def show
        render json: { status: 'SUCCESS', message: 'Loaded the stamp', data: @study_log }
      end

      def create
        stamp = StudyLog.new(stamp_params)
        if stamp.save
          render json: { status: 'SUCCESS', data: stamp }
        else
          render json: { status: 'ERROR', data: stamp.errors }
        end
      end

      def destroy
        @study_log.destroy
        render json: { status: 'SUCCESS', message: 'Deleted the stamp', data: @study_log }
      end

      def update
        if @study_log.update(stamp_params)
          render json: { status: 'SUCCESS', message: 'Updated the stamp', data: @study_log }
        else
          render json: { status: 'SUCCESS', message: 'Not updated', data: @study_log.errors }
        end
      end

      private

      def set_stamp
        @study_log = StudyLog.find(params[:id])
      end

      def stamp_params
        params.require(:stamp).permit(:body)
      end
    end
  end
end
