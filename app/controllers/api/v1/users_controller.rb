# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_request, except: :create
      before_action :set_user, except: :create

      def show
        render_json @user
      end

      def create
        @user = User.new(user_params)
        if @user.save
          render json: { success: true, email: @user.email }, status: 201
        else
          render json: { error: @user.errors }, status: 422
        end
      end

      def update
        if @customer
          @customer.update(customer_params)
          render json: { message: 'Customer successfully updated.' }
        else
          render json: { error: 'Unable to update Customer.' }
        end
      end

      def destroy
        if @customer
          @customer.destroy
          render json: { message: 'User successfully deleted.' }
        elsif customer.blank?
          render json: { errors: 'User not found.' }, status: 404
        else
          render json: { error: 'Unable to delete user.' }, status: 404
        end
      end

      private

      def user_params
        params.permit(:email, :password, :password_confirmation)
      end

      def set_user
        @user = User.find(params[:id])
      end

      def render_json(user)
        render json: UserSerializer.new(user).serializable_hash.to_json
      end
    end
  end
end
