class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_resopnse
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_response

    def index
        tenants = Tenant.all
        render json: tenants
    end

    def show
        tenant = Tenant.find(params[:id])
        render json: tenant
    end

    def create
        tenant = Tenant.create!(tenant_params)
        render json: tenant
    end

    def update
        tenant = Tenant.find(params[:id])
        tenant.update!(tenant_params)
        render json: tenant
    end

    def destroy
        tenant = Tenant.find(params[:id])
        tenant.destroy
        head :no_content
    end

    private

    def render_not_found_resopnse
        render json: {error: "Not found"}, status: :not_found
    end

    def render_invalid_response(invalid)
        render json: {errors: invalid.record.errors}, status: :unprocessable_entity
    end

    def tenant_params
        params.permit(:name, :age)
    end
end
