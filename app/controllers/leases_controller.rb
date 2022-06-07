class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_resopnse
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_response

    def create
        lease = Lease.create!(lease_params)
        render json: lease, status: :created
    end

    def destroy
        lease = Lease.find(params[:id])
        lease.destroy
        head :no_content
    end

    private

    def render_not_found_resopnse
        render json: {error: "Not found"}, status: :not_found
    end

    def render_invalid_response(invalid)
        render json: {errors: invalid.record.errors}, status: :unprocessable_entity
    end

    def lease_params
        params.permit(:rent, :apartment_id, :tenant_id)
    end
end
