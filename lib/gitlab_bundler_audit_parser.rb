# frozen_string_literal: true

require 'json'
require 'gitlab_bundler_audit_parser/scan_section'
require 'gitlab_bundler_audit_parser/vulnerabilities_section'

module GitlabBundlerAuditParser
  class Parser
    include ScanSection
    include VulnerabilitiesSection

    def initialize(outfile: nil)
      @outfile = outfile || 'gl-dependency-scanning-report.json'
    end

    def self.run(outfile: nil)
      parser = new outfile: outfile
      parser.parse
      parser.create_audit
      parser.ouput_audit
    end

    def parse
      input = $stdin.read
      @parsed_audit = JSON.parse(input)
    end

    def create_audit
      @audit = {
        version: @parsed_audit['version']
      }
      @audit.merge! create_vulnerabilities_section(@parsed_audit)
      @audit.merge! create_scan_section(@parsed_audit)
    end

    def ouput_audit
      encoded = JSON.generate(@audit)
      File.write(@outfile, encoded)
    end
  end
end
