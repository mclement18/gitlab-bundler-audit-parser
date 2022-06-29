# frozen_string_literal: true

module GitlabBundlerAuditParser
  module VulnerabilitiesSection
    private

    def create_vulnerabilities_section(audit)
      {
        vulnerabilities: parse_vulnerabilities(audit)
      }
    end

    def parse_vulnerabilities(audit)
      vulnerabilities = []
      audit['results'].each do |result|
        vulnerabilities << parse_vulnerability(result)
      end
      vulnerabilities
    end

    def parse_vulnerability(result)
      vulnerability = {
        id: result['advisory']['id'],
        category: 'dependency_scanning',
        name: result['advisory']['title'],
        message: result['advisory']['title'],
        description: result['advisory']['description'],
        cve: result['advisory']['cve'],
        severity: result['advisory']['criticality'],
        solution: solution(result)
      }
      vulnerability.merge! scanner
      vulnerability.merge! location(result)
      vulnerability.merge! identifiers(result)
      vulnerability.merge! links(result)
      vulnerability.merge! details(result)
    end

    def solution(result)
      "Upgrade to #{result['advisory']['patched_versions'].join(', ')}"
    end

    def scanner
      {
        scanner: {
          id: 'bundler-audit',
          name: 'BundlerAudit'
        }
      }
    end

    def location(result)
      {
        location: {
          file: 'Gemfile.lock',
          dependency: {
            package: {
              name: result['gem']['name']
            },
            version: result['gem']['version']
          }
        }
      }
    end

    def identifiers(result)
      {
        identifiers: [
          {
            type: 'cve',
            name: "CVE-#{result['advisory']['cve']}",
            value: "CVE-#{result['advisory']['cve']}",
            url: result['advisory']['url']
          }
        ]
      }
    end

    def links(result)
      {
        links: [
          {
            url: result['advisory']['url']
          }
        ]
      }
    end

    def details(result)
      {
        details: {
          vulnerable_package: {
            name: 'Vulnerable Package',
            type: 'text',
            value: "#{result['gem']['name']}:#{result['gem']['version']}"
          }
        }
      }
    end
  end
end
