module Api
  module V1
    class DnsRecordsController < ApplicationController
      # GET /dns_records
      def index
        dns_records = DnsRecord.all

        dns_records, related_hostnames = DnsService.new(dns_records, params).call

        if params[:page].present?
          render json: { records: dns_records, total_records: dns_records.count, related_hostnames: related_hostnames }, status: :ok
        else
          render json: {}, status: :unprocessable_entity
        end
      end

      # POST /dns_records
      def create
        dns_record = DnsRecord.new(dns_record_params)

        if dns_record.save
          render json: dns_record, status: :ok
        else
          render json: dns_record.errors, status: :internal_server_error
        end
      end

      private

      def dns_record_params
        params.require(:dns_records).permit(:ip, hostnames_attributes: [:hostname])
      end
    end
  end
end
