module Api
  module V1
    class ArticlesController < ApplicationController
      def index
        @articles = Article.order(created_at: :asc)
        render json: { status: 'SUCCESS', message: 'Articles fetched successfully', data: @articles }, status: :ok
      end

      def show
        @article = Article.find(params[:id])
        render json: { status: 'SUCCESS', message: 'Article fetched successfully', data: @article }, status: :ok
      end

      def create
        @article = Article.new(article_params)
        if @article.save
          render json: { status: 'SUCCESS', message: 'Article created successfully', data: @article }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Article could not be created', data: @article.errors },
                 status: :unprocessable_entity
        end
      end

      def destroy
        @article = Article.find(params[:id])
        if @article.destroy
          render json: { status: 'SUCCESS', message: 'Article deleted successfully' }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Article could not be deleted' }, status: :unprocessable_entity
        end
      end

      def update
        @article = Article.find(params[:id])
        if @article.update
          render json: { status: 'SUCCESS', message: 'Article updated successfully', data: @article }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Article could not be updated', data: @article.errors },
                 status: :unprocessable_entity
        end
      end

      private

      def article_params
        params.permit(:title, :body)
      end
    end
  end
end
