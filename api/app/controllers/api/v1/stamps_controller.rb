# frozen_string_literal: true

module Api
  module V1
    class StampsController < ApplicationController
      before_action :set_stamp, only: %i[show update destroy]

      def index
        stamps = Stamp.order(created_at: :desc)
        render json: { status: 'SUCCESS', message: 'Loaded stamps', data: stamps }
      end

      def show
        render json: { status: 'SUCCESS', message: 'Loaded the stamp', data: @stamp }
      end

      def create
        stamp = Stamp.new(stamp_params)
        if stamp.save
          render json: { status: 'SUCCESS', data: stamp }
        else
          render json: { status: 'ERROR', data: stamp.errors }
        end
      end

      def destroy
        @stamp.destroy
        render json: { status: 'SUCCESS', message: 'Deleted the stamp', data: @stamp }
      end

      def update
        if @stamp.update(stamp_params)
          render json: { status: 'SUCCESS', message: 'Updated the stamp', data: @stamp }
        else
          render json: { status: 'SUCCESS', message: 'Not updated', data: @stamp.errors }
        end
      end

      private

      def set_stamp
        @stamp = Stamp.find(params[:id])
      end

      def stamp_params
        params.require(:stamp).permit(:word)
      end
    end
  end
end
