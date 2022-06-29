# frozen_string_literal: true
require 'time'

module GitlabBundlerAuditParser
  module ScanSection
    private

    def create_scan_section(audit)
      {
        scan: {
          scanner: {
            id: 'bundler-audit',
            name: 'BundlerAudit',
            url: 'https://github.com/rubysec/bundler-audit',
            vendor: {
              name: 'rubysec'
            },
            version: audit['version']
          },
          type: 'dependency_scanning',
          start_time: parse_time(audit['created_at']),
          end_time: parse_time(audit['created_at']),
          status: 'success'
        }
      }
    end

    def parse_time(time)
      Time.parse(time).strftime('%FT%T%:z')
    end
  end
end
