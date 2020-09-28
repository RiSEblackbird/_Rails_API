# frozen_string_literal: true

module Api
  module V1
    class KeywordsController < ApplicationController
      before_action :set_keyword, only: %i[show update destroy]

      def index
        keywords = Keyword.order(created_at: :desc)
        render json: { status: 'SUCCESS', message: 'Loaded keywords', data: keywords }
      end

      def show
        render json: { status: 'SUCCESS', message: 'Loaded the keyword', data: @keyword }
      end

      def create
        keyword = Keyword.new(keyword_params)
        if keyword.save
          render json: { status: 'SUCCESS', data: keyword }
        else
          render json: { status: 'ERROR', data: keyword.errors }
        end
      end

      def destroy
        @keyword.destroy
        render json: { status: 'SUCCESS', message: 'Deleted the keyword', data: @keyword }
      end

      def update
        if @keyword.update(keyword_params)
          render json: { status: 'SUCCESS', message: 'Updated the keyword', data: @keyword }
        else
          render json: { status: 'SUCCESS', message: 'Not updated', data: @keyword.errors }
        end
      end

      private

      def set_keyword
        @keyword = Keyword.find(params[:id])
      end

      def keyword_params
        params.require(:keyword).permit(:word)
      end
    end
  end
end
