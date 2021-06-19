# frozen_string_literal: true

module Api
  module V1
    class ArticlesController < ApplicationController
      before_action :authorize_request, except: %i[index show]
      before_action :set_article, only: %i[update destroy]

      def index
        @articles = Article.all.order('created_at DESC')
        render_json @articles
      end

      def show
        @article = Article.find(params[:id])
        render_json @article
      end

      def create
        @article = @current_user.articles.build(article_params)
        if @article.save
          render json: { success: true, title: @article.title }, status: 201
        else
          render json: { error: @article.errors }, status: 422
        end
      end

      def update
        if @article
          @article.update(article_params)
          render json: { message: 'Article successfully updated.' }
        else
          render json: { error: 'Unable to update article.' }
        end
      end

      def destroy
        if @article
          @article.destroy
          render json: { message: 'Article successfully deleted.' }
        elsif @article.blank?
          render json: { errors: 'Atricle not found.' }, status: 404
        else
          render json: { error: 'Unable to delete article.' }, status: 404
        end
      end

      private

      def article_params
        params.permit(:title, :body, :category)
      end

      def set_article
        @article = @current_user.articles.find(params[:id])
      end

      def render_json(article)
        render json: ArticleSerializer.new(article).serializable_hash.to_json
      end
    end
  end
end
