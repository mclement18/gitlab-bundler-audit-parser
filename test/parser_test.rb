# frozen_string_literal: true

require 'minitest/autorun'
require 'stringio'

require 'gitlab-bundler-audit-parser'

class ParserTest < Minitest::Test
  def mock_stdin(input, &_block)
    original_stream = $stdin
    $stdin = @mock = StringIO.new input
    yield
  ensure
    $stdin = original_stream
  end

  def test_parsing_no_vulnerabilities
    mock_stdin File.read("#{File.dirname(__FILE__)}/expect/bundler-audit/empty.json") do
      GitlabBundlerAuditParser::Parser.run outfile: "#{File.dirname(__FILE__)}/empty.json"
    end
    assert_equal File.read("#{File.dirname(__FILE__)}/expect/gitlab/empty.json"),
                 File.read("#{File.dirname(__FILE__)}/empty.json")
  ensure
    File.delete("#{File.dirname(__FILE__)}/empty.json")
  end

  def test_parsing_vulnerabilities
    mock_stdin File.read("#{File.dirname(__FILE__)}/expect/bundler-audit/vulnerabilities.json") do
      GitlabBundlerAuditParser::Parser.run outfile: "#{File.dirname(__FILE__)}/vulnerabilities.json"
    end
    assert_equal File.read("#{File.dirname(__FILE__)}/expect/gitlab/vulnerabilities.json"),
                 File.read("#{File.dirname(__FILE__)}/vulnerabilities.json")
  ensure
    File.delete("#{File.dirname(__FILE__)}/vulnerabilities.json")
  end
end
