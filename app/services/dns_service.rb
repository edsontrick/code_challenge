class DnsService
  def initialize(dns_records, params)
    @dns_records = dns_records
    @params = params
    @included = params[:included]&.split(',')
    @excluded = params[:excluded]&.split(',')
  end

  def call
    related_hostnames = []
    dns_records = @dns_records.select do |dns_record|
      dns_hostnames = dns_record.hostnames.pluck(:hostname)
      if @params[:included].present? || @params[:excluded].present?
        if @included
          if @included.all? { |i| dns_hostnames.include? i }
            dns_hostnames = dns_hostnames.reject { |dh| @included.include? dh }
          else
            next
          end
        end

        if @excluded
          if @excluded.none? { |i| dns_hostnames.include? i }
            dns_hostnames = dns_hostnames.reject { |dh| @excluded.include? dh }
          else
            next
          end
        end
      else
        dns_hostnames = dns_record.hostnames.pluck(:hostname)
      end
      related_hostnames.concat dns_hostnames
    end

    related_hostnames = related_hostnames.tally.map { |rh, count| { count: count, hostname: rh } }
    [dns_records, related_hostnames]
  end
end
