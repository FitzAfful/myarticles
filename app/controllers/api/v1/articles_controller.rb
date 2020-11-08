module Api
    module V1
        class ArticlesController < ApplicationController
            skip_before_action :verify_authenticity_token
            def index
                articles = Article.order('created_at DESC')
                render json: {status: 'success', message: 'articles loaded successfully', data: articles}, status: :ok
            end

            def show
                article = Article.find(params[:id])
                render json: {status: 'success', message: 'article loaded successfully', data: article}, status: :ok
            end

            def create
                article = Article.new(article_params)

                if article.save
                    puts "A string".inspect
                    render json: {status: 'success', message: 'article saved successfully', data: article}, status: :ok
                else 
                    puts "Error string".inspect
                    render json: {status: 'error', message: 'article not saved', data: article.errors}, status: :unprocessable_entity
                end
            end

            def destroy
                article = Article.find(params[:id])
                article.destroy
                render json: {status: 'success', message: 'article deleted successfully'}, status: :ok
            end

            def update
                article = Article.find(params[:id])

                if article.update_attributes(article_params)
                    puts "A string".inspect
                    render json: {status: 'success', message: 'article updated successfully', data: article}, status: :ok
                else 
                    puts "Error string".inspect
                    render json: {status: 'error', message: 'article not updated', data: article.errors}, status: :unprocessable_entity
                end
            end

            private

            def article_params
                params.permit(:title, :body)
            end
        end
    end
end